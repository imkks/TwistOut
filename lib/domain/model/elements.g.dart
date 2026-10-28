// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'elements.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Screw _$ScrewFromJson(Map<String, dynamic> json) => _Screw(
  id: json['id'] as String,
  plate: json['plate'] as String,
  anchor: (json['anchor'] as num).toInt(),
  color: (json['color'] as num).toInt(),
  isBlocked: json['isBlocked'] as bool? ?? false,
);

Map<String, dynamic> _$ScrewToJson(_Screw instance) => <String, dynamic>{
  'id': instance.id,
  'plate': instance.plate,
  'anchor': instance.anchor,
  'color': instance.color,
  'isBlocked': instance.isBlocked,
};

_Plate _$PlateFromJson(Map<String, dynamic> json) => _Plate(
  id: json['id'] as String,
  layer: (json['layer'] as num).toInt(),
  shape: json['shape'] as String,
  pos: (json['pos'] as List<dynamic>)
      .map((e) => (e as num).toDouble())
      .toList(),
  rot: (json['rot'] as num).toDouble(),
  scale: (json['scale'] as num).toDouble(),
);

Map<String, dynamic> _$PlateToJson(_Plate instance) => <String, dynamic>{
  'id': instance.id,
  'layer': instance.layer,
  'shape': instance.shape,
  'pos': instance.pos,
  'rot': instance.rot,
  'scale': instance.scale,
};

_Box _$BoxFromJson(Map<String, dynamic> json) => _Box(
  color: (json['color'] as num).toInt(),
  count: (json['count'] as num).toInt(),
);

Map<String, dynamic> _$BoxToJson(_Box instance) => <String, dynamic>{
  'color': instance.color,
  'count': instance.count,
};
