import 'package:freezed_annotation/freezed_annotation.dart';

part 'elements.freezed.dart';
part 'elements.g.dart';

@freezed
abstract class Screw with _$Screw {
  const factory Screw({
    required String id,
    required String plate,
    required int anchor,
    required int color,
    @Default(false) bool isBlocked,
  }) = _Screw;

  factory Screw.fromJson(Map<String, dynamic> json) => _$ScrewFromJson(json);
}

@freezed
abstract class Plate with _$Plate {
  const factory Plate({
    required String id,
    required int layer,
    required String shape,
    required List<double> pos,
    required double rot,
    required double scale,
  }) = _Plate;

  factory Plate.fromJson(Map<String, dynamic> json) => _$PlateFromJson(json);
}

@freezed
abstract class Box with _$Box {
  const factory Box({
    required int color,
    required int count,
  }) = _Box;

  factory Box.fromJson(Map<String, dynamic> json) => _$BoxFromJson(json);
}
