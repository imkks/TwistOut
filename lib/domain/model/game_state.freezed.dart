// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GameState {

 Map<String, Plate> get plates; Map<String, Screw> get screwsOnBoard; List<BoxState> get activeBoxes; List<int> get boxQueue; List<Screw?> get tray; int get trayLimit; GameStatus get status; int get moves; int get trayPeak;
/// Create a copy of GameState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GameStateCopyWith<GameState> get copyWith => _$GameStateCopyWithImpl<GameState>(this as GameState, _$identity);

  /// Serializes this GameState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameState&&const DeepCollectionEquality().equals(other.plates, plates)&&const DeepCollectionEquality().equals(other.screwsOnBoard, screwsOnBoard)&&const DeepCollectionEquality().equals(other.activeBoxes, activeBoxes)&&const DeepCollectionEquality().equals(other.boxQueue, boxQueue)&&const DeepCollectionEquality().equals(other.tray, tray)&&(identical(other.trayLimit, trayLimit) || other.trayLimit == trayLimit)&&(identical(other.status, status) || other.status == status)&&(identical(other.moves, moves) || other.moves == moves)&&(identical(other.trayPeak, trayPeak) || other.trayPeak == trayPeak));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(plates),const DeepCollectionEquality().hash(screwsOnBoard),const DeepCollectionEquality().hash(activeBoxes),const DeepCollectionEquality().hash(boxQueue),const DeepCollectionEquality().hash(tray),trayLimit,status,moves,trayPeak);

@override
String toString() {
  return 'GameState(plates: $plates, screwsOnBoard: $screwsOnBoard, activeBoxes: $activeBoxes, boxQueue: $boxQueue, tray: $tray, trayLimit: $trayLimit, status: $status, moves: $moves, trayPeak: $trayPeak)';
}


}

/// @nodoc
abstract mixin class $GameStateCopyWith<$Res>  {
  factory $GameStateCopyWith(GameState value, $Res Function(GameState) _then) = _$GameStateCopyWithImpl;
@useResult
$Res call({
 Map<String, Plate> plates, Map<String, Screw> screwsOnBoard, List<BoxState> activeBoxes, List<int> boxQueue, List<Screw?> tray, int trayLimit, GameStatus status, int moves, int trayPeak
});




}
/// @nodoc
class _$GameStateCopyWithImpl<$Res>
    implements $GameStateCopyWith<$Res> {
  _$GameStateCopyWithImpl(this._self, this._then);

  final GameState _self;
  final $Res Function(GameState) _then;

/// Create a copy of GameState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? plates = null,Object? screwsOnBoard = null,Object? activeBoxes = null,Object? boxQueue = null,Object? tray = null,Object? trayLimit = null,Object? status = null,Object? moves = null,Object? trayPeak = null,}) {
  return _then(_self.copyWith(
plates: null == plates ? _self.plates : plates // ignore: cast_nullable_to_non_nullable
as Map<String, Plate>,screwsOnBoard: null == screwsOnBoard ? _self.screwsOnBoard : screwsOnBoard // ignore: cast_nullable_to_non_nullable
as Map<String, Screw>,activeBoxes: null == activeBoxes ? _self.activeBoxes : activeBoxes // ignore: cast_nullable_to_non_nullable
as List<BoxState>,boxQueue: null == boxQueue ? _self.boxQueue : boxQueue // ignore: cast_nullable_to_non_nullable
as List<int>,tray: null == tray ? _self.tray : tray // ignore: cast_nullable_to_non_nullable
as List<Screw?>,trayLimit: null == trayLimit ? _self.trayLimit : trayLimit // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as GameStatus,moves: null == moves ? _self.moves : moves // ignore: cast_nullable_to_non_nullable
as int,trayPeak: null == trayPeak ? _self.trayPeak : trayPeak // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [GameState].
extension GameStatePatterns on GameState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GameState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GameState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GameState value)  $default,){
final _that = this;
switch (_that) {
case _GameState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GameState value)?  $default,){
final _that = this;
switch (_that) {
case _GameState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Map<String, Plate> plates,  Map<String, Screw> screwsOnBoard,  List<BoxState> activeBoxes,  List<int> boxQueue,  List<Screw?> tray,  int trayLimit,  GameStatus status,  int moves,  int trayPeak)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GameState() when $default != null:
return $default(_that.plates,_that.screwsOnBoard,_that.activeBoxes,_that.boxQueue,_that.tray,_that.trayLimit,_that.status,_that.moves,_that.trayPeak);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Map<String, Plate> plates,  Map<String, Screw> screwsOnBoard,  List<BoxState> activeBoxes,  List<int> boxQueue,  List<Screw?> tray,  int trayLimit,  GameStatus status,  int moves,  int trayPeak)  $default,) {final _that = this;
switch (_that) {
case _GameState():
return $default(_that.plates,_that.screwsOnBoard,_that.activeBoxes,_that.boxQueue,_that.tray,_that.trayLimit,_that.status,_that.moves,_that.trayPeak);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Map<String, Plate> plates,  Map<String, Screw> screwsOnBoard,  List<BoxState> activeBoxes,  List<int> boxQueue,  List<Screw?> tray,  int trayLimit,  GameStatus status,  int moves,  int trayPeak)?  $default,) {final _that = this;
switch (_that) {
case _GameState() when $default != null:
return $default(_that.plates,_that.screwsOnBoard,_that.activeBoxes,_that.boxQueue,_that.tray,_that.trayLimit,_that.status,_that.moves,_that.trayPeak);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GameState extends GameState {
  const _GameState({required final  Map<String, Plate> plates, required final  Map<String, Screw> screwsOnBoard, required final  List<BoxState> activeBoxes, required final  List<int> boxQueue, required final  List<Screw?> tray, this.trayLimit = 5, this.status = GameStatus.playing, this.moves = 0, this.trayPeak = 0}): _plates = plates,_screwsOnBoard = screwsOnBoard,_activeBoxes = activeBoxes,_boxQueue = boxQueue,_tray = tray,super._();
  factory _GameState.fromJson(Map<String, dynamic> json) => _$GameStateFromJson(json);

 final  Map<String, Plate> _plates;
@override Map<String, Plate> get plates {
  if (_plates is EqualUnmodifiableMapView) return _plates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_plates);
}

 final  Map<String, Screw> _screwsOnBoard;
@override Map<String, Screw> get screwsOnBoard {
  if (_screwsOnBoard is EqualUnmodifiableMapView) return _screwsOnBoard;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_screwsOnBoard);
}

 final  List<BoxState> _activeBoxes;
@override List<BoxState> get activeBoxes {
  if (_activeBoxes is EqualUnmodifiableListView) return _activeBoxes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_activeBoxes);
}

 final  List<int> _boxQueue;
