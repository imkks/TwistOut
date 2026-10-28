import 'dart:math' as math;
import 'package:twist_out/domain/model/elements.dart';
import 'package:twist_out/domain/model/game_state.dart';
import 'package:twist_out/domain/rules/blocking.dart';
import 'package:twist_out/domain/rules/commands.dart';
import 'package:twist_out/domain/rules/events.dart';

/// Encapsulates the output of a deterministic reducer step.
class StepResult {
  final GameState state;
  final List<GameEvent> events;

  const StepResult(this.state, this.events);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StepResult &&
          other.state == state &&
          _listEquals(other.events, events));

  @override
  int get hashCode => Object.hash(state, Object.hashAll(events));

  @override
  String toString() => 'StepResult(status: ${state.status}, events: $events)';

  static bool _listEquals(List<GameEvent> a, List<GameEvent> b) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}

/// Pure deterministic state reducer for Twist Out gameplay rules.
StepResult step(
  GameState state,
  Command command, {
  BlockingEvaluator blocking = const BlockingEvaluator(),
}) {
  return switch (command) {
    TapScrew(:final screwId) => _handleTapScrew(state, screwId, blocking),
    UseBooster(:final type, :final targetId) =>
      _handleUseBooster(state, type, targetId, blocking),
    GrantTraySlots(:final slots) => _handleGrantTraySlots(state, slots),
  };
}

StepResult _handleTapScrew(
  GameState state,
  String screwId,
  BlockingEvaluator blocking,
) {
  if (state.status != GameStatus.playing) {
    return StepResult(
      state,
      [ScrewRejected(screwId, RejectionReason.gameNotPlaying)],
    );
  }

  final screw = state.screwsOnBoard[screwId];
  if (screw == null) {
    return StepResult(
      state,
      [ScrewRejected(screwId, RejectionReason.screwNotFound)],
    );
  }

  if (screw.isBlocked) {
    return StepResult(
      state,
      [ScrewRejected(screwId, RejectionReason.screwBlocked)],
    );
  }

  // Check destination feasibility: active box with space OR empty tray slot.
  final activeBoxIndex = state.activeBoxes
      .indexWhere((box) => box.color == screw.color && box.count < 3);
  final emptyTrayIndex = state.firstEmptyTrayIndex;

  if (activeBoxIndex == -1 && emptyTrayIndex == -1) {
    return StepResult(
      state,
      [ScrewRejected(screwId, RejectionReason.trayFull)],
    );
  }

  final events = <GameEvent>[];
  events.add(ScrewLifted(screw));

  // 1. Remove screw from board.
  final newScrews = Map<String, Screw>.of(state.screwsOnBoard)..remove(screwId);
  final newPlates = Map<String, Plate>.of(state.plates);

  // 2. Check if the plate has any screws left.
  final remainingOnPlate =
      newScrews.values.where((s) => s.plateId == screw.plateId).length;
  if (remainingOnPlate == 0) {
    final plate = newPlates[screw.plateId];
    if (plate != null && plate.present) {
      newPlates[screw.plateId] = plate.copyWith(present: false);
      events.add(PlateFell(screw.plateId));
    }
  }

  // 3. Update blocking for remaining screws on the board.
  final updatedScrews = blocking.recalculateAll(newScrews, newPlates);

  // 4. Route screw to box or tray.
  final newBoxes = List<BoxState>.of(state.activeBoxes);
  final newTray = List<Screw?>.of(state.tray);
  final newQueue = List<int>.of(state.boxQueue);

  if (activeBoxIndex != -1) {
    final targetBox = newBoxes[activeBoxIndex];
    newBoxes[activeBoxIndex] = targetBox.copyWith(count: targetBox.count + 1);
    events.add(ScrewMovedToBox(screw, activeBoxIndex));
  } else {
    newTray[emptyTrayIndex] = screw;
    events.add(ScrewMovedToTray(screw, emptyTrayIndex));
  }

  // 5. Cascade box completion & tray auto-moves.
  _resolveBoxesAndTray(newBoxes, newQueue, newTray, events);

  // 6. Metrics update.
  final currentOccupancy = newTray.where((s) => s != null).length;
  final newPeak = math.max(state.trayPeak, currentOccupancy);

  // 7. Win / Lose check.
  var newStatus = GameStatus.playing;
  if (newBoxes.isEmpty && newQueue.isEmpty) {
    newStatus = GameStatus.won;
    events.add(const Won());
  } else if (newTray.every((s) => s != null)) {
    // Tray is full. Check if any unblocked screw matches an open active box.
    final hasMatchingMove = updatedScrews.values.any((s) {
      if (s.isBlocked) return false;
      return newBoxes.any((box) => box.color == s.color && box.count < 3);
    });

    if (!hasMatchingMove) {
      newStatus = GameStatus.lost;
      events.add(const Lost());
    }
  }

  final newState = state.copyWith(
    plates: newPlates,
    screwsOnBoard: updatedScrews,
    activeBoxes: newBoxes,
    boxQueue: newQueue,
    tray: newTray,
    status: newStatus,
    moves: state.moves + 1,
    trayPeak: newPeak,
  );

  return StepResult(newState, events);
}

