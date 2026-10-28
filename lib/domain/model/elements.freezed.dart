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

 String get id; String get plate; int get anchor; int get color; bool get isBlocked;
/// Create a copy of Screw
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScrewCopyWith<Screw> get copyWith => _$ScrewCopyWithImpl<Screw>(this as Screw, _$identity);

  /// Serializes this Screw to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Screw&&(identical(other.id, id) || other.id == id)&&(identical(other.plate, plate) || other.plate == plate)&&(identical(other.anchor, anchor) || other.anchor == anchor)&&(identical(other.color, color) || other.color == color)&&(identical(other.isBlocked, isBlocked) || other.isBlocked == isBlocked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,plate,anchor,color,isBlocked);

@override
String toString() {
  return 'Screw(id: $id, plate: $plate, anchor: $anchor, color: $color, isBlocked: $isBlocked)';
}


}

/// @nodoc
abstract mixin class $ScrewCopyWith<$Res>  {
  factory $ScrewCopyWith(Screw value, $Res Function(Screw) _then) = _$ScrewCopyWithImpl;
@useResult
$Res call({
 String id, String plate, int anchor, int color, bool isBlocked
});




}
/// @nodoc
class _$ScrewCopyWithImpl<$Res>
    implements $ScrewCopyWith<$Res> {
  _$ScrewCopyWithImpl(this._self, this._then);

  final Screw _self;
  final $Res Function(Screw) _then;

/// Create a copy of Screw
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? plate = null,Object? anchor = null,Object? color = null,Object? isBlocked = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,plate: null == plate ? _self.plate : plate // ignore: cast_nullable_to_non_nullable
as String,anchor: null == anchor ? _self.anchor : anchor // ignore: cast_nullable_to_non_nullable
as int,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as int,isBlocked: null == isBlocked ? _self.isBlocked : isBlocked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String plate,  int anchor,  int color,  bool isBlocked)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Screw() when $default != null:
return $default(_that.id,_that.plate,_that.anchor,_that.color,_that.isBlocked);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String plate,  int anchor,  int color,  bool isBlocked)  $default,) {final _that = this;
switch (_that) {
case _Screw():
return $default(_that.id,_that.plate,_that.anchor,_that.color,_that.isBlocked);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String plate,  int anchor,  int color,  bool isBlocked)?  $default,) {final _that = this;
switch (_that) {
case _Screw() when $default != null:
return $default(_that.id,_that.plate,_that.anchor,_that.color,_that.isBlocked);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Screw implements Screw {
  const _Screw({required this.id, required this.plate, required this.anchor, required this.color, this.isBlocked = false});
  factory _Screw.fromJson(Map<String, dynamic> json) => _$ScrewFromJson(json);

@override final  String id;
@override final  String plate;
@override final  int anchor;
@override final  int color;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Screw&&(identical(other.id, id) || other.id == id)&&(identical(other.plate, plate) || other.plate == plate)&&(identical(other.anchor, anchor) || other.anchor == anchor)&&(identical(other.color, color) || other.color == color)&&(identical(other.isBlocked, isBlocked) || other.isBlocked == isBlocked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,plate,anchor,color,isBlocked);

@override
String toString() {
  return 'Screw(id: $id, plate: $plate, anchor: $anchor, color: $color, isBlocked: $isBlocked)';
}


}

/// @nodoc
abstract mixin class _$ScrewCopyWith<$Res> implements $ScrewCopyWith<$Res> {
  factory _$ScrewCopyWith(_Screw value, $Res Function(_Screw) _then) = __$ScrewCopyWithImpl;
@override @useResult
$Res call({
 String id, String plate, int anchor, int color, bool isBlocked
});




}
/// @nodoc
class __$ScrewCopyWithImpl<$Res>
    implements _$ScrewCopyWith<$Res> {
  __$ScrewCopyWithImpl(this._self, this._then);

  final _Screw _self;
  final $Res Function(_Screw) _then;

/// Create a copy of Screw
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? plate = null,Object? anchor = null,Object? color = null,Object? isBlocked = null,}) {
  return _then(_Screw(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,plate: null == plate ? _self.plate : plate // ignore: cast_nullable_to_non_nullable
as String,anchor: null == anchor ? _self.anchor : anchor // ignore: cast_nullable_to_non_nullable
as int,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as int,isBlocked: null == isBlocked ? _self.isBlocked : isBlocked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$Plate {

 String get id; int get layer; String get shape; List<double> get pos; double get rot; double get scale;
/// Create a copy of Plate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlateCopyWith<Plate> get copyWith => _$PlateCopyWithImpl<Plate>(this as Plate, _$identity);

  /// Serializes this Plate to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Plate&&(identical(other.id, id) || other.id == id)&&(identical(other.layer, layer) || other.layer == layer)&&(identical(other.shape, shape) || other.shape == shape)&&const DeepCollectionEquality().equals(other.pos, pos)&&(identical(other.rot, rot) || other.rot == rot)&&(identical(other.scale, scale) || other.scale == scale));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,layer,shape,const DeepCollectionEquality().hash(pos),rot,scale);

@override
String toString() {
  return 'Plate(id: $id, layer: $layer, shape: $shape, pos: $pos, rot: $rot, scale: $scale)';
}


}

/// @nodoc
abstract mixin class $PlateCopyWith<$Res>  {
  factory $PlateCopyWith(Plate value, $Res Function(Plate) _then) = _$PlateCopyWithImpl;
@useResult
$Res call({
 String id, int layer, String shape, List<double> pos, double rot, double scale
});




}
/// @nodoc
class _$PlateCopyWithImpl<$Res>
    implements $PlateCopyWith<$Res> {
  _$PlateCopyWithImpl(this._self, this._then);

  final Plate _self;
  final $Res Function(Plate) _then;

/// Create a copy of Plate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? layer = null,Object? shape = null,Object? pos = null,Object? rot = null,Object? scale = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,layer: null == layer ? _self.layer : layer // ignore: cast_nullable_to_non_nullable
as int,shape: null == shape ? _self.shape : shape // ignore: cast_nullable_to_non_nullable
as String,pos: null == pos ? _self.pos : pos // ignore: cast_nullable_to_non_nullable
as List<double>,rot: null == rot ? _self.rot : rot // ignore: cast_nullable_to_non_nullable
as double,scale: null == scale ? _self.scale : scale // ignore: cast_nullable_to_non_nullable
as double,
  ));
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  int layer,  String shape,  List<double> pos,  double rot,  double scale)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Plate() when $default != null:
return $default(_that.id,_that.layer,_that.shape,_that.pos,_that.rot,_that.scale);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  int layer,  String shape,  List<double> pos,  double rot,  double scale)  $default,) {final _that = this;
switch (_that) {
case _Plate():
return $default(_that.id,_that.layer,_that.shape,_that.pos,_that.rot,_that.scale);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  int layer,  String shape,  List<double> pos,  double rot,  double scale)?  $default,) {final _that = this;
switch (_that) {
case _Plate() when $default != null:
return $default(_that.id,_that.layer,_that.shape,_that.pos,_that.rot,_that.scale);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Plate implements Plate {
  const _Plate({required this.id, required this.layer, required this.shape, required final  List<double> pos, required this.rot, required this.scale}): _pos = pos;
  factory _Plate.fromJson(Map<String, dynamic> json) => _$PlateFromJson(json);

@override final  String id;
@override final  int layer;
@override final  String shape;
 final  List<double> _pos;
@override List<double> get pos {
  if (_pos is EqualUnmodifiableListView) return _pos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pos);
}

@override final  double rot;
@override final  double scale;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Plate&&(identical(other.id, id) || other.id == id)&&(identical(other.layer, layer) || other.layer == layer)&&(identical(other.shape, shape) || other.shape == shape)&&const DeepCollectionEquality().equals(other._pos, _pos)&&(identical(other.rot, rot) || other.rot == rot)&&(identical(other.scale, scale) || other.scale == scale));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,layer,shape,const DeepCollectionEquality().hash(_pos),rot,scale);

