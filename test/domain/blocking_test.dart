import 'package:test/test.dart';
import 'package:twist_out/domain/model/elements.dart';
import 'package:twist_out/domain/model/geometry.dart';
import 'package:twist_out/domain/rules/blocking.dart';

void main() {
  group('BlockingEvaluator', () {
    const evaluator = BlockingEvaluator(screwRadius: 0.05);

    const plateBottom = Plate(
      id: 'p_bottom',
      layer: 0,
      shape: Polygon(vertices: [
        Vector2D(x: -0.5, y: -0.5),
        Vector2D(x: 0.5, y: -0.5),
        Vector2D(x: 0.5, y: 0.5),
        Vector2D(x: -0.5, y: 0.5),
      ]),
      pos: Vector2D(x: 0.5, y: 0.5),
      rot: 0.0,
      scale: 1.0,
      present: true,
    );

    const plateTop = Plate(
      id: 'p_top',
      layer: 1,
      shape: Polygon(vertices: [
        Vector2D(x: -0.2, y: -0.2),
        Vector2D(x: 0.2, y: -0.2),
        Vector2D(x: 0.2, y: 0.2),
        Vector2D(x: -0.2, y: 0.2),
      ]),
      pos: Vector2D(x: 0.5, y: 0.5),
      rot: 0.0,
      scale: 1.0,
      present: true,
    );

    final plates = {
      'p_bottom': plateBottom,
      'p_top': plateTop,
    };

    test('screw under higher layer plate is blocked', () {
      // Positioned at (0.5, 0.5) - inside both bottom and top plate
      const screwUnder = Screw(
        id: 's_under',
        plateId: 'p_bottom',
        anchorIndex: 0,
        color: 1,
        pos: Vector2D(x: 0.5, y: 0.5),
      );

      expect(evaluator.isBlocked(screwUnder, plates), isTrue);
    });

    test('screw on top plate is not blocked by lower layer plate', () {
      const screwOnTop = Screw(
        id: 's_top',
        plateId: 'p_top',
        anchorIndex: 0,
        color: 1,
        pos: Vector2D(x: 0.5, y: 0.5),
      );

      expect(evaluator.isBlocked(screwOnTop, plates), isFalse);
    });

    test('screw outside top plate is not blocked', () {
      // Positioned at (0.8, 0.8) - inside p_bottom (bounds [0.0, 1.0]), but outside p_top ([0.3, 0.7])
      const screwUncovered = Screw(
        id: 's_uncovered',
        plateId: 'p_bottom',
        anchorIndex: 1,
        color: 1,
        pos: Vector2D(x: 0.8, y: 0.8),
      );

      expect(evaluator.isBlocked(screwUncovered, plates), isFalse);
    });

    test('recalculateAll and updateAfterPlateFall', () {
      const screwUnder = Screw(
        id: 's_under',
        plateId: 'p_bottom',
        anchorIndex: 0,
        color: 1,
        pos: Vector2D(x: 0.5, y: 0.5),
      );

      final screws = {'s_under': screwUnder};
      final recalculated = evaluator.recalculateAll(screws, plates);
      expect(recalculated['s_under']!.isBlocked, isTrue);

      final candidates = evaluator.precomputeCandidateBlockers(screws, plates);
      expect(candidates['s_under'], contains('p_top'));

      // Plate falls
      final platesAfterFall = {
        'p_bottom': plateBottom,
        'p_top': plateTop.copyWith(present: false),
      };

      final updated = evaluator.updateAfterPlateFall(
        recalculated,
        platesAfterFall,
        candidates,
        'p_top',
      );

      expect(updated['s_under']!.isBlocked, isFalse);
    });
  });
}
