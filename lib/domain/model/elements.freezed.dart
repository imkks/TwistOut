// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'elements.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Screw {

 String get id; String get plateId; int get anchorIndex; int get color; Vector2D get pos; bool get isBlocked;
/// Create a copy of Screw
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScrewCopyWith<Screw> get copyWith => _$ScrewCopyWithImpl<Screw>(this as Screw, _$identity);

  /// Serializes this Screw to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Screw&&(identical(other.id, id) || other.id == id)&&(identical(other.plateId, plateId) || other.plateId == plateId)&&(identical(other.anchorIndex, anchorIndex) || other.anchorIndex == anchorIndex)&&(identical(other.color, color) || other.color == color)&&(identical(other.pos, pos) || other.pos == pos)&&(identical(other.isBlocked, isBlocked) || other.isBlocked == isBlocked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,plateId,anchorIndex,color,pos,isBlocked);

@override
String toString() {
  return 'Screw(id: $id, plateId: $plateId, anchorIndex: $anchorIndex, color: $color, pos: $pos, isBlocked: $isBlocked)';
}


}

/// @nodoc
abstract mixin class $ScrewCopyWith<$Res>  {
  factory $ScrewCopyWith(Screw value, $Res Function(Screw) _then) = _$ScrewCopyWithImpl;
@useResult
$Res call({
 String id, String plateId, int anchorIndex, int color, Vector2D pos, bool isBlocked
});


$Vector2DCopyWith<$Res> get pos;

}
/// @nodoc
class _$ScrewCopyWithImpl<$Res>
    implements $ScrewCopyWith<$Res> {
  _$ScrewCopyWithImpl(this._self, this._then);

  final Screw _self;
  final $Res Function(Screw) _then;

/// Create a copy of Screw
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? plateId = null,Object? anchorIndex = null,Object? color = null,Object? pos = null,Object? isBlocked = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,plateId: null == plateId ? _self.plateId : plateId // ignore: cast_nullable_to_non_nullable
as String,anchorIndex: null == anchorIndex ? _self.anchorIndex : anchorIndex // ignore: cast_nullable_to_non_nullable
as int,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as int,pos: null == pos ? _self.pos : pos // ignore: cast_nullable_to_non_nullable
as Vector2D,isBlocked: null == isBlocked ? _self.isBlocked : isBlocked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of Screw
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$Vector2DCopyWith<$Res> get pos {
  
  return $Vector2DCopyWith<$Res>(_self.pos, (value) {
    return _then(_self.copyWith(pos: value));
  });
}
}


