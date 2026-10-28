// ignore_for_file: avoid_print
import 'dart:math' as math;
import 'package:twist_out/domain/model/elements.dart';
import 'package:twist_out/domain/model/game_state.dart';
import 'package:twist_out/domain/model/geometry.dart';
import 'package:twist_out/domain/rules/blocking.dart';
import 'package:twist_out/domain/rules/commands.dart';
import 'package:twist_out/domain/rules/reducer.dart';

void main(List<String> args) {
  print('=== Twist Out Game Simulation ===\n');

  final rng = math.Random(1337);
  final level = _generateSampleLevel();
  var state = level;

  print('Initial Level Setup:');
  print('  Plates: ${state.plates.length}');
  print('  Screws on Board: ${state.screwsOnBoard.length}');
  print('  Active Boxes: ${state.activeBoxes.map((b) => "Color ${b.color} (${b.count}/3)").join(", ")}');
  print('  Box Queue: ${state.boxQueue}');
  print('  Tray Capacity: ${state.tray.length}\n');

  int stepCount = 0;
  const maxSteps = 100;

  while (state.status == GameStatus.playing && stepCount < maxSteps) {
    stepCount++;

    // Find unblocked screws
    final freeScrews = state.screwsOnBoard.values
        .where((s) => !s.isBlocked)
        .toList(growable: false);

    if (freeScrews.isEmpty) {
      print('Step $stepCount: No free screws remaining!');
      break;
    }

    // Heuristic: prefer screws matching active boxes with open space; else random free screw
    Screw chosen = freeScrews[rng.nextInt(freeScrews.length)];
    for (final s in freeScrews) {
      if (state.activeBoxes.any((b) => b.color == s.color && b.count < 3)) {
        chosen = s;
        break;
      }
    }

    print('Step $stepCount: Tapping screw "${chosen.id}" (Color ${chosen.color})');
    final result = step(state, TapScrew(chosen.id));

    for (final event in result.events) {
      print('   -> Event: $event');
    }

    state = result.state;
    print('   State: Tray ${state.trayOccupancy}/${state.tray.length}, Status: ${state.status.name}\n');
  }

  print('=== Simulation Ended ===');
  print('Final Status: ${state.status.name.toUpperCase()}');
  print('Total Moves: ${state.moves}');
  print('Tray Peak Occupancy: ${state.trayPeak}');
  print('Remaining Board Screws: ${state.screwsOnBoard.length}');
}

GameState _generateSampleLevel() {
  const pBottom = Plate(
    id: 'p_base',
    layer: 0,
    shape: Polygon(vertices: [
      Vector2D(x: 0.1, y: 0.1),
      Vector2D(x: 0.9, y: 0.1),
      Vector2D(x: 0.9, y: 0.9),
      Vector2D(x: 0.1, y: 0.9),
    ]),
    pos: Vector2D(x: 0, y: 0),
    rot: 0,
    scale: 1,
  );

  const pTop = Plate(
    id: 'p_cover',
    layer: 1,
    shape: Polygon(vertices: [
      Vector2D(x: 0.3, y: 0.3),
      Vector2D(x: 0.7, y: 0.3),
      Vector2D(x: 0.7, y: 0.7),
      Vector2D(x: 0.3, y: 0.7),
    ]),
    pos: Vector2D(x: 0, y: 0),
    rot: 0,
    scale: 1,
  );

  final plates = {
    'p_base': pBottom,
    'p_cover': pTop,
  };

  // 6 screws: 3 of Color 0, 3 of Color 1
  final rawScrews = <String, Screw>{
    // Base screws: s_b0 is at (0.5, 0.5) - covered by p_cover!
    's_b0': const Screw(id: 's_b0', plateId: 'p_base', anchorIndex: 0, color: 0, pos: Vector2D(x: 0.5, y: 0.5)),
    's_b1': const Screw(id: 's_b1', plateId: 'p_base', anchorIndex: 1, color: 1, pos: Vector2D(x: 0.15, y: 0.15)),
    's_b2': const Screw(id: 's_b2', plateId: 'p_base', anchorIndex: 2, color: 1, pos: Vector2D(x: 0.85, y: 0.85)),

    // Top screws: all on top layer (not blocked)
    's_t0': const Screw(id: 's_t0', plateId: 'p_cover', anchorIndex: 0, color: 0, pos: Vector2D(x: 0.35, y: 0.35)),
    's_t1': const Screw(id: 's_t1', plateId: 'p_cover', anchorIndex: 1, color: 0, pos: Vector2D(x: 0.65, y: 0.35)),
    's_t2': const Screw(id: 's_t2', plateId: 'p_cover', anchorIndex: 2, color: 1, pos: Vector2D(x: 0.5, y: 0.65)),
  };

  const blocking = BlockingEvaluator();
  final screws = blocking.recalculateAll(rawScrews, plates);

  return GameState.initial(
    plates: plates,
    screwsOnBoard: screws,
    initialBoxQueue: [0, 1], // Boxes for colors 0 and 1
    trayLimit: 4,
  );
}
