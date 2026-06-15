// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_setup_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProfileSetupEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileSetupEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileSetupEvent()';
}


}

/// @nodoc
class $ProfileSetupEventCopyWith<$Res>  {
$ProfileSetupEventCopyWith(ProfileSetupEvent _, $Res Function(ProfileSetupEvent) __);
}


/// Adds pattern-matching-related methods to [ProfileSetupEvent].
extension ProfileSetupEventPatterns on ProfileSetupEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ProfileSetupStarted value)?  started,TResult Function( ProfileSetupCyclingTypeSelected value)?  cyclingTypeSelected,TResult Function( ProfileSetupAvatarPickRequested value)?  avatarPickRequested,TResult Function( ProfileSetupSubmitted value)?  submitted,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ProfileSetupStarted() when started != null:
return started(_that);case ProfileSetupCyclingTypeSelected() when cyclingTypeSelected != null:
return cyclingTypeSelected(_that);case ProfileSetupAvatarPickRequested() when avatarPickRequested != null:
return avatarPickRequested(_that);case ProfileSetupSubmitted() when submitted != null:
return submitted(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ProfileSetupStarted value)  started,required TResult Function( ProfileSetupCyclingTypeSelected value)  cyclingTypeSelected,required TResult Function( ProfileSetupAvatarPickRequested value)  avatarPickRequested,required TResult Function( ProfileSetupSubmitted value)  submitted,}){
final _that = this;
switch (_that) {
case ProfileSetupStarted():
return started(_that);case ProfileSetupCyclingTypeSelected():
return cyclingTypeSelected(_that);case ProfileSetupAvatarPickRequested():
return avatarPickRequested(_that);case ProfileSetupSubmitted():
return submitted(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ProfileSetupStarted value)?  started,TResult? Function( ProfileSetupCyclingTypeSelected value)?  cyclingTypeSelected,TResult? Function( ProfileSetupAvatarPickRequested value)?  avatarPickRequested,TResult? Function( ProfileSetupSubmitted value)?  submitted,}){
final _that = this;
switch (_that) {
case ProfileSetupStarted() when started != null:
return started(_that);case ProfileSetupCyclingTypeSelected() when cyclingTypeSelected != null:
return cyclingTypeSelected(_that);case ProfileSetupAvatarPickRequested() when avatarPickRequested != null:
return avatarPickRequested(_that);case ProfileSetupSubmitted() when submitted != null:
return submitted(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( CyclingType cyclingType)?  cyclingTypeSelected,TResult Function()?  avatarPickRequested,TResult Function( String displayName,  String bio)?  submitted,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ProfileSetupStarted() when started != null:
return started();case ProfileSetupCyclingTypeSelected() when cyclingTypeSelected != null:
return cyclingTypeSelected(_that.cyclingType);case ProfileSetupAvatarPickRequested() when avatarPickRequested != null:
return avatarPickRequested();case ProfileSetupSubmitted() when submitted != null:
return submitted(_that.displayName,_that.bio);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( CyclingType cyclingType)  cyclingTypeSelected,required TResult Function()  avatarPickRequested,required TResult Function( String displayName,  String bio)  submitted,}) {final _that = this;
switch (_that) {
case ProfileSetupStarted():
return started();case ProfileSetupCyclingTypeSelected():
return cyclingTypeSelected(_that.cyclingType);case ProfileSetupAvatarPickRequested():
return avatarPickRequested();case ProfileSetupSubmitted():
return submitted(_that.displayName,_that.bio);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( CyclingType cyclingType)?  cyclingTypeSelected,TResult? Function()?  avatarPickRequested,TResult? Function( String displayName,  String bio)?  submitted,}) {final _that = this;
switch (_that) {
case ProfileSetupStarted() when started != null:
return started();case ProfileSetupCyclingTypeSelected() when cyclingTypeSelected != null:
return cyclingTypeSelected(_that.cyclingType);case ProfileSetupAvatarPickRequested() when avatarPickRequested != null:
return avatarPickRequested();case ProfileSetupSubmitted() when submitted != null:
return submitted(_that.displayName,_that.bio);case _:
  return null;

}
}

}

/// @nodoc


class ProfileSetupStarted implements ProfileSetupEvent {
  const ProfileSetupStarted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileSetupStarted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileSetupEvent.started()';
}


}




/// @nodoc


class ProfileSetupCyclingTypeSelected implements ProfileSetupEvent {
  const ProfileSetupCyclingTypeSelected(this.cyclingType);
  

 final  CyclingType cyclingType;

/// Create a copy of ProfileSetupEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileSetupCyclingTypeSelectedCopyWith<ProfileSetupCyclingTypeSelected> get copyWith => _$ProfileSetupCyclingTypeSelectedCopyWithImpl<ProfileSetupCyclingTypeSelected>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileSetupCyclingTypeSelected&&(identical(other.cyclingType, cyclingType) || other.cyclingType == cyclingType));
}


