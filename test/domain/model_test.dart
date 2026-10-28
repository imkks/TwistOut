import 'package:test/test.dart';
import 'package:twist_out/domain/model/elements.dart';
import 'package:twist_out/domain/model/geometry.dart';

void main() {
  group('Domain Models', () {
    test('Screw model instantiation and JSON round-trip', () {
      const screw = Screw(
        id: 's1',
        plate: 'p1',
        anchor: 0,
        color: 2,
        isBlocked: false,
      );

      final json = screw.toJson();
      final fromJson = Screw.fromJson(json);

      expect(fromJson, equals(screw));
      expect(fromJson.id, equals('s1'));
      expect(fromJson.plate, equals('p1'));
      expect(fromJson.anchor, equals(0));
      expect(fromJson.color, equals(2));
      expect(fromJson.isBlocked, isFalse);
    });

    test('Plate model instantiation and JSON round-trip', () {
      const plate = Plate(
        id: 'p1',
        layer: 1,
        shape: 'plank_l',
        pos: [0.5, 0.62],
        rot: 0.2,
        scale: 1.0,
      );

      final json = plate.toJson();
      final fromJson = Plate.fromJson(json);

      expect(fromJson, equals(plate));
      expect(fromJson.id, equals('p1'));
      expect(fromJson.layer, equals(1));
      expect(fromJson.shape, equals('plank_l'));
      expect(fromJson.pos, equals([0.5, 0.62]));
      expect(fromJson.rot, equals(0.2));
      expect(fromJson.scale, equals(1.0));
    });

    test('Box model instantiation and JSON round-trip', () {
      const box = Box(color: 3, count: 2);
      final json = box.toJson();
      final fromJson = Box.fromJson(json);

      expect(fromJson, equals(box));
      expect(fromJson.color, equals(3));
      expect(fromJson.count, equals(2));
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
}
