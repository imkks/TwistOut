// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'elements.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Screw _$ScrewFromJson(Map<String, dynamic> json) => _Screw(
  id: json['id'] as String,
  plateId: json['plateId'] as String,
  anchorIndex: (json['anchorIndex'] as num).toInt(),
  color: (json['color'] as num).toInt(),
  pos: Vector2D.fromJson(json['pos'] as Map<String, dynamic>),
  isBlocked: json['isBlocked'] as bool? ?? false,
);

Map<String, dynamic> _$ScrewToJson(_Screw instance) => <String, dynamic>{
  'id': instance.id,
  'plateId': instance.plateId,
  'anchorIndex': instance.anchorIndex,
  'color': instance.color,
  'pos': instance.pos.toJson(),
  'isBlocked': instance.isBlocked,
};

_Plate _$PlateFromJson(Map<String, dynamic> json) => _Plate(
  id: json['id'] as String,
  layer: (json['layer'] as num).toInt(),
  shape: Polygon.fromJson(json['shape'] as Map<String, dynamic>),
  pos: Vector2D.fromJson(json['pos'] as Map<String, dynamic>),
  rot: (json['rot'] as num).toDouble(),
  scale: (json['scale'] as num).toDouble(),
  present: json['present'] as bool? ?? true,
);

Map<String, dynamic> _$PlateToJson(_Plate instance) => <String, dynamic>{
  'id': instance.id,
  'layer': instance.layer,
  'shape': instance.shape.toJson(),
  'pos': instance.pos.toJson(),
  'rot': instance.rot,
  'scale': instance.scale,
  'present': instance.present,
};

_BoxState _$BoxStateFromJson(Map<String, dynamic> json) => _BoxState(
  color: (json['color'] as num).toInt(),
  count: (json['count'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$BoxStateToJson(_BoxState instance) => <String, dynamic>{
  'color': instance.color,
  'count': instance.count,
};