@override
int get hashCode => Object.hash(runtimeType,cyclingType);

@override
String toString() {
  return 'ProfileSetupEvent.cyclingTypeSelected(cyclingType: $cyclingType)';
}


}

/// @nodoc
abstract mixin class $ProfileSetupCyclingTypeSelectedCopyWith<$Res> implements $ProfileSetupEventCopyWith<$Res> {
  factory $ProfileSetupCyclingTypeSelectedCopyWith(ProfileSetupCyclingTypeSelected value, $Res Function(ProfileSetupCyclingTypeSelected) _then) = _$ProfileSetupCyclingTypeSelectedCopyWithImpl;
@useResult
$Res call({
 CyclingType cyclingType
});




}
/// @nodoc
class _$ProfileSetupCyclingTypeSelectedCopyWithImpl<$Res>
    implements $ProfileSetupCyclingTypeSelectedCopyWith<$Res> {
  _$ProfileSetupCyclingTypeSelectedCopyWithImpl(this._self, this._then);

  final ProfileSetupCyclingTypeSelected _self;
  final $Res Function(ProfileSetupCyclingTypeSelected) _then;

/// Create a copy of ProfileSetupEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? cyclingType = null,}) {
  return _then(ProfileSetupCyclingTypeSelected(
null == cyclingType ? _self.cyclingType : cyclingType // ignore: cast_nullable_to_non_nullable
as CyclingType,
  ));
}


}

/// @nodoc


class ProfileSetupAvatarPickRequested implements ProfileSetupEvent {
  const ProfileSetupAvatarPickRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileSetupAvatarPickRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileSetupEvent.avatarPickRequested()';
}


}




/// @nodoc


class ProfileSetupSubmitted implements ProfileSetupEvent {
  const ProfileSetupSubmitted({required this.displayName, required this.bio});
  

 final  String displayName;
 final  String bio;

/// Create a copy of ProfileSetupEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileSetupSubmittedCopyWith<ProfileSetupSubmitted> get copyWith => _$ProfileSetupSubmittedCopyWithImpl<ProfileSetupSubmitted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileSetupSubmitted&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.bio, bio) || other.bio == bio));
}


@override
int get hashCode => Object.hash(runtimeType,displayName,bio);

@override
String toString() {
  return 'ProfileSetupEvent.submitted(displayName: $displayName, bio: $bio)';
}


}

