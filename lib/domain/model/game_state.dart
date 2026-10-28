import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:twist_out/domain/model/elements.dart';

part 'game_state.freezed.dart';
part 'game_state.g.dart';

/// Immutable full gameplay state.
@freezed
abstract class GameState with _$GameState {
  const GameState._();

  const factory GameState({
    required Map<String, Plate> plates,
    required Map<String, Screw> screwsOnBoard,
    required List<BoxState> activeBoxes,
    required List<int> boxQueue,
    required List<Screw?> tray,
    @Default(5) int trayLimit,
    @Default(GameStatus.playing) GameStatus status,
    @Default(0) int moves,
    @Default(0) int trayPeak,
  }) = _GameState;

  factory GameState.fromJson(Map<String, dynamic> json) =>
      _$GameStateFromJson(json);

  /// Number of occupied slots in the tray.
  int get trayOccupancy => tray.where((s) => s != null).length;

  /// Whether all tray slots are currently occupied.
  bool get isTrayFull => tray.every((s) => s != null);

  /// First open tray slot index, or -1 if full.
  int get firstEmptyTrayIndex => tray.indexOf(null);

  /// Factory helper to initialize a new game state.
  factory GameState.initial({
    required Map<String, Plate> plates,
    required Map<String, Screw> screwsOnBoard,
    required List<int> initialBoxQueue,
    int trayLimit = 5,
    int maxActiveBoxes = 3,
  }) {
    final activeCount = mathMin(initialBoxQueue.length, maxActiveBoxes);
    final active = initialBoxQueue
        .take(activeCount)
        .map((c) => BoxState(color: c, count: 0))
        .toList(growable: false);
    final queue = initialBoxQueue.skip(activeCount).toList(growable: false);

    return GameState(
      plates: plates,
      screwsOnBoard: screwsOnBoard,
      activeBoxes: active,
      boxQueue: queue,
      tray: List<Screw?>.filled(trayLimit, null),
      trayLimit: trayLimit,
      status: GameStatus.playing,
      moves: 0,
      trayPeak: 0,
    );
  }
}

int mathMin(int a, int b) => a < b ? a : b;
