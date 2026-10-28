import 'package:test/test.dart';
import 'package:twist_out/domain/model/elements.dart';
import 'package:twist_out/domain/model/game_state.dart';
import 'package:twist_out/domain/model/geometry.dart';
import 'package:twist_out/domain/rules/commands.dart';
import 'package:twist_out/domain/rules/events.dart';
import 'package:twist_out/domain/rules/reducer.dart';

void main() {
  group('Domain Models', () {
    test('Screw model instantiation and JSON round-trip', () {
      const screw = Screw(
        id: 's1',
        plateId: 'p1',
        anchorIndex: 0,
        color: 2,
        pos: Vector2D(x: 0.5, y: 0.6),
        isBlocked: false,
      );

      final json = screw.toJson();
      final fromJson = Screw.fromJson(json);

      expect(fromJson, equals(screw));
      expect(fromJson.id, equals('s1'));
      expect(fromJson.plateId, equals('p1'));
      expect(fromJson.anchorIndex, equals(0));
      expect(fromJson.color, equals(2));
      expect(fromJson.pos, equals(const Vector2D(x: 0.5, y: 0.6)));
      expect(fromJson.isBlocked, isFalse);
    });

    test('Plate model instantiation and JSON round-trip', () {
      const plate = Plate(
        id: 'p1',
        layer: 1,
        shape: Polygon(vertices: [
          Vector2D(x: 0, y: 0),
          Vector2D(x: 1, y: 0),
          Vector2D(x: 1, y: 1),
          Vector2D(x: 0, y: 1),
        ]),
        pos: Vector2D(x: 0.5, y: 0.62),
        rot: 0.2,
        scale: 1.0,
      );

      final json = plate.toJson();
      final fromJson = Plate.fromJson(json);

      expect(fromJson, equals(plate));
      expect(fromJson.id, equals('p1'));
      expect(fromJson.layer, equals(1));
      expect(fromJson.pos, equals(const Vector2D(x: 0.5, y: 0.62)));
      expect(fromJson.rot, equals(0.2));
      expect(fromJson.scale, equals(1.0));
      expect(fromJson.present, isTrue);
      expect(plate.worldPolygon.vertices.length, equals(4));
    });

    test('BoxState model instantiation and JSON round-trip', () {
      const box = BoxState(color: 3, count: 2);
      final json = box.toJson();
      final fromJson = BoxState.fromJson(json);

      expect(fromJson, equals(box));
      expect(fromJson.color, equals(3));
      expect(fromJson.count, equals(2));
      expect(fromJson.isFull, isFalse);
      expect(fromJson.remainingCapacity, equals(1));

      const fullBox = BoxState(color: 3, count: 3);
      expect(fullBox.isFull, isTrue);
      expect(fullBox.remainingCapacity, equals(0));
    });

    test('GameState getters and JSON round-trip', () {
      final state = GameState.initial(
        plates: {},
        screwsOnBoard: {},
        initialBoxQueue: [0, 1, 2, 3],
        trayLimit: 2,
      );

      expect(state.isTrayFull, isFalse);
      expect(state.firstEmptyTrayIndex, equals(0));

      final json = state.toJson();
      final fromJson = GameState.fromJson(json);
      expect(fromJson.trayLimit, equals(2));
      expect(fromJson.status, equals(GameStatus.playing));
    });

    test('Vector2D and Rect2D geometry round-trip', () {
      const vec = Vector2D(x: 10.5, y: 20.25);
      final vecJson = vec.toJson();
      expect(Vector2D.fromJson(vecJson), equals(vec));

      const rect = Rect2D(x: 1.0, y: 2.0, width: 30.0, height: 40.0);
      final rectJson = rect.toJson();
      expect(Rect2D.fromJson(rectJson), equals(rect));
    });
  });

  group('Commands Equality & String Formatting', () {
    test('TapScrew equality and toString', () {
      const cmd1 = TapScrew('s1');
      const cmd2 = TapScrew('s1');
      const cmd3 = TapScrew('s2');

      expect(cmd1, equals(cmd2));
      expect(cmd1.hashCode, equals(cmd2.hashCode));
      expect(cmd1, isNot(equals(cmd3)));
      expect(cmd1.toString(), contains('TapScrew(s1)'));
    });

    test('UseBooster equality and toString', () {
      const b1 = UseBooster(BoosterType.extraSlot);
      const b2 = UseBooster(BoosterType.extraSlot);
      const b3 = UseBooster(BoosterType.magnet, 'target');

      expect(b1, equals(b2));
      expect(b1.hashCode, equals(b2.hashCode));
      expect(b1, isNot(equals(b3)));
      expect(b1.toString(), contains('extraSlot'));
    });

    test('GrantTraySlots equality and toString', () {
      const g1 = GrantTraySlots(3);
      const g2 = GrantTraySlots(3);
      const g3 = GrantTraySlots(2);

      expect(g1, equals(g2));
      expect(g1.hashCode, equals(g2.hashCode));
      expect(g1, isNot(equals(g3)));
      expect(g1.toString(), contains('GrantTraySlots(3)'));
    });
  });

  group('Events Equality & String Formatting', () {
    const screw = Screw(
      id: 's1',
      plateId: 'p1',
      anchorIndex: 0,
      color: 1,
      pos: Vector2D(x: 0, y: 0),
    );

    test('event equality and strings', () {
      expect(const ScrewLifted(screw), equals(const ScrewLifted(screw)));
      expect(const ScrewLifted(screw).toString(), contains('ScrewLifted'));

      expect(const ScrewMovedToBox(screw, 1), equals(const ScrewMovedToBox(screw, 1)));
      expect(const ScrewMovedToBox(screw, 1).toString(), contains('ScrewMovedToBox'));

      expect(const ScrewMovedToTray(screw, 2), equals(const ScrewMovedToTray(screw, 2)));
      expect(const ScrewMovedToTray(screw, 2).toString(), contains('ScrewMovedToTray'));

      expect(const TrayToBoxMove(screw, 0, 1), equals(const TrayToBoxMove(screw, 0, 1)));
      expect(const TrayToBoxMove(screw, 0, 1).toString(), contains('TrayToBoxMove'));

      expect(const BoxCleared(1, 0), equals(const BoxCleared(1, 0)));
      expect(const BoxCleared(1, 0).toString(), contains('BoxCleared'));

      expect(const BoxActivated(2, 1), equals(const BoxActivated(2, 1)));
      expect(const BoxActivated(2, 1).toString(), contains('BoxActivated'));

      expect(const PlateFell('p1'), equals(const PlateFell('p1')));
      expect(const PlateFell('p1').toString(), contains('PlateFell'));

      expect(
        const ScrewRejected('s1', RejectionReason.screwBlocked),
        equals(const ScrewRejected('s1', RejectionReason.screwBlocked)),
      );
      expect(
        const ScrewRejected('s1', RejectionReason.screwBlocked).toString(),
        contains('ScrewRejected'),
      );

      expect(
        const BoosterApplied(BoosterType.extraSlot),
        equals(const BoosterApplied(BoosterType.extraSlot)),
      );
      expect(
        const BoosterApplied(BoosterType.extraSlot).toString(),
        contains('BoosterApplied'),
      );

      expect(const TraySlotsGranted(2, 6), equals(const TraySlotsGranted(2, 6)));
      expect(const TraySlotsGranted(2, 6).toString(), contains('TraySlotsGranted'));

      expect(const Won(), equals(const Won()));
      expect(const Won().hashCode, equals(1));
      expect(const Won().toString(), equals('Won()'));

      expect(const Lost(), equals(const Lost()));
      expect(const Lost().hashCode, equals(2));
      expect(const Lost().toString(), equals('Lost()'));
    });

    test('StepResult equality and toString', () {
      final s = GameState.initial(plates: {}, screwsOnBoard: {}, initialBoxQueue: []);
      final res1 = StepResult(s, [const Won()]);
      final res2 = StepResult(s, [const Won()]);
      final res3 = StepResult(s, [const Lost()]);

      expect(res1, equals(res2));
      expect(res1.hashCode, equals(res2.hashCode));
      expect(res1, isNot(equals(res3)));
      expect(res1.toString(), contains('StepResult'));
    });
  });
}
