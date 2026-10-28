// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GameState _$GameStateFromJson(Map<String, dynamic> json) => _GameState(
  plates: (json['plates'] as Map<String, dynamic>).map(
    (k, e) => MapEntry(k, Plate.fromJson(e as Map<String, dynamic>)),
  ),
  screwsOnBoard: (json['screwsOnBoard'] as Map<String, dynamic>).map(
    (k, e) => MapEntry(k, Screw.fromJson(e as Map<String, dynamic>)),
  ),
  activeBoxes: (json['activeBoxes'] as List<dynamic>)
      .map((e) => BoxState.fromJson(e as Map<String, dynamic>))
      .toList(),
  boxQueue: (json['boxQueue'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toList(),
  tray: (json['tray'] as List<dynamic>)
      .map((e) => e == null ? null : Screw.fromJson(e as Map<String, dynamic>))
      .toList(),
  trayLimit: (json['trayLimit'] as num?)?.toInt() ?? 5,
  status:
      $enumDecodeNullable(_$GameStatusEnumMap, json['status']) ??
      GameStatus.playing,
  moves: (json['moves'] as num?)?.toInt() ?? 0,
  trayPeak: (json['trayPeak'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$GameStateToJson(_GameState instance) =>
    <String, dynamic>{
      'plates': instance.plates.map((k, e) => MapEntry(k, e.toJson())),
      'screwsOnBoard': instance.screwsOnBoard.map(
        (k, e) => MapEntry(k, e.toJson()),
      ),
      'activeBoxes': instance.activeBoxes.map((e) => e.toJson()).toList(),
      'boxQueue': instance.boxQueue,
      'tray': instance.tray.map((e) => e?.toJson()).toList(),
      'trayLimit': instance.trayLimit,
      'status': _$GameStatusEnumMap[instance.status]!,
      'moves': instance.moves,
      'trayPeak': instance.trayPeak,
    };

const _$GameStatusEnumMap = {
  GameStatus.playing: 'playing',
  GameStatus.won: 'won',
  GameStatus.lost: 'lost',
};
