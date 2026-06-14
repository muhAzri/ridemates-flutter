// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserModel {

 String get id; String get email; String get displayName; String? get bio; String? get cyclingType; String? get avatarUrl; String? get contactPreference; String? get displayArea; String? get areaLevel; double? get ratingAverage; int get listingCount; int get threadCount; String get role; String? get createdAt;
/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserModelCopyWith<UserModel> get copyWith => _$UserModelCopyWithImpl<UserModel>(this as UserModel, _$identity);

  /// Serializes this UserModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserModel&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.cyclingType, cyclingType) || other.cyclingType == cyclingType)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.contactPreference, contactPreference) || other.contactPreference == contactPreference)&&(identical(other.displayArea, displayArea) || other.displayArea == displayArea)&&(identical(other.areaLevel, areaLevel) || other.areaLevel == areaLevel)&&(identical(other.ratingAverage, ratingAverage) || other.ratingAverage == ratingAverage)&&(identical(other.listingCount, listingCount) || other.listingCount == listingCount)&&(identical(other.threadCount, threadCount) || other.threadCount == threadCount)&&(identical(other.role, role) || other.role == role)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,email,displayName,bio,cyclingType,avatarUrl,contactPreference,displayArea,areaLevel,ratingAverage,listingCount,threadCount,role,createdAt);

@override
String toString() {
  return 'UserModel(id: $id, email: $email, displayName: $displayName, bio: $bio, cyclingType: $cyclingType, avatarUrl: $avatarUrl, contactPreference: $contactPreference, displayArea: $displayArea, areaLevel: $areaLevel, ratingAverage: $ratingAverage, listingCount: $listingCount, threadCount: $threadCount, role: $role, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $UserModelCopyWith<$Res>  {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) _then) = _$UserModelCopyWithImpl;
@useResult
$Res call({
 String id, String email, String displayName, String? bio, String? cyclingType, String? avatarUrl, String? contactPreference, String? displayArea, String? areaLevel, double? ratingAverage, int listingCount, int threadCount, String role, String? createdAt
});




}
/// @nodoc
class _$UserModelCopyWithImpl<$Res>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._self, this._then);

  final UserModel _self;
  final $Res Function(UserModel) _then;

