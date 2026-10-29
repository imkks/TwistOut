import 'package:test/test.dart';
import 'package:twist_out/domain/levels/level_data.dart';
import 'package:twist_out/domain/model/elements.dart';

void main() {
  group('LevelCatalog Validation Tests', () {
    test('contains at least 10 playable levels', () {
      expect(LevelCatalog.levels.length, greaterThanOrEqualTo(10));
    });

    for (final level in LevelCatalog.levels) {
      test('Level ${level.id} (${level.title}) passes structural validation', () {
        expect(level.trayLimit, greaterThanOrEqualTo(4));
        expect(level.plates, isNotEmpty);
        expect(level.screws, isNotEmpty);
        expect(level.boxQueue, isNotEmpty);

        final state = level.buildInitialState();
        expect(state.status, GameStatus.playing);
        expect(state.activeBoxes, isNotEmpty);

        // Invariant: Screw count per color is multiple of 3 and equals 3 * count of that color in boxQueue
        final colorCounts = <int, int>{};
        for (final s in level.screws.values) {
          colorCounts[s.color] = (colorCounts[s.color] ?? 0) + 1;
        }

        final queueCounts = <int, int>{};
        for (final c in level.boxQueue) {
          queueCounts[c] = (queueCounts[c] ?? 0) + 1;
        }

        for (final entry in colorCounts.entries) {
          expect(
            entry.value % 3,
            equals(0),
            reason: 'Level ${level.id} color ${entry.key} count ${entry.value} must be a multiple of 3',
          );
          expect(
            entry.value,
            equals((queueCounts[entry.key] ?? 0) * 3),
            reason: 'Level ${level.id} color ${entry.key} screw count must match boxQueue count * 3',
          );
        }
      });
    }
  });
}