@override List<int> get boxQueue {
  if (_boxQueue is EqualUnmodifiableListView) return _boxQueue;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_boxQueue);
}

 final  List<Screw?> _tray;
@override List<Screw?> get tray {
  if (_tray is EqualUnmodifiableListView) return _tray;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tray);
}

@override@JsonKey() final  int trayLimit;
@override@JsonKey() final  GameStatus status;
@override@JsonKey() final  int moves;
@override@JsonKey() final  int trayPeak;

/// Create a copy of GameState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GameStateCopyWith<_GameState> get copyWith => __$GameStateCopyWithImpl<_GameState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GameStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GameState&&const DeepCollectionEquality().equals(other._plates, _plates)&&const DeepCollectionEquality().equals(other._screwsOnBoard, _screwsOnBoard)&&const DeepCollectionEquality().equals(other._activeBoxes, _activeBoxes)&&const DeepCollectionEquality().equals(other._boxQueue, _boxQueue)&&const DeepCollectionEquality().equals(other._tray, _tray)&&(identical(other.trayLimit, trayLimit) || other.trayLimit == trayLimit)&&(identical(other.status, status) || other.status == status)&&(identical(other.moves, moves) || other.moves == moves)&&(identical(other.trayPeak, trayPeak) || other.trayPeak == trayPeak));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_plates),const DeepCollectionEquality().hash(_screwsOnBoard),const DeepCollectionEquality().hash(_activeBoxes),const DeepCollectionEquality().hash(_boxQueue),const DeepCollectionEquality().hash(_tray),trayLimit,status,moves,trayPeak);

@override
String toString() {
  return 'GameState(plates: $plates, screwsOnBoard: $screwsOnBoard, activeBoxes: $activeBoxes, boxQueue: $boxQueue, tray: $tray, trayLimit: $trayLimit, status: $status, moves: $moves, trayPeak: $trayPeak)';
}


}

/// @nodoc
abstract mixin class _$GameStateCopyWith<$Res> implements $GameStateCopyWith<$Res> {
  factory _$GameStateCopyWith(_GameState value, $Res Function(_GameState) _then) = __$GameStateCopyWithImpl;
@override @useResult
$Res call({
 Map<String, Plate> plates, Map<String, Screw> screwsOnBoard, List<BoxState> activeBoxes, List<int> boxQueue, List<Screw?> tray, int trayLimit, GameStatus status, int moves, int trayPeak
});




}
/// @nodoc
class __$GameStateCopyWithImpl<$Res>
    implements _$GameStateCopyWith<$Res> {
  __$GameStateCopyWithImpl(this._self, this._then);

  final _GameState _self;
  final $Res Function(_GameState) _then;

/// Create a copy of GameState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? plates = null,Object? screwsOnBoard = null,Object? activeBoxes = null,Object? boxQueue = null,Object? tray = null,Object? trayLimit = null,Object? status = null,Object? moves = null,Object? trayPeak = null,}) {
  return _then(_GameState(
plates: null == plates ? _self._plates : plates // ignore: cast_nullable_to_non_nullable
as Map<String, Plate>,screwsOnBoard: null == screwsOnBoard ? _self._screwsOnBoard : screwsOnBoard // ignore: cast_nullable_to_non_nullable
as Map<String, Screw>,activeBoxes: null == activeBoxes ? _self._activeBoxes : activeBoxes // ignore: cast_nullable_to_non_nullable
as List<BoxState>,boxQueue: null == boxQueue ? _self._boxQueue : boxQueue // ignore: cast_nullable_to_non_nullable
as List<int>,tray: null == tray ? _self._tray : tray // ignore: cast_nullable_to_non_nullable
as List<Screw?>,trayLimit: null == trayLimit ? _self.trayLimit : trayLimit // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as GameStatus,moves: null == moves ? _self.moves : moves // ignore: cast_nullable_to_non_nullable
as int,trayPeak: null == trayPeak ? _self.trayPeak : trayPeak // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
