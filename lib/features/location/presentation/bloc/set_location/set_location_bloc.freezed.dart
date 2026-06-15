// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'set_location_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SetLocationEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SetLocationEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SetLocationEvent()';
}


}

/// @nodoc
class $SetLocationEventCopyWith<$Res>  {
$SetLocationEventCopyWith(SetLocationEvent _, $Res Function(SetLocationEvent) __);
}


/// Adds pattern-matching-related methods to [SetLocationEvent].
extension SetLocationEventPatterns on SetLocationEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SetLocationStarted value)?  started,TResult Function( SetLocationPinMoved value)?  pinMoved,TResult Function( SetLocationRecenterRequested value)?  recenterRequested,TResult Function( SetLocationConfirmed value)?  confirmed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SetLocationStarted() when started != null:
return started(_that);case SetLocationPinMoved() when pinMoved != null:
return pinMoved(_that);case SetLocationRecenterRequested() when recenterRequested != null:
return recenterRequested(_that);case SetLocationConfirmed() when confirmed != null:
return confirmed(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SetLocationStarted value)  started,required TResult Function( SetLocationPinMoved value)  pinMoved,required TResult Function( SetLocationRecenterRequested value)  recenterRequested,required TResult Function( SetLocationConfirmed value)  confirmed,}){
final _that = this;
switch (_that) {
case SetLocationStarted():
return started(_that);case SetLocationPinMoved():
return pinMoved(_that);case SetLocationRecenterRequested():
return recenterRequested(_that);case SetLocationConfirmed():
return confirmed(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SetLocationStarted value)?  started,TResult? Function( SetLocationPinMoved value)?  pinMoved,TResult? Function( SetLocationRecenterRequested value)?  recenterRequested,TResult? Function( SetLocationConfirmed value)?  confirmed,}){
final _that = this;
switch (_that) {
case SetLocationStarted() when started != null:
return started(_that);case SetLocationPinMoved() when pinMoved != null:
return pinMoved(_that);case SetLocationRecenterRequested() when recenterRequested != null:
return recenterRequested(_that);case SetLocationConfirmed() when confirmed != null:
return confirmed(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( LatLng point)?  pinMoved,TResult Function()?  recenterRequested,TResult Function()?  confirmed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SetLocationStarted() when started != null:
return started();case SetLocationPinMoved() when pinMoved != null:
return pinMoved(_that.point);case SetLocationRecenterRequested() when recenterRequested != null:
return recenterRequested();case SetLocationConfirmed() when confirmed != null:
return confirmed();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( LatLng point)  pinMoved,required TResult Function()  recenterRequested,required TResult Function()  confirmed,}) {final _that = this;
switch (_that) {
case SetLocationStarted():
return started();case SetLocationPinMoved():
return pinMoved(_that.point);case SetLocationRecenterRequested():
return recenterRequested();case SetLocationConfirmed():
return confirmed();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( LatLng point)?  pinMoved,TResult? Function()?  recenterRequested,TResult? Function()?  confirmed,}) {final _that = this;
switch (_that) {
case SetLocationStarted() when started != null:
return started();case SetLocationPinMoved() when pinMoved != null:
return pinMoved(_that.point);case SetLocationRecenterRequested() when recenterRequested != null:
return recenterRequested();case SetLocationConfirmed() when confirmed != null:
return confirmed();case _:
  return null;

}
}

}

/// @nodoc


class SetLocationStarted implements SetLocationEvent {
  const SetLocationStarted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SetLocationStarted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SetLocationEvent.started()';
}


}




/// @nodoc


class SetLocationPinMoved implements SetLocationEvent {
  const SetLocationPinMoved(this.point);
  

 final  LatLng point;

/// Create a copy of SetLocationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SetLocationPinMovedCopyWith<SetLocationPinMoved> get copyWith => _$SetLocationPinMovedCopyWithImpl<SetLocationPinMoved>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SetLocationPinMoved&&(identical(other.point, point) || other.point == point));
}


@override
int get hashCode => Object.hash(runtimeType,point);

@override
String toString() {
  return 'SetLocationEvent.pinMoved(point: $point)';
}


}