/// @nodoc
abstract mixin class $ProfileSetupSubmittedCopyWith<$Res> implements $ProfileSetupEventCopyWith<$Res> {
  factory $ProfileSetupSubmittedCopyWith(ProfileSetupSubmitted value, $Res Function(ProfileSetupSubmitted) _then) = _$ProfileSetupSubmittedCopyWithImpl;
@useResult
$Res call({
 String displayName, String bio
});




}
/// @nodoc
class _$ProfileSetupSubmittedCopyWithImpl<$Res>
    implements $ProfileSetupSubmittedCopyWith<$Res> {
  _$ProfileSetupSubmittedCopyWithImpl(this._self, this._then);

  final ProfileSetupSubmitted _self;
  final $Res Function(ProfileSetupSubmitted) _then;

/// Create a copy of ProfileSetupEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? displayName = null,Object? bio = null,}) {
  return _then(ProfileSetupSubmitted(
displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,bio: null == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$ProfileSetupState {

 bool get isLoading; bool get isUploadingAvatar; FormStatus get status; String? get avatarUrl; String? get displayName; String? get bio; CyclingType? get cyclingType; String? get errorMessage;
/// Create a copy of ProfileSetupState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileSetupStateCopyWith<ProfileSetupState> get copyWith => _$ProfileSetupStateCopyWithImpl<ProfileSetupState>(this as ProfileSetupState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileSetupState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isUploadingAvatar, isUploadingAvatar) || other.isUploadingAvatar == isUploadingAvatar)&&(identical(other.status, status) || other.status == status)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.cyclingType, cyclingType) || other.cyclingType == cyclingType)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isUploadingAvatar,status,avatarUrl,displayName,bio,cyclingType,errorMessage);

@override
String toString() {
  return 'ProfileSetupState(isLoading: $isLoading, isUploadingAvatar: $isUploadingAvatar, status: $status, avatarUrl: $avatarUrl, displayName: $displayName, bio: $bio, cyclingType: $cyclingType, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $ProfileSetupStateCopyWith<$Res>  {
  factory $ProfileSetupStateCopyWith(ProfileSetupState value, $Res Function(ProfileSetupState) _then) = _$ProfileSetupStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool isUploadingAvatar, FormStatus status, String? avatarUrl, String? displayName, String? bio, CyclingType? cyclingType, String? errorMessage
});




}
/// @nodoc
class _$ProfileSetupStateCopyWithImpl<$Res>
    implements $ProfileSetupStateCopyWith<$Res> {
  _$ProfileSetupStateCopyWithImpl(this._self, this._then);

  final ProfileSetupState _self;
  final $Res Function(ProfileSetupState) _then;

/// Create a copy of ProfileSetupState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isUploadingAvatar = null,Object? status = null,Object? avatarUrl = freezed,Object? displayName = freezed,Object? bio = freezed,Object? cyclingType = freezed,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isUploadingAvatar: null == isUploadingAvatar ? _self.isUploadingAvatar : isUploadingAvatar // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FormStatus,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,cyclingType: freezed == cyclingType ? _self.cyclingType : cyclingType // ignore: cast_nullable_to_non_nullable
as CyclingType?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProfileSetupState].
extension ProfileSetupStatePatterns on ProfileSetupState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileSetupState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileSetupState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileSetupState value)  $default,){
final _that = this;
switch (_that) {
case _ProfileSetupState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileSetupState value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileSetupState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  bool isUploadingAvatar,  FormStatus status,  String? avatarUrl,  String? displayName,  String? bio,  CyclingType? cyclingType,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileSetupState() when $default != null:
return $default(_that.isLoading,_that.isUploadingAvatar,_that.status,_that.avatarUrl,_that.displayName,_that.bio,_that.cyclingType,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  bool isUploadingAvatar,  FormStatus status,  String? avatarUrl,  String? displayName,  String? bio,  CyclingType? cyclingType,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _ProfileSetupState():
return $default(_that.isLoading,_that.isUploadingAvatar,_that.status,_that.avatarUrl,_that.displayName,_that.bio,_that.cyclingType,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  bool isUploadingAvatar,  FormStatus status,  String? avatarUrl,  String? displayName,  String? bio,  CyclingType? cyclingType,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _ProfileSetupState() when $default != null:
return $default(_that.isLoading,_that.isUploadingAvatar,_that.status,_that.avatarUrl,_that.displayName,_that.bio,_that.cyclingType,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _ProfileSetupState implements ProfileSetupState {
  const _ProfileSetupState({this.isLoading = true, this.isUploadingAvatar = false, this.status = FormStatus.initial, this.avatarUrl, this.displayName, this.bio, this.cyclingType, this.errorMessage});
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isUploadingAvatar;
@override@JsonKey() final  FormStatus status;
@override final  String? avatarUrl;
@override final  String? displayName;
@override final  String? bio;
@override final  CyclingType? cyclingType;
@override final  String? errorMessage;

/// Create a copy of ProfileSetupState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileSetupStateCopyWith<_ProfileSetupState> get copyWith => __$ProfileSetupStateCopyWithImpl<_ProfileSetupState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileSetupState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isUploadingAvatar, isUploadingAvatar) || other.isUploadingAvatar == isUploadingAvatar)&&(identical(other.status, status) || other.status == status)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.cyclingType, cyclingType) || other.cyclingType == cyclingType)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isUploadingAvatar,status,avatarUrl,displayName,bio,cyclingType,errorMessage);

@override
String toString() {
  return 'ProfileSetupState(isLoading: $isLoading, isUploadingAvatar: $isUploadingAvatar, status: $status, avatarUrl: $avatarUrl, displayName: $displayName, bio: $bio, cyclingType: $cyclingType, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$ProfileSetupStateCopyWith<$Res> implements $ProfileSetupStateCopyWith<$Res> {
  factory _$ProfileSetupStateCopyWith(_ProfileSetupState value, $Res Function(_ProfileSetupState) _then) = __$ProfileSetupStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool isUploadingAvatar, FormStatus status, String? avatarUrl, String? displayName, String? bio, CyclingType? cyclingType, String? errorMessage
});




}
/// @nodoc
class __$ProfileSetupStateCopyWithImpl<$Res>
    implements _$ProfileSetupStateCopyWith<$Res> {
  __$ProfileSetupStateCopyWithImpl(this._self, this._then);

  final _ProfileSetupState _self;
  final $Res Function(_ProfileSetupState) _then;

/// Create a copy of ProfileSetupState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isUploadingAvatar = null,Object? status = null,Object? avatarUrl = freezed,Object? displayName = freezed,Object? bio = freezed,Object? cyclingType = freezed,Object? errorMessage = freezed,}) {
  return _then(_ProfileSetupState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isUploadingAvatar: null == isUploadingAvatar ? _self.isUploadingAvatar : isUploadingAvatar // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FormStatus,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,cyclingType: freezed == cyclingType ? _self.cyclingType : cyclingType // ignore: cast_nullable_to_non_nullable
as CyclingType?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