void _resolveBoxesAndTray(
  List<BoxState> activeBoxes,
  List<int> queue,
  List<Screw?> tray,
  List<GameEvent> events,
) {
  bool changed = true;

  while (changed) {
    changed = false;

    // Check for full boxes (count == 3).
    for (int i = 0; i < activeBoxes.length; i++) {
      if (activeBoxes[i].count >= 3) {
        final clearedColor = activeBoxes[i].color;
        events.add(BoxCleared(clearedColor, i));

        if (queue.isNotEmpty) {
          final nextColor = queue.removeAt(0);
          activeBoxes[i] = BoxState(color: nextColor, count: 0);
          events.add(BoxActivated(nextColor, i));
        } else {
          // No more boxes in queue; remove cleared box.
          activeBoxes.removeAt(i);
        }
        changed = true;
        break; // Restart loop to maintain order.
      }
    }

    if (changed) continue;

    // Auto-move matching screws from tray into open active boxes.
    for (int t = 0; t < tray.length; t++) {
      final trayScrew = tray[t];
      if (trayScrew == null) continue;

      final targetBoxIdx = activeBoxes
          .indexWhere((b) => b.color == trayScrew.color && b.count < 3);

      if (targetBoxIdx != -1) {
        tray[t] = null;
        final box = activeBoxes[targetBoxIdx];
        activeBoxes[targetBoxIdx] = box.copyWith(count: box.count + 1);
        events.add(TrayToBoxMove(trayScrew, t, targetBoxIdx));
        changed = true;
        break; // Check for box completion immediately.
      }
    }
  }
}

StepResult _handleUseBooster(
  GameState state,
  BoosterType type,
  String? targetId,
  BlockingEvaluator blocking,
) {
  final events = <GameEvent>[];
  events.add(BoosterApplied(type));

  switch (type) {
    case BoosterType.extraSlot:
      final newTray = List<Screw?>.of(state.tray)..add(null);
      final newTotal = newTray.length;
      events.add(TraySlotsGranted(1, newTotal));

      final newState = state.copyWith(
        tray: newTray,
        trayLimit: state.trayLimit + 1,
        status: state.status == GameStatus.lost ? GameStatus.playing : state.status,
      );
      return StepResult(newState, events);

    case BoosterType.magnet:
      // Magnet pulls up to 3 matching screws from tray and board to complete the first open box.
      if (state.activeBoxes.isEmpty) {
        return StepResult(state, events);
      }

      final targetBoxIdx = state.activeBoxes.indexWhere((b) => b.count < 3);
      if (targetBoxIdx == -1) {
        return StepResult(state, events);
      }

      final targetColor = state.activeBoxes[targetBoxIdx].color;
      final newBoxes = List<BoxState>.of(state.activeBoxes);
      final newQueue = List<int>.of(state.boxQueue);
      final newTray = List<Screw?>.of(state.tray);
      final newScrews = Map<String, Screw>.of(state.screwsOnBoard);
      final newPlates = Map<String, Plate>.of(state.plates);

      // Pull from tray first.
      for (int t = 0; t < newTray.length; t++) {
        final s = newTray[t];
        if (s != null && s.color == targetColor) {
          final box = newBoxes[targetBoxIdx];
          if (box.count < 3) {
            newTray[t] = null;
            newBoxes[targetBoxIdx] = box.copyWith(count: box.count + 1);
            events.add(TrayToBoxMove(s, t, targetBoxIdx));
          }
        }
      }

      // Then pull from board (even if blocked).
      final boardMatching = newScrews.values
          .where((s) => s.color == targetColor)
          .toList(growable: false);

      for (final s in boardMatching) {
        final box = newBoxes[targetBoxIdx];
        if (box.count >= 3) break;

        newScrews.remove(s.id);
        events.add(ScrewLifted(s));
        newBoxes[targetBoxIdx] = box.copyWith(count: box.count + 1);
        events.add(ScrewMovedToBox(s, targetBoxIdx));

        // Check if plate fell.
        final remaining =
            newScrews.values.where((rem) => rem.plateId == s.plateId).length;
        if (remaining == 0) {
          final p = newPlates[s.plateId];
          if (p != null && p.present) {
            newPlates[s.plateId] = p.copyWith(present: false);
            events.add(PlateFell(s.plateId));
          }
        }
      }

      final updatedScrews = blocking.recalculateAll(newScrews, newPlates);
      _resolveBoxesAndTray(newBoxes, newQueue, newTray, events);

      var newStatus = state.status;
      if (newBoxes.isEmpty && newQueue.isEmpty) {
        newStatus = GameStatus.won;
        events.add(const Won());
      }

      final newState = state.copyWith(
        plates: newPlates,
        screwsOnBoard: updatedScrews,
        activeBoxes: newBoxes,
        boxQueue: newQueue,
        tray: newTray,
        status: newStatus,
      );
      return StepResult(newState, events);

    case BoosterType.smash:
      return StepResult(state, events);
  }
}

StepResult _handleGrantTraySlots(GameState state, int slots) {
  if (slots <= 0) return StepResult(state, const []);

  final newTray = List<Screw?>.of(state.tray)
    ..addAll(List<Screw?>.filled(slots, null));
  final newTotal = newTray.length;

  final events = <GameEvent>[
    TraySlotsGranted(slots, newTotal),
  ];

  final newState = state.copyWith(
    tray: newTray,
    trayLimit: state.trayLimit + slots,
    status: state.status == GameStatus.lost ? GameStatus.playing : state.status,
  );

  return StepResult(newState, events);
}