/// @nodoc
abstract mixin class $SetLocationPinMovedCopyWith<$Res> implements $SetLocationEventCopyWith<$Res> {
  factory $SetLocationPinMovedCopyWith(SetLocationPinMoved value, $Res Function(SetLocationPinMoved) _then) = _$SetLocationPinMovedCopyWithImpl;
@useResult
$Res call({
 LatLng point
});




}
/// @nodoc
class _$SetLocationPinMovedCopyWithImpl<$Res>
    implements $SetLocationPinMovedCopyWith<$Res> {
  _$SetLocationPinMovedCopyWithImpl(this._self, this._then);

  final SetLocationPinMoved _self;
  final $Res Function(SetLocationPinMoved) _then;

/// Create a copy of SetLocationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? point = null,}) {
  return _then(SetLocationPinMoved(
null == point ? _self.point : point // ignore: cast_nullable_to_non_nullable
as LatLng,
  ));
}


}

/// @nodoc


class SetLocationRecenterRequested implements SetLocationEvent {
  const SetLocationRecenterRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SetLocationRecenterRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SetLocationEvent.recenterRequested()';
}


}




/// @nodoc


class SetLocationConfirmed implements SetLocationEvent {
  const SetLocationConfirmed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SetLocationConfirmed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SetLocationEvent.confirmed()';
}


}