/// Adds pattern-matching-related methods to [Screw].
extension ScrewPatterns on Screw {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Screw value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Screw() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Screw value)  $default,){
final _that = this;
switch (_that) {
case _Screw():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Screw value)?  $default,){
final _that = this;
switch (_that) {
case _Screw() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String plateId,  int anchorIndex,  int color,  Vector2D pos,  bool isBlocked)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Screw() when $default != null:
return $default(_that.id,_that.plateId,_that.anchorIndex,_that.color,_that.pos,_that.isBlocked);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String plateId,  int anchorIndex,  int color,  Vector2D pos,  bool isBlocked)  $default,) {final _that = this;
switch (_that) {
case _Screw():
return $default(_that.id,_that.plateId,_that.anchorIndex,_that.color,_that.pos,_that.isBlocked);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String plateId,  int anchorIndex,  int color,  Vector2D pos,  bool isBlocked)?  $default,) {final _that = this;
switch (_that) {
case _Screw() when $default != null:
return $default(_that.id,_that.plateId,_that.anchorIndex,_that.color,_that.pos,_that.isBlocked);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Screw extends Screw {
  const _Screw({required this.id, required this.plateId, required this.anchorIndex, required this.color, required this.pos, this.isBlocked = false}): super._();
  factory _Screw.fromJson(Map<String, dynamic> json) => _$ScrewFromJson(json);

@override final  String id;
@override final  String plateId;
@override final  int anchorIndex;
@override final  int color;
@override final  Vector2D pos;
@override@JsonKey() final  bool isBlocked;

/// Create a copy of Screw
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScrewCopyWith<_Screw> get copyWith => __$ScrewCopyWithImpl<_Screw>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ScrewToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Screw&&(identical(other.id, id) || other.id == id)&&(identical(other.plateId, plateId) || other.plateId == plateId)&&(identical(other.anchorIndex, anchorIndex) || other.anchorIndex == anchorIndex)&&(identical(other.color, color) || other.color == color)&&(identical(other.pos, pos) || other.pos == pos)&&(identical(other.isBlocked, isBlocked) || other.isBlocked == isBlocked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,plateId,anchorIndex,color,pos,isBlocked);

@override
String toString() {
  return 'Screw(id: $id, plateId: $plateId, anchorIndex: $anchorIndex, color: $color, pos: $pos, isBlocked: $isBlocked)';
}


}

/// @nodoc
abstract mixin class _$ScrewCopyWith<$Res> implements $ScrewCopyWith<$Res> {
  factory _$ScrewCopyWith(_Screw value, $Res Function(_Screw) _then) = __$ScrewCopyWithImpl;
@override @useResult
$Res call({
 String id, String plateId, int anchorIndex, int color, Vector2D pos, bool isBlocked
});


@override $Vector2DCopyWith<$Res> get pos;

}
/// @nodoc
class __$ScrewCopyWithImpl<$Res>
    implements _$ScrewCopyWith<$Res> {
  __$ScrewCopyWithImpl(this._self, this._then);

  final _Screw _self;
  final $Res Function(_Screw) _then;

/// Create a copy of Screw
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? plateId = null,Object? anchorIndex = null,Object? color = null,Object? pos = null,Object? isBlocked = null,}) {
  return _then(_Screw(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,plateId: null == plateId ? _self.plateId : plateId // ignore: cast_nullable_to_non_nullable
as String,anchorIndex: null == anchorIndex ? _self.anchorIndex : anchorIndex // ignore: cast_nullable_to_non_nullable
as int,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as int,pos: null == pos ? _self.pos : pos // ignore: cast_nullable_to_non_nullable
as Vector2D,isBlocked: null == isBlocked ? _self.isBlocked : isBlocked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of Screw
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$Vector2DCopyWith<$Res> get pos {
  
  return $Vector2DCopyWith<$Res>(_self.pos, (value) {
    return _then(_self.copyWith(pos: value));
  });
}
}


/// @nodoc
mixin _$Plate {

 String get id; int get layer; Polygon get shape; Vector2D get pos; double get rot; double get scale; bool get present;
/// Create a copy of Plate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlateCopyWith<Plate> get copyWith => _$PlateCopyWithImpl<Plate>(this as Plate, _$identity);

  /// Serializes this Plate to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Plate&&(identical(other.id, id) || other.id == id)&&(identical(other.layer, layer) || other.layer == layer)&&(identical(other.shape, shape) || other.shape == shape)&&(identical(other.pos, pos) || other.pos == pos)&&(identical(other.rot, rot) || other.rot == rot)&&(identical(other.scale, scale) || other.scale == scale)&&(identical(other.present, present) || other.present == present));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,layer,shape,pos,rot,scale,present);

@override
String toString() {
  return 'Plate(id: $id, layer: $layer, shape: $shape, pos: $pos, rot: $rot, scale: $scale, present: $present)';
}


}

/// @nodoc
abstract mixin class $PlateCopyWith<$Res>  {
  factory $PlateCopyWith(Plate value, $Res Function(Plate) _then) = _$PlateCopyWithImpl;
@useResult
$Res call({
 String id, int layer, Polygon shape, Vector2D pos, double rot, double scale, bool present
});


$PolygonCopyWith<$Res> get shape;$Vector2DCopyWith<$Res> get pos;

}
/// @nodoc
class _$PlateCopyWithImpl<$Res>
    implements $PlateCopyWith<$Res> {
  _$PlateCopyWithImpl(this._self, this._then);

  final Plate _self;
  final $Res Function(Plate) _then;

/// Create a copy of Plate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? layer = null,Object? shape = null,Object? pos = null,Object? rot = null,Object? scale = null,Object? present = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,layer: null == layer ? _self.layer : layer // ignore: cast_nullable_to_non_nullable
as int,shape: null == shape ? _self.shape : shape // ignore: cast_nullable_to_non_nullable
as Polygon,pos: null == pos ? _self.pos : pos // ignore: cast_nullable_to_non_nullable
as Vector2D,rot: null == rot ? _self.rot : rot // ignore: cast_nullable_to_non_nullable
as double,scale: null == scale ? _self.scale : scale // ignore: cast_nullable_to_non_nullable
as double,present: null == present ? _self.present : present // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of Plate
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PolygonCopyWith<$Res> get shape {
  
  return $PolygonCopyWith<$Res>(_self.shape, (value) {
    return _then(_self.copyWith(shape: value));
  });
}/// Create a copy of Plate
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$Vector2DCopyWith<$Res> get pos {
  
  return $Vector2DCopyWith<$Res>(_self.pos, (value) {
    return _then(_self.copyWith(pos: value));
  });
}
}


/// Adds pattern-matching-related methods to [Plate].
extension PlatePatterns on Plate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Plate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Plate() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Plate value)  $default,){
final _that = this;
switch (_that) {
case _Plate():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Plate value)?  $default,){
final _that = this;
switch (_that) {
case _Plate() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  int layer,  Polygon shape,  Vector2D pos,  double rot,  double scale,  bool present)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Plate() when $default != null:
return $default(_that.id,_that.layer,_that.shape,_that.pos,_that.rot,_that.scale,_that.present);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  int layer,  Polygon shape,  Vector2D pos,  double rot,  double scale,  bool present)  $default,) {final _that = this;
switch (_that) {
case _Plate():
return $default(_that.id,_that.layer,_that.shape,_that.pos,_that.rot,_that.scale,_that.present);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  int layer,  Polygon shape,  Vector2D pos,  double rot,  double scale,  bool present)?  $default,) {final _that = this;
switch (_that) {
case _Plate() when $default != null:
return $default(_that.id,_that.layer,_that.shape,_that.pos,_that.rot,_that.scale,_that.present);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Plate extends Plate {
  const _Plate({required this.id, required this.layer, required this.shape, required this.pos, required this.rot, required this.scale, this.present = true}): super._();
  factory _Plate.fromJson(Map<String, dynamic> json) => _$PlateFromJson(json);

@override final  String id;
@override final  int layer;
@override final  Polygon shape;
@override final  Vector2D pos;
@override final  double rot;
@override final  double scale;
@override@JsonKey() final  bool present;

/// Create a copy of Plate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlateCopyWith<_Plate> get copyWith => __$PlateCopyWithImpl<_Plate>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Plate&&(identical(other.id, id) || other.id == id)&&(identical(other.layer, layer) || other.layer == layer)&&(identical(other.shape, shape) || other.shape == shape)&&(identical(other.pos, pos) || other.pos == pos)&&(identical(other.rot, rot) || other.rot == rot)&&(identical(other.scale, scale) || other.scale == scale)&&(identical(other.present, present) || other.present == present));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,layer,shape,pos,rot,scale,present);

@override
String toString() {
  return 'Plate(id: $id, layer: $layer, shape: $shape, pos: $pos, rot: $rot, scale: $scale, present: $present)';
}


}

/// @nodoc
abstract mixin class _$PlateCopyWith<$Res> implements $PlateCopyWith<$Res> {
  factory _$PlateCopyWith(_Plate value, $Res Function(_Plate) _then) = __$PlateCopyWithImpl;
@override @useResult
$Res call({
 String id, int layer, Polygon shape, Vector2D pos, double rot, double scale, bool present
});


@override $PolygonCopyWith<$Res> get shape;@override $Vector2DCopyWith<$Res> get pos;

}
/// @nodoc
class __$PlateCopyWithImpl<$Res>
    implements _$PlateCopyWith<$Res> {
  __$PlateCopyWithImpl(this._self, this._then);

  final _Plate _self;
  final $Res Function(_Plate) _then;

/// Create a copy of Plate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? layer = null,Object? shape = null,Object? pos = null,Object? rot = null,Object? scale = null,Object? present = null,}) {
  return _then(_Plate(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,layer: null == layer ? _self.layer : layer // ignore: cast_nullable_to_non_nullable
as int,shape: null == shape ? _self.shape : shape // ignore: cast_nullable_to_non_nullable
as Polygon,pos: null == pos ? _self.pos : pos // ignore: cast_nullable_to_non_nullable
as Vector2D,rot: null == rot ? _self.rot : rot // ignore: cast_nullable_to_non_nullable
as double,scale: null == scale ? _self.scale : scale // ignore: cast_nullable_to_non_nullable
as double,present: null == present ? _self.present : present // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of Plate
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PolygonCopyWith<$Res> get shape {
  
  return $PolygonCopyWith<$Res>(_self.shape, (value) {
    return _then(_self.copyWith(shape: value));
  });
}/// Create a copy of Plate
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$Vector2DCopyWith<$Res> get pos {
  
  return $Vector2DCopyWith<$Res>(_self.pos, (value) {
    return _then(_self.copyWith(pos: value));
  });
}
}


/// @nodoc
mixin _$BoxState {

 int get color; int get count;
/// Create a copy of BoxState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BoxStateCopyWith<BoxState> get copyWith => _$BoxStateCopyWithImpl<BoxState>(this as BoxState, _$identity);

  /// Serializes this BoxState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BoxState&&(identical(other.color, color) || other.color == color)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,color,count);

@override
String toString() {
  return 'BoxState(color: $color, count: $count)';
}


}

/// @nodoc
abstract mixin class $BoxStateCopyWith<$Res>  {
  factory $BoxStateCopyWith(BoxState value, $Res Function(BoxState) _then) = _$BoxStateCopyWithImpl;
@useResult
$Res call({
 int color, int count
});




}
/// @nodoc
class _$BoxStateCopyWithImpl<$Res>
    implements $BoxStateCopyWith<$Res> {
  _$BoxStateCopyWithImpl(this._self, this._then);

  final BoxState _self;
  final $Res Function(BoxState) _then;

/// Create a copy of BoxState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? color = null,Object? count = null,}) {
  return _then(_self.copyWith(
color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as int,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [BoxState].
extension BoxStatePatterns on BoxState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BoxState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BoxState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BoxState value)  $default,){
final _that = this;
switch (_that) {
case _BoxState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BoxState value)?  $default,){
final _that = this;
switch (_that) {
case _BoxState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int color,  int count)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BoxState() when $default != null:
return $default(_that.color,_that.count);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int color,  int count)  $default,) {final _that = this;
switch (_that) {
case _BoxState():
return $default(_that.color,_that.count);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int color,  int count)?  $default,) {final _that = this;
switch (_that) {
case _BoxState() when $default != null:
return $default(_that.color,_that.count);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BoxState extends BoxState {
  const _BoxState({required this.color, this.count = 0}): super._();
  factory _BoxState.fromJson(Map<String, dynamic> json) => _$BoxStateFromJson(json);

@override final  int color;
@override@JsonKey() final  int count;

/// Create a copy of BoxState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BoxStateCopyWith<_BoxState> get copyWith => __$BoxStateCopyWithImpl<_BoxState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BoxStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BoxState&&(identical(other.color, color) || other.color == color)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,color,count);

@override
String toString() {
  return 'BoxState(color: $color, count: $count)';
}


}

/// @nodoc
abstract mixin class _$BoxStateCopyWith<$Res> implements $BoxStateCopyWith<$Res> {
  factory _$BoxStateCopyWith(_BoxState value, $Res Function(_BoxState) _then) = __$BoxStateCopyWithImpl;
@override @useResult
$Res call({
 int color, int count
});




}
/// @nodoc
class __$BoxStateCopyWithImpl<$Res>
    implements _$BoxStateCopyWith<$Res> {
  __$BoxStateCopyWithImpl(this._self, this._then);

  final _BoxState _self;
  final $Res Function(_BoxState) _then;

/// Create a copy of BoxState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? color = null,Object? count = null,}) {
  return _then(_BoxState(
color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as int,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
