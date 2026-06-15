// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'location_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LocationResponseModel {

 String? get displayArea; String? get areaLevel; DateTime? get updatedAt;
/// Create a copy of LocationResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocationResponseModelCopyWith<LocationResponseModel> get copyWith => _$LocationResponseModelCopyWithImpl<LocationResponseModel>(this as LocationResponseModel, _$identity);

  /// Serializes this LocationResponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocationResponseModel&&(identical(other.displayArea, displayArea) || other.displayArea == displayArea)&&(identical(other.areaLevel, areaLevel) || other.areaLevel == areaLevel)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,displayArea,areaLevel,updatedAt);

@override
String toString() {
  return 'LocationResponseModel(displayArea: $displayArea, areaLevel: $areaLevel, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $LocationResponseModelCopyWith<$Res>  {
  factory $LocationResponseModelCopyWith(LocationResponseModel value, $Res Function(LocationResponseModel) _then) = _$LocationResponseModelCopyWithImpl;
@useResult
$Res call({
 String? displayArea, String? areaLevel, DateTime? updatedAt
});




}
/// @nodoc
class _$LocationResponseModelCopyWithImpl<$Res>
    implements $LocationResponseModelCopyWith<$Res> {
  _$LocationResponseModelCopyWithImpl(this._self, this._then);

  final LocationResponseModel _self;
  final $Res Function(LocationResponseModel) _then;

/// Create a copy of LocationResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? displayArea = freezed,Object? areaLevel = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
displayArea: freezed == displayArea ? _self.displayArea : displayArea // ignore: cast_nullable_to_non_nullable
as String?,areaLevel: freezed == areaLevel ? _self.areaLevel : areaLevel // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [LocationResponseModel].
extension LocationResponseModelPatterns on LocationResponseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LocationResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LocationResponseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LocationResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _LocationResponseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LocationResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _LocationResponseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? displayArea,  String? areaLevel,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LocationResponseModel() when $default != null:
return $default(_that.displayArea,_that.areaLevel,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? displayArea,  String? areaLevel,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _LocationResponseModel():
return $default(_that.displayArea,_that.areaLevel,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? displayArea,  String? areaLevel,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _LocationResponseModel() when $default != null:
return $default(_that.displayArea,_that.areaLevel,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LocationResponseModel implements LocationResponseModel {
  const _LocationResponseModel({this.displayArea, this.areaLevel, this.updatedAt});
  factory _LocationResponseModel.fromJson(Map<String, dynamic> json) => _$LocationResponseModelFromJson(json);

@override final  String? displayArea;
@override final  String? areaLevel;
@override final  DateTime? updatedAt;

/// Create a copy of LocationResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LocationResponseModelCopyWith<_LocationResponseModel> get copyWith => __$LocationResponseModelCopyWithImpl<_LocationResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LocationResponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LocationResponseModel&&(identical(other.displayArea, displayArea) || other.displayArea == displayArea)&&(identical(other.areaLevel, areaLevel) || other.areaLevel == areaLevel)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,displayArea,areaLevel,updatedAt);

@override
String toString() {
  return 'LocationResponseModel(displayArea: $displayArea, areaLevel: $areaLevel, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$LocationResponseModelCopyWith<$Res> implements $LocationResponseModelCopyWith<$Res> {
  factory _$LocationResponseModelCopyWith(_LocationResponseModel value, $Res Function(_LocationResponseModel) _then) = __$LocationResponseModelCopyWithImpl;
@override @useResult
$Res call({
 String? displayArea, String? areaLevel, DateTime? updatedAt
});




}
/// @nodoc
class __$LocationResponseModelCopyWithImpl<$Res>
    implements _$LocationResponseModelCopyWith<$Res> {
  __$LocationResponseModelCopyWithImpl(this._self, this._then);

  final _LocationResponseModel _self;
  final $Res Function(_LocationResponseModel) _then;

/// Create a copy of LocationResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? displayArea = freezed,Object? areaLevel = freezed,Object? updatedAt = freezed,}) {
  return _then(_LocationResponseModel(
displayArea: freezed == displayArea ? _self.displayArea : displayArea // ignore: cast_nullable_to_non_nullable
as String?,areaLevel: freezed == areaLevel ? _self.areaLevel : areaLevel // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
