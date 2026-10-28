import 'dart:math' as math;
import 'package:test/test.dart';
import 'package:twist_out/domain/model/geometry.dart';

void main() {
  group('Vector2D Math & Transformations', () {
    test('vector arithmetic operations', () {
      const v1 = Vector2D(x: 2.0, y: 3.0);
      const v2 = Vector2D(x: 1.0, y: -1.0);

      expect(v1 + v2, equals(const Vector2D(x: 3.0, y: 2.0)));
      expect(v1 - v2, equals(const Vector2D(x: 1.0, y: 4.0)));
      expect(v1 * 2.5, equals(const Vector2D(x: 5.0, y: 7.5)));
      expect(v1.dot(v2), equals(2.0 * 1.0 + 3.0 * -1.0));
    });

    test('vector length and distance', () {
      const v = Vector2D(x: 3.0, y: 4.0);
      expect(v.lengthSquared, equals(25.0));
      expect(v.length, equals(5.0));

      const other = Vector2D(x: 6.0, y: 8.0);
      expect(v.distanceTo(other), equals(5.0));
    });

    test('vector rotation by 90 degrees', () {
      const v = Vector2D(x: 1.0, y: 0.0);
      final rotated = v.rotate(math.pi / 2.0);
      expect(rotated.x, closeTo(0.0, 1e-9));
      expect(rotated.y, closeTo(1.0, 1e-9));
    });
  });

  group('Polygon Point-In-Polygon & Margin', () {
    const square = Polygon(vertices: [
      Vector2D(x: 0.0, y: 0.0),
      Vector2D(x: 2.0, y: 0.0),
      Vector2D(x: 2.0, y: 2.0),
      Vector2D(x: 0.0, y: 2.0),
    ]);

    test('point strictly inside polygon', () {
      expect(square.containsPoint(const Vector2D(x: 1.0, y: 1.0)), isTrue);
      expect(square.containsPoint(const Vector2D(x: 0.5, y: 1.5)), isTrue);
    });

    test('point strictly outside polygon without margin', () {
      expect(square.containsPoint(const Vector2D(x: 3.0, y: 1.0)), isFalse);
      expect(square.containsPoint(const Vector2D(x: -0.5, y: 1.0)), isFalse);
      expect(square.containsPoint(const Vector2D(x: 1.0, y: 2.2)), isFalse);
    });

    test('point outside but within margin', () {
      // Point at x=2.1, y=1.0 is 0.1 away from right edge
      const nearPoint = Vector2D(x: 2.1, y: 1.0);
      expect(square.containsPoint(nearPoint, margin: 0.05), isFalse);
      expect(square.containsPoint(nearPoint, margin: 0.15), isTrue);
    });

    test('polygon transformation (scale, rotate, translate)', () {
      // Square scaled by 2, rotated by 90 deg, translated by (5, 5)
      final transformed = square.transform(
        translation: const Vector2D(x: 5.0, y: 5.0),
        rotation: math.pi / 2.0,
        scale: 2.0,
      );

      // (0,0) * 2 -> (0,0) -> rotate -> (0,0) -> + (5,5) = (5,5)
      // (1,1) in local space * 2 = (2,2) -> rotated = (-2, 2) -> + (5,5) = (3, 7)
      expect(transformed.containsPoint(const Vector2D(x: 3.0, y: 7.0)), isTrue);
      expect(transformed.containsPoint(const Vector2D(x: 0.0, y: 0.0)), isFalse);
    });
  });

  group('Rect2D', () {
    test('contains check', () {
      const rect = Rect2D(x: 10.0, y: 20.0, width: 30.0, height: 40.0);
      expect(rect.contains(const Vector2D(x: 15.0, y: 25.0)), isTrue);
      expect(rect.contains(const Vector2D(x: 5.0, y: 25.0)), isFalse);
    });
  });
}
