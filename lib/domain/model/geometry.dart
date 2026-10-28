import 'dart:math' as math;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'geometry.freezed.dart';
part 'geometry.g.dart';

/// 2D Vector used for normalized board coordinates (x in [0, 1], y in [0, 1.25]).
@freezed
abstract class Vector2D with _$Vector2D {
  const Vector2D._();

  const factory Vector2D({
    required double x,
    required double y,
  }) = _Vector2D;

  factory Vector2D.fromJson(Map<String, dynamic> json) =>
      _$Vector2DFromJson(json);

  Vector2D operator +(Vector2D other) =>
      Vector2D(x: x + other.x, y: y + other.y);

  Vector2D operator -(Vector2D other) =>
      Vector2D(x: x - other.x, y: y - other.y);

  Vector2D operator *(double scalar) =>
      Vector2D(x: x * scalar, y: y * scalar);

  double dot(Vector2D other) => x * other.x + y * other.y;

  double get lengthSquared => x * x + y * y;

  double get length => math.sqrt(lengthSquared);

  double distanceTo(Vector2D other) => (this - other).length;

  /// Rotates the vector around origin (0, 0) by [radians].
  Vector2D rotate(double radians) {
    final cosA = math.cos(radians);
    final sinA = math.sin(radians);
    return Vector2D(
      x: x * cosA - y * sinA,
      y: x * sinA + y * cosA,
    );
  }
}

/// 2D Axis-aligned bounding rectangle.
@freezed
abstract class Rect2D with _$Rect2D {
  const Rect2D._();

  const factory Rect2D({
    required double x,
    required double y,
    required double width,
    required double height,
  }) = _Rect2D;

  factory Rect2D.fromJson(Map<String, dynamic> json) => _$Rect2DFromJson(json);

  bool contains(Vector2D point) {
    return point.x >= x &&
        point.x <= x + width &&
        point.y >= y &&
        point.y <= y + height;
  }
}

/// A 2D polygon defined by an ordered list of vertices.
@freezed
abstract class Polygon with _$Polygon {
  const Polygon._();

  const factory Polygon({
    required List<Vector2D> vertices,
  }) = _Polygon;

  factory Polygon.fromJson(Map<String, dynamic> json) =>
      _$PolygonFromJson(json);

  /// Checks if [point] is inside this polygon or within [margin] distance of its boundary.
  bool containsPoint(Vector2D point, {double margin = 0.0}) {
    if (vertices.length < 3) return false;

    // Ray-casting algorithm for strict containment.
    bool inside = false;
    final int n = vertices.length;
    for (int i = 0, j = n - 1; i < n; j = i++) {
      final vi = vertices[i];
      final vj = vertices[j];

      final intersects = ((vi.y > point.y) != (vj.y > point.y)) &&
          (point.x <
              (vj.x - vi.x) * (point.y - vi.y) / (vj.y - vi.y + 1e-12) + vi.x);
      if (intersects) {
        inside = !inside;
      }
    }

    if (inside) return true;
    if (margin <= 0.0) return false;

    // Check boundary distance within margin.
    final marginSq = margin * margin;
    for (int i = 0, j = n - 1; i < n; j = i++) {
      final a = vertices[j];
      final b = vertices[i];
      if (_distanceToSegmentSquared(point, a, b) <= marginSq) {
        return true;
      }
    }

    return false;
  }

  /// Transforms this polygon from local shape space to world space given
  /// plate position, rotation in radians, and uniform scale.
  Polygon transform({
    required Vector2D translation,
    required double rotation,
    required double scale,
  }) {
    final transformed = vertices.map((v) {
      final scaled = v * scale;
      final rotated = scaled.rotate(rotation);
      return rotated + translation;
    }).toList(growable: false);

    return Polygon(vertices: transformed);
  }

  static double _distanceToSegmentSquared(
    Vector2D p,
    Vector2D a,
    Vector2D b,
  ) {
    final ab = b - a;
    final ap = p - a;
    final abLenSq = ab.lengthSquared;

    if (abLenSq == 0.0) {
      return ap.lengthSquared;
    }

    final t = (ap.dot(ab) / abLenSq).clamp(0.0, 1.0);
    final projection = a + (ab * t);
    return (p - projection).lengthSquared;
  }
}