/// @nodoc
mixin _$SetLocationState {

/// Acquiring the device position (initial centre or recenter).
 bool get isLocating;/// Reverse-geocoding the current pin into an area label.
 bool get isResolving;/// The confirmed-pin lifecycle for the "Confirm location" button.
 FormStatus get status;/// The current pin (map centre). Source of truth sent on confirm (LP-1).
 LatLng get pin;/// One-shot target the screen animates the map to (device / recenter).
 LatLng? get recenter;/// Resolved area label, e.g. `"Kebayoran Baru"` — null while unresolved.
 String? get displayArea;/// Granularity of [displayArea], e.g. `"kecamatan"`.
 String? get areaLevel; String? get errorMessage;
/// Create a copy of SetLocationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SetLocationStateCopyWith<SetLocationState> get copyWith => _$SetLocationStateCopyWithImpl<SetLocationState>(this as SetLocationState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SetLocationState&&(identical(other.isLocating, isLocating) || other.isLocating == isLocating)&&(identical(other.isResolving, isResolving) || other.isResolving == isResolving)&&(identical(other.status, status) || other.status == status)&&(identical(other.pin, pin) || other.pin == pin)&&(identical(other.recenter, recenter) || other.recenter == recenter)&&(identical(other.displayArea, displayArea) || other.displayArea == displayArea)&&(identical(other.areaLevel, areaLevel) || other.areaLevel == areaLevel)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLocating,isResolving,status,pin,recenter,displayArea,areaLevel,errorMessage);

@override
String toString() {
  return 'SetLocationState(isLocating: $isLocating, isResolving: $isResolving, status: $status, pin: $pin, recenter: $recenter, displayArea: $displayArea, areaLevel: $areaLevel, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $SetLocationStateCopyWith<$Res>  {
  factory $SetLocationStateCopyWith(SetLocationState value, $Res Function(SetLocationState) _then) = _$SetLocationStateCopyWithImpl;
@useResult
$Res call({
 bool isLocating, bool isResolving, FormStatus status, LatLng pin, LatLng? recenter, String? displayArea, String? areaLevel, String? errorMessage
});




}
/// @nodoc
class _$SetLocationStateCopyWithImpl<$Res>
    implements $SetLocationStateCopyWith<$Res> {
  _$SetLocationStateCopyWithImpl(this._self, this._then);

  final SetLocationState _self;
  final $Res Function(SetLocationState) _then;

/// Create a copy of SetLocationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLocating = null,Object? isResolving = null,Object? status = null,Object? pin = null,Object? recenter = freezed,Object? displayArea = freezed,Object? areaLevel = freezed,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
isLocating: null == isLocating ? _self.isLocating : isLocating // ignore: cast_nullable_to_non_nullable
as bool,isResolving: null == isResolving ? _self.isResolving : isResolving // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FormStatus,pin: null == pin ? _self.pin : pin // ignore: cast_nullable_to_non_nullable
as LatLng,recenter: freezed == recenter ? _self.recenter : recenter // ignore: cast_nullable_to_non_nullable
as LatLng?,displayArea: freezed == displayArea ? _self.displayArea : displayArea // ignore: cast_nullable_to_non_nullable
as String?,areaLevel: freezed == areaLevel ? _self.areaLevel : areaLevel // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SetLocationState].
extension SetLocationStatePatterns on SetLocationState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SetLocationState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SetLocationState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SetLocationState value)  $default,){
final _that = this;
switch (_that) {
case _SetLocationState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SetLocationState value)?  $default,){
final _that = this;
switch (_that) {
case _SetLocationState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLocating,  bool isResolving,  FormStatus status,  LatLng pin,  LatLng? recenter,  String? displayArea,  String? areaLevel,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SetLocationState() when $default != null:
return $default(_that.isLocating,_that.isResolving,_that.status,_that.pin,_that.recenter,_that.displayArea,_that.areaLevel,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLocating,  bool isResolving,  FormStatus status,  LatLng pin,  LatLng? recenter,  String? displayArea,  String? areaLevel,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _SetLocationState():
return $default(_that.isLocating,_that.isResolving,_that.status,_that.pin,_that.recenter,_that.displayArea,_that.areaLevel,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLocating,  bool isResolving,  FormStatus status,  LatLng pin,  LatLng? recenter,  String? displayArea,  String? areaLevel,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _SetLocationState() when $default != null:
return $default(_that.isLocating,_that.isResolving,_that.status,_that.pin,_that.recenter,_that.displayArea,_that.areaLevel,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _SetLocationState implements SetLocationState {
  const _SetLocationState({this.isLocating = false, this.isResolving = false, this.status = FormStatus.initial, this.pin = _defaultCenter, this.recenter, this.displayArea, this.areaLevel, this.errorMessage});
  

/// Acquiring the device position (initial centre or recenter).
@override@JsonKey() final  bool isLocating;
/// Reverse-geocoding the current pin into an area label.
@override@JsonKey() final  bool isResolving;
/// The confirmed-pin lifecycle for the "Confirm location" button.
@override@JsonKey() final  FormStatus status;
/// The current pin (map centre). Source of truth sent on confirm (LP-1).
@override@JsonKey() final  LatLng pin;
/// One-shot target the screen animates the map to (device / recenter).
@override final  LatLng? recenter;
/// Resolved area label, e.g. `"Kebayoran Baru"` — null while unresolved.
@override final  String? displayArea;
/// Granularity of [displayArea], e.g. `"kecamatan"`.
@override final  String? areaLevel;
@override final  String? errorMessage;

/// Create a copy of SetLocationState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SetLocationStateCopyWith<_SetLocationState> get copyWith => __$SetLocationStateCopyWithImpl<_SetLocationState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SetLocationState&&(identical(other.isLocating, isLocating) || other.isLocating == isLocating)&&(identical(other.isResolving, isResolving) || other.isResolving == isResolving)&&(identical(other.status, status) || other.status == status)&&(identical(other.pin, pin) || other.pin == pin)&&(identical(other.recenter, recenter) || other.recenter == recenter)&&(identical(other.displayArea, displayArea) || other.displayArea == displayArea)&&(identical(other.areaLevel, areaLevel) || other.areaLevel == areaLevel)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLocating,isResolving,status,pin,recenter,displayArea,areaLevel,errorMessage);

@override
String toString() {
  return 'SetLocationState(isLocating: $isLocating, isResolving: $isResolving, status: $status, pin: $pin, recenter: $recenter, displayArea: $displayArea, areaLevel: $areaLevel, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$SetLocationStateCopyWith<$Res> implements $SetLocationStateCopyWith<$Res> {
  factory _$SetLocationStateCopyWith(_SetLocationState value, $Res Function(_SetLocationState) _then) = __$SetLocationStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLocating, bool isResolving, FormStatus status, LatLng pin, LatLng? recenter, String? displayArea, String? areaLevel, String? errorMessage
});




}
/// @nodoc
class __$SetLocationStateCopyWithImpl<$Res>
    implements _$SetLocationStateCopyWith<$Res> {
  __$SetLocationStateCopyWithImpl(this._self, this._then);

  final _SetLocationState _self;
  final $Res Function(_SetLocationState) _then;

/// Create a copy of SetLocationState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLocating = null,Object? isResolving = null,Object? status = null,Object? pin = null,Object? recenter = freezed,Object? displayArea = freezed,Object? areaLevel = freezed,Object? errorMessage = freezed,}) {
  return _then(_SetLocationState(
isLocating: null == isLocating ? _self.isLocating : isLocating // ignore: cast_nullable_to_non_nullable
as bool,isResolving: null == isResolving ? _self.isResolving : isResolving // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FormStatus,pin: null == pin ? _self.pin : pin // ignore: cast_nullable_to_non_nullable
as LatLng,recenter: freezed == recenter ? _self.recenter : recenter // ignore: cast_nullable_to_non_nullable
as LatLng?,displayArea: freezed == displayArea ? _self.displayArea : displayArea // ignore: cast_nullable_to_non_nullable
as String?,areaLevel: freezed == areaLevel ? _self.areaLevel : areaLevel // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
