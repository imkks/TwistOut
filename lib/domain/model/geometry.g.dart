// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geometry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Vector2D _$Vector2DFromJson(Map<String, dynamic> json) => _Vector2D(
  x: (json['x'] as num).toDouble(),
  y: (json['y'] as num).toDouble(),
);

Map<String, dynamic> _$Vector2DToJson(_Vector2D instance) => <String, dynamic>{
  'x': instance.x,
  'y': instance.y,
};

_Rect2D _$Rect2DFromJson(Map<String, dynamic> json) => _Rect2D(
  x: (json['x'] as num).toDouble(),
  y: (json['y'] as num).toDouble(),
  width: (json['width'] as num).toDouble(),
  height: (json['height'] as num).toDouble(),
);

Map<String, dynamic> _$Rect2DToJson(_Rect2D instance) => <String, dynamic>{
  'x': instance.x,
  'y': instance.y,
  'width': instance.width,
  'height': instance.height,
};

_Polygon _$PolygonFromJson(Map<String, dynamic> json) => _Polygon(
  vertices: (json['vertices'] as List<dynamic>)
      .map((e) => Vector2D.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PolygonToJson(_Polygon instance) => <String, dynamic>{
  'vertices': instance.vertices.map((e) => e.toJson()).toList(),
};