@override
String toString() {
  return 'Plate(id: $id, layer: $layer, shape: $shape, pos: $pos, rot: $rot, scale: $scale)';
}


}

/// @nodoc
abstract mixin class _$PlateCopyWith<$Res> implements $PlateCopyWith<$Res> {
  factory _$PlateCopyWith(_Plate value, $Res Function(_Plate) _then) = __$PlateCopyWithImpl;
@override @useResult
$Res call({
 String id, int layer, String shape, List<double> pos, double rot, double scale
});




}
/// @nodoc
class __$PlateCopyWithImpl<$Res>
    implements _$PlateCopyWith<$Res> {
  __$PlateCopyWithImpl(this._self, this._then);

  final _Plate _self;
  final $Res Function(_Plate) _then;

/// Create a copy of Plate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? layer = null,Object? shape = null,Object? pos = null,Object? rot = null,Object? scale = null,}) {
  return _then(_Plate(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,layer: null == layer ? _self.layer : layer // ignore: cast_nullable_to_non_nullable
as int,shape: null == shape ? _self.shape : shape // ignore: cast_nullable_to_non_nullable
as String,pos: null == pos ? _self._pos : pos // ignore: cast_nullable_to_non_nullable
as List<double>,rot: null == rot ? _self.rot : rot // ignore: cast_nullable_to_non_nullable
as double,scale: null == scale ? _self.scale : scale // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$Box {

 int get color; int get count;
/// Create a copy of Box
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BoxCopyWith<Box> get copyWith => _$BoxCopyWithImpl<Box>(this as Box, _$identity);

  /// Serializes this Box to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Box&&(identical(other.color, color) || other.color == color)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,color,count);

@override
String toString() {
  return 'Box(color: $color, count: $count)';
}


}

/// @nodoc
abstract mixin class $BoxCopyWith<$Res>  {
  factory $BoxCopyWith(Box value, $Res Function(Box) _then) = _$BoxCopyWithImpl;
@useResult
$Res call({
 int color, int count
});




}
/// @nodoc
class _$BoxCopyWithImpl<$Res>
    implements $BoxCopyWith<$Res> {
  _$BoxCopyWithImpl(this._self, this._then);

  final Box _self;
  final $Res Function(Box) _then;

/// Create a copy of Box
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? color = null,Object? count = null,}) {
  return _then(_self.copyWith(
color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as int,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Box].
extension BoxPatterns on Box {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Box value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Box() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Box value)  $default,){
final _that = this;
switch (_that) {
case _Box():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Box value)?  $default,){
final _that = this;
switch (_that) {
case _Box() when $default != null:
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
case _Box() when $default != null:
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
case _Box():
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
case _Box() when $default != null:
return $default(_that.color,_that.count);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Box implements Box {
  const _Box({required this.color, required this.count});
  factory _Box.fromJson(Map<String, dynamic> json) => _$BoxFromJson(json);

@override final  int color;
@override final  int count;

/// Create a copy of Box
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BoxCopyWith<_Box> get copyWith => __$BoxCopyWithImpl<_Box>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BoxToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Box&&(identical(other.color, color) || other.color == color)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,color,count);

@override
String toString() {
  return 'Box(color: $color, count: $count)';
}


}

/// @nodoc
abstract mixin class _$BoxCopyWith<$Res> implements $BoxCopyWith<$Res> {
  factory _$BoxCopyWith(_Box value, $Res Function(_Box) _then) = __$BoxCopyWithImpl;
@override @useResult
$Res call({
 int color, int count
});




}
/// @nodoc
class __$BoxCopyWithImpl<$Res>
    implements _$BoxCopyWith<$Res> {
  __$BoxCopyWithImpl(this._self, this._then);

  final _Box _self;
  final $Res Function(_Box) _then;

/// Create a copy of Box
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? color = null,Object? count = null,}) {
  return _then(_Box(
color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as int,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
