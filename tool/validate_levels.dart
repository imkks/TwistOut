// ignore_for_file: avoid_print
import 'package:twist_out/domain/levels/level_data.dart';
import 'package:twist_out/domain/model/elements.dart';

void main() {
  print('=== Twist Out Level Validator ===');
  int validCount = 0;

  for (final level in LevelCatalog.levels) {
    if (level.plates.isEmpty) {
      throw StateError('Level ${level.id}: plates cannot be empty');
    }
    if (level.screws.isEmpty) {
      throw StateError('Level ${level.id}: screws cannot be empty');
    }

    final state = level.buildInitialState();
    if (state.status != GameStatus.playing) {
      throw StateError('Level ${level.id}: initial state must be playing');
    }

    // Check color multiples of 3
    final colorCounts = <int, int>{};
    for (final s in level.screws.values) {
      colorCounts[s.color] = (colorCounts[s.color] ?? 0) + 1;
    }

    final queueCounts = <int, int>{};
    for (final c in level.boxQueue) {
      queueCounts[c] = (queueCounts[c] ?? 0) + 1;
    }

    for (final entry in colorCounts.entries) {
      if (entry.value % 3 != 0) {
        throw StateError(
          'Level ${level.id}: color ${entry.key} count ${entry.value} is not a multiple of 3',
        );
      }
      if (entry.value != (queueCounts[entry.key] ?? 0) * 3) {
        throw StateError(
          'Level ${level.id}: color ${entry.key} count does not match box queue',
        );
      }
    }

    validCount++;
    print('  ✓ Level ${level.id}: "${level.title}" passed (Plates: ${level.plates.length}, Screws: ${level.screws.length})');
  }

  print('\nAll $validCount levels validated successfully!');
}
