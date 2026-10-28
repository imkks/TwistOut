import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:twist_out/domain/model/geometry.dart';

part 'elements.freezed.dart';
part 'elements.g.dart';

/// Game completion and play status.
enum GameStatus {
  playing,
  won,
  lost,
}

/// Available booster types.
enum BoosterType {
  extraSlot,
  magnet,
  smash,
}

/// A screw on the board or in the tray.
@freezed
abstract class Screw with _$Screw {
  const Screw._();

  const factory Screw({
    required String id,
    required String plateId,
    required int anchorIndex,
    required int color,
    required Vector2D pos,
    @Default(false) bool isBlocked,
  }) = _Screw;

  factory Screw.fromJson(Map<String, dynamic> json) => _$ScrewFromJson(json);
}

/// A stacked plate containing anchor positions and a polygon boundary.
@freezed
abstract class Plate with _$Plate {
  const Plate._();

  const factory Plate({
    required String id,
    required int layer,
    required Polygon shape,
    required Vector2D pos,
    required double rot,
    required double scale,
    @Default(true) bool present,
  }) = _Plate;

  factory Plate.fromJson(Map<String, dynamic> json) => _$PlateFromJson(json);

  /// Computes the plate's polygon transformed into board world coordinates.
  Polygon get worldPolygon => shape.transform(
        translation: pos,
        rotation: rot,
        scale: scale,
      );
}

/// State of an active collection box. Capacity is fixed at 3.
@freezed
abstract class BoxState with _$BoxState {
  const BoxState._();

  const factory BoxState({
    required int color,
    @Default(0) int count,
  }) = _BoxState;

  factory BoxState.fromJson(Map<String, dynamic> json) =>
      _$BoxStateFromJson(json);

  bool get isFull => count >= 3;

  int get remainingCapacity => (3 - count).clamp(0, 3);
}
