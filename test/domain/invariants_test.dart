import 'dart:math' as math;
import 'package:test/test.dart';
import 'package:twist_out/domain/model/elements.dart';
import 'package:twist_out/domain/model/game_state.dart';
import 'package:twist_out/domain/model/geometry.dart';
import 'package:twist_out/domain/rules/commands.dart';
import 'package:twist_out/domain/rules/events.dart';
import 'package:twist_out/domain/rules/reducer.dart';

void main() {
  group('Domain Rules Invariants (TDD Section 4.3)', () {
    test('Invariant 5: Determinism — same state + command yields identical outputs', () {
      final state = _createTestLevel();
      const command = TapScrew('s_0_0');

      final result1 = step(state, command);
      final result2 = step(state, command);

      expect(result1.state, equals(result2.state));
      expect(result1.events, equals(result2.events));
    });

    test('Invariant 3: Blocked screw tap causes zero state change beyond rejection', () {
      final state = _createLevelWithBlockedScrew();
      const command = TapScrew('blocked_screw');

      final result = step(state, command);
      expect(result.state, equals(state));
      expect(
        result.events,
        equals([const ScrewRejected('blocked_screw', RejectionReason.screwBlocked)]),
      );
    });

    test('Invariants 1, 2, 4 across 50 random playout simulations', () {
      final rng = math.Random(42);

      for (int run = 0; run < 50; run++) {
        var state = _createRandomBalancedLevel(rng);
        final initialTotalScrews = state.screwsOnBoard.length;
        int clearedScrews = 0;

        // Invariant 2: Total screws per color is multiple of 3
        final colorCounts = <int, int>{};
        for (final s in state.screwsOnBoard.values) {
          colorCounts[s.color] = (colorCounts[s.color] ?? 0) + 1;
        }
        for (final count in colorCounts.values) {
          expect(count % 3, equals(0), reason: 'Each color must have screws in multiples of 3');
        }

        // Play up to 40 random steps
        for (int stepIdx = 0; stepIdx < 40; stepIdx++) {
          if (state.status != GameStatus.playing) break;

          // Pick a random available screw from the board (can be blocked or unblocked)
          final screwIds = state.screwsOnBoard.keys.toList();
          if (screwIds.isEmpty) break;
          final pickedId = screwIds[rng.nextInt(screwIds.length)];

          final result = step(state, TapScrew(pickedId));

          // Track cleared screws from BoxCleared events
          for (final event in result.events) {
            if (event is BoxCleared) {
              clearedScrews += 3;
            }
          }

          state = result.state;

          // Invariant 4: Tray never holds more than its limit
          expect(
            state.trayOccupancy,
            lessThanOrEqualTo(state.tray.length),
            reason: 'Tray cannot exceed allocated limit',
          );

          // Invariant 1: Conservation of Screws
          final boardCount = state.screwsOnBoard.length;
          final trayCount = state.trayOccupancy;
          final activeBoxesScrews = state.activeBoxes.fold<int>(0, (sum, b) => sum + b.count);
          final currentTotal = boardCount + trayCount + activeBoxesScrews + clearedScrews;

          expect(
            currentTotal,
            equals(initialTotalScrews),
            reason: 'Invariant 1 violation at step $stepIdx: total screws must be conserved',
          );
        }
      }
    });
  });
}

GameState _createTestLevel() {
  const plate = Plate(
    id: 'p1',
    layer: 0,
    shape: Polygon(vertices: [
      Vector2D(x: 0, y: 0),
      Vector2D(x: 1, y: 0),
      Vector2D(x: 1, y: 1),
      Vector2D(x: 0, y: 1),
    ]),
    pos: Vector2D(x: 0, y: 0),
    rot: 0,
    scale: 1,
  );

  return GameState.initial(
    plates: {'p1': plate},
    screwsOnBoard: {
      's_0_0': const Screw(
        id: 's_0_0',
        plateId: 'p1',
        anchorIndex: 0,
        color: 0,
        pos: Vector2D(x: 0.2, y: 0.2),
      ),
      's_0_1': const Screw(
        id: 's_0_1',
        plateId: 'p1',
        anchorIndex: 1,
        color: 0,
        pos: Vector2D(x: 0.4, y: 0.4),
      ),
      's_0_2': const Screw(
        id: 's_0_2',
        plateId: 'p1',
        anchorIndex: 2,
        color: 0,
        pos: Vector2D(x: 0.6, y: 0.6),
      ),
    },
    initialBoxQueue: [0],
  );
}

GameState _createLevelWithBlockedScrew() {
  const pBottom = Plate(
    id: 'p_bottom',
    layer: 0,
    shape: Polygon(vertices: [
      Vector2D(x: 0, y: 0),
      Vector2D(x: 1, y: 0),
      Vector2D(x: 1, y: 1),
      Vector2D(x: 0, y: 1),
    ]),
    pos: Vector2D(x: 0, y: 0),
    rot: 0,
    scale: 1,
  );

  return GameState.initial(
    plates: {'p_bottom': pBottom},
    screwsOnBoard: {
      'blocked_screw': const Screw(
        id: 'blocked_screw',
        plateId: 'p_bottom',
        anchorIndex: 0,
        color: 0,
        pos: Vector2D(x: 0.5, y: 0.5),
        isBlocked: true,
      ),
    },
    initialBoxQueue: [0],
  );
}

GameState _createRandomBalancedLevel(math.Random rng) {
  final numBoxes = 2 + rng.nextInt(3); // 2 to 4 boxes
  final colors = <int>[];
  for (int i = 0; i < numBoxes; i++) {
    colors.add(rng.nextInt(3)); // colors 0, 1, 2
  }

  final screws = <String, Screw>{};
  final plates = <String, Plate>{};

  // Create 2 plates
  for (int p = 0; p < 2; p++) {
    final pid = 'plate_$p';
    plates[pid] = Plate(
      id: pid,
      layer: p,
      shape: const Polygon(vertices: [
        Vector2D(x: 0, y: 0),
        Vector2D(x: 1, y: 0),
        Vector2D(x: 1, y: 1),
        Vector2D(x: 0, y: 1),
      ]),
      pos: const Vector2D(x: 0, y: 0),
      rot: 0,
      scale: 1,
    );
  }

  int screwIdx = 0;
  for (final color in colors) {
    // 3 screws per box
    for (int k = 0; k < 3; k++) {
      final sid = 'screw_$screwIdx';
      final pid = 'plate_${rng.nextInt(2)}';
      screws[sid] = Screw(
        id: sid,
        plateId: pid,
        anchorIndex: k,
        color: color,
        pos: Vector2D(x: rng.nextDouble(), y: rng.nextDouble()),
        isBlocked: false,
      );
      screwIdx++;
    }
  }

  return GameState.initial(
    plates: plates,
    screwsOnBoard: screws,
    initialBoxQueue: colors,
    trayLimit: 5,
  );
}