/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? email = null,Object? displayName = null,Object? bio = freezed,Object? cyclingType = freezed,Object? avatarUrl = freezed,Object? contactPreference = freezed,Object? displayArea = freezed,Object? areaLevel = freezed,Object? ratingAverage = freezed,Object? listingCount = null,Object? threadCount = null,Object? role = null,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,cyclingType: freezed == cyclingType ? _self.cyclingType : cyclingType // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,contactPreference: freezed == contactPreference ? _self.contactPreference : contactPreference // ignore: cast_nullable_to_non_nullable
as String?,displayArea: freezed == displayArea ? _self.displayArea : displayArea // ignore: cast_nullable_to_non_nullable
as String?,areaLevel: freezed == areaLevel ? _self.areaLevel : areaLevel // ignore: cast_nullable_to_non_nullable
as String?,ratingAverage: freezed == ratingAverage ? _self.ratingAverage : ratingAverage // ignore: cast_nullable_to_non_nullable
as double?,listingCount: null == listingCount ? _self.listingCount : listingCount // ignore: cast_nullable_to_non_nullable
as int,threadCount: null == threadCount ? _self.threadCount : threadCount // ignore: cast_nullable_to_non_nullable
as int,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserModel].
extension UserModelPatterns on UserModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserModel value)  $default,){
final _that = this;
switch (_that) {
case _UserModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserModel value)?  $default,){
final _that = this;
switch (_that) {
case _UserModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String email,  String displayName,  String? bio,  String? cyclingType,  String? avatarUrl,  String? contactPreference,  String? displayArea,  String? areaLevel,  double? ratingAverage,  int listingCount,  int threadCount,  String role,  String? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserModel() when $default != null:
return $default(_that.id,_that.email,_that.displayName,_that.bio,_that.cyclingType,_that.avatarUrl,_that.contactPreference,_that.displayArea,_that.areaLevel,_that.ratingAverage,_that.listingCount,_that.threadCount,_that.role,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String email,  String displayName,  String? bio,  String? cyclingType,  String? avatarUrl,  String? contactPreference,  String? displayArea,  String? areaLevel,  double? ratingAverage,  int listingCount,  int threadCount,  String role,  String? createdAt)  $default,) {final _that = this;
switch (_that) {
case _UserModel():
return $default(_that.id,_that.email,_that.displayName,_that.bio,_that.cyclingType,_that.avatarUrl,_that.contactPreference,_that.displayArea,_that.areaLevel,_that.ratingAverage,_that.listingCount,_that.threadCount,_that.role,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String email,  String displayName,  String? bio,  String? cyclingType,  String? avatarUrl,  String? contactPreference,  String? displayArea,  String? areaLevel,  double? ratingAverage,  int listingCount,  int threadCount,  String role,  String? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _UserModel() when $default != null:
return $default(_that.id,_that.email,_that.displayName,_that.bio,_that.cyclingType,_that.avatarUrl,_that.contactPreference,_that.displayArea,_that.areaLevel,_that.ratingAverage,_that.listingCount,_that.threadCount,_that.role,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserModel implements UserModel {
  const _UserModel({required this.id, required this.email, required this.displayName, this.bio, this.cyclingType, this.avatarUrl, this.contactPreference, this.displayArea, this.areaLevel, this.ratingAverage, this.listingCount = 0, this.threadCount = 0, this.role = 'user', this.createdAt});
  factory _UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

@override final  String id;
@override final  String email;
@override final  String displayName;
@override final  String? bio;
@override final  String? cyclingType;
@override final  String? avatarUrl;
@override final  String? contactPreference;
@override final  String? displayArea;
@override final  String? areaLevel;
@override final  double? ratingAverage;
@override@JsonKey() final  int listingCount;
@override@JsonKey() final  int threadCount;
@override@JsonKey() final  String role;
@override final  String? createdAt;

/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserModelCopyWith<_UserModel> get copyWith => __$UserModelCopyWithImpl<_UserModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserModel&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.cyclingType, cyclingType) || other.cyclingType == cyclingType)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.contactPreference, contactPreference) || other.contactPreference == contactPreference)&&(identical(other.displayArea, displayArea) || other.displayArea == displayArea)&&(identical(other.areaLevel, areaLevel) || other.areaLevel == areaLevel)&&(identical(other.ratingAverage, ratingAverage) || other.ratingAverage == ratingAverage)&&(identical(other.listingCount, listingCount) || other.listingCount == listingCount)&&(identical(other.threadCount, threadCount) || other.threadCount == threadCount)&&(identical(other.role, role) || other.role == role)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,email,displayName,bio,cyclingType,avatarUrl,contactPreference,displayArea,areaLevel,ratingAverage,listingCount,threadCount,role,createdAt);

@override
String toString() {
  return 'UserModel(id: $id, email: $email, displayName: $displayName, bio: $bio, cyclingType: $cyclingType, avatarUrl: $avatarUrl, contactPreference: $contactPreference, displayArea: $displayArea, areaLevel: $areaLevel, ratingAverage: $ratingAverage, listingCount: $listingCount, threadCount: $threadCount, role: $role, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$UserModelCopyWith<$Res> implements $UserModelCopyWith<$Res> {
  factory _$UserModelCopyWith(_UserModel value, $Res Function(_UserModel) _then) = __$UserModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String email, String displayName, String? bio, String? cyclingType, String? avatarUrl, String? contactPreference, String? displayArea, String? areaLevel, double? ratingAverage, int listingCount, int threadCount, String role, String? createdAt
});




}
/// @nodoc
class __$UserModelCopyWithImpl<$Res>
    implements _$UserModelCopyWith<$Res> {
  __$UserModelCopyWithImpl(this._self, this._then);

  final _UserModel _self;
  final $Res Function(_UserModel) _then;

/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? email = null,Object? displayName = null,Object? bio = freezed,Object? cyclingType = freezed,Object? avatarUrl = freezed,Object? contactPreference = freezed,Object? displayArea = freezed,Object? areaLevel = freezed,Object? ratingAverage = freezed,Object? listingCount = null,Object? threadCount = null,Object? role = null,Object? createdAt = freezed,}) {
  return _then(_UserModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,cyclingType: freezed == cyclingType ? _self.cyclingType : cyclingType // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,contactPreference: freezed == contactPreference ? _self.contactPreference : contactPreference // ignore: cast_nullable_to_non_nullable
as String?,displayArea: freezed == displayArea ? _self.displayArea : displayArea // ignore: cast_nullable_to_non_nullable
as String?,areaLevel: freezed == areaLevel ? _self.areaLevel : areaLevel // ignore: cast_nullable_to_non_nullable
as String?,ratingAverage: freezed == ratingAverage ? _self.ratingAverage : ratingAverage // ignore: cast_nullable_to_non_nullable
as double?,listingCount: null == listingCount ? _self.listingCount : listingCount // ignore: cast_nullable_to_non_nullable
as int,threadCount: null == threadCount ? _self.threadCount : threadCount // ignore: cast_nullable_to_non_nullable
as int,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
