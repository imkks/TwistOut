import 'package:freezed_annotation/freezed_annotation.dart';

part 'geometry.freezed.dart';
part 'geometry.g.dart';

@freezed
class Vector2D with _$Vector2D {
  const factory Vector2D({
    required double x,
    required double y,
  }) = _Vector2D;

  factory Vector2D.fromJson(Map<String, dynamic> json) =>
      _$Vector2DFromJson(json);
}

@freezed
class Rect2D with _$Rect2D {
  const factory Rect2D({
    required double x,
    required double y,
    required double width,
    required double height,
  }) = _Rect2D;

  factory Rect2D.fromJson(Map<String, dynamic> json) => _$Rect2DFromJson(json);
}
