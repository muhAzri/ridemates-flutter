// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_listing_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProfileListingModel {

 String get id; String get title; int get priceIdr; String? get status; String? get displayArea; List<ListingPhotoModel> get photos;
/// Create a copy of ProfileListingModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileListingModelCopyWith<ProfileListingModel> get copyWith => _$ProfileListingModelCopyWithImpl<ProfileListingModel>(this as ProfileListingModel, _$identity);

  /// Serializes this ProfileListingModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileListingModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.priceIdr, priceIdr) || other.priceIdr == priceIdr)&&(identical(other.status, status) || other.status == status)&&(identical(other.displayArea, displayArea) || other.displayArea == displayArea)&&const DeepCollectionEquality().equals(other.photos, photos));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,priceIdr,status,displayArea,const DeepCollectionEquality().hash(photos));

@override
String toString() {
  return 'ProfileListingModel(id: $id, title: $title, priceIdr: $priceIdr, status: $status, displayArea: $displayArea, photos: $photos)';
}


}

/// @nodoc
abstract mixin class $ProfileListingModelCopyWith<$Res>  {
  factory $ProfileListingModelCopyWith(ProfileListingModel value, $Res Function(ProfileListingModel) _then) = _$ProfileListingModelCopyWithImpl;
@useResult
$Res call({
 String id, String title, int priceIdr, String? status, String? displayArea, List<ListingPhotoModel> photos
});




}
/// @nodoc
class _$ProfileListingModelCopyWithImpl<$Res>
    implements $ProfileListingModelCopyWith<$Res> {
  _$ProfileListingModelCopyWithImpl(this._self, this._then);

  final ProfileListingModel _self;
  final $Res Function(ProfileListingModel) _then;

/// Create a copy of ProfileListingModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? priceIdr = null,Object? status = freezed,Object? displayArea = freezed,Object? photos = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,priceIdr: null == priceIdr ? _self.priceIdr : priceIdr // ignore: cast_nullable_to_non_nullable
as int,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,displayArea: freezed == displayArea ? _self.displayArea : displayArea // ignore: cast_nullable_to_non_nullable
as String?,photos: null == photos ? _self.photos : photos // ignore: cast_nullable_to_non_nullable
as List<ListingPhotoModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [ProfileListingModel].
extension ProfileListingModelPatterns on ProfileListingModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileListingModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileListingModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileListingModel value)  $default,){
final _that = this;
switch (_that) {
case _ProfileListingModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileListingModel value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileListingModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  int priceIdr,  String? status,  String? displayArea,  List<ListingPhotoModel> photos)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileListingModel() when $default != null:
return $default(_that.id,_that.title,_that.priceIdr,_that.status,_that.displayArea,_that.photos);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  int priceIdr,  String? status,  String? displayArea,  List<ListingPhotoModel> photos)  $default,) {final _that = this;
switch (_that) {
case _ProfileListingModel():
return $default(_that.id,_that.title,_that.priceIdr,_that.status,_that.displayArea,_that.photos);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  int priceIdr,  String? status,  String? displayArea,  List<ListingPhotoModel> photos)?  $default,) {final _that = this;
switch (_that) {
case _ProfileListingModel() when $default != null:
return $default(_that.id,_that.title,_that.priceIdr,_that.status,_that.displayArea,_that.photos);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProfileListingModel implements ProfileListingModel {
  const _ProfileListingModel({required this.id, required this.title, required this.priceIdr, this.status, this.displayArea, final  List<ListingPhotoModel> photos = const <ListingPhotoModel>[]}): _photos = photos;
  factory _ProfileListingModel.fromJson(Map<String, dynamic> json) => _$ProfileListingModelFromJson(json);

@override final  String id;
@override final  String title;
@override final  int priceIdr;
@override final  String? status;
@override final  String? displayArea;
 final  List<ListingPhotoModel> _photos;
@override@JsonKey() List<ListingPhotoModel> get photos {
  if (_photos is EqualUnmodifiableListView) return _photos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_photos);
}


/// Create a copy of ProfileListingModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileListingModelCopyWith<_ProfileListingModel> get copyWith => __$ProfileListingModelCopyWithImpl<_ProfileListingModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProfileListingModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileListingModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.priceIdr, priceIdr) || other.priceIdr == priceIdr)&&(identical(other.status, status) || other.status == status)&&(identical(other.displayArea, displayArea) || other.displayArea == displayArea)&&const DeepCollectionEquality().equals(other._photos, _photos));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,priceIdr,status,displayArea,const DeepCollectionEquality().hash(_photos));

@override
String toString() {
  return 'ProfileListingModel(id: $id, title: $title, priceIdr: $priceIdr, status: $status, displayArea: $displayArea, photos: $photos)';
}


}

/// @nodoc
abstract mixin class _$ProfileListingModelCopyWith<$Res> implements $ProfileListingModelCopyWith<$Res> {
  factory _$ProfileListingModelCopyWith(_ProfileListingModel value, $Res Function(_ProfileListingModel) _then) = __$ProfileListingModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, int priceIdr, String? status, String? displayArea, List<ListingPhotoModel> photos
});




}
/// @nodoc
class __$ProfileListingModelCopyWithImpl<$Res>
    implements _$ProfileListingModelCopyWith<$Res> {
  __$ProfileListingModelCopyWithImpl(this._self, this._then);

  final _ProfileListingModel _self;
  final $Res Function(_ProfileListingModel) _then;

/// Create a copy of ProfileListingModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? priceIdr = null,Object? status = freezed,Object? displayArea = freezed,Object? photos = null,}) {
  return _then(_ProfileListingModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,priceIdr: null == priceIdr ? _self.priceIdr : priceIdr // ignore: cast_nullable_to_non_nullable
as int,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,displayArea: freezed == displayArea ? _self.displayArea : displayArea // ignore: cast_nullable_to_non_nullable
as String?,photos: null == photos ? _self._photos : photos // ignore: cast_nullable_to_non_nullable
as List<ListingPhotoModel>,
  ));
}


}


/// @nodoc
mixin _$ListingPhotoModel {

 String get url;
/// Create a copy of ListingPhotoModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ListingPhotoModelCopyWith<ListingPhotoModel> get copyWith => _$ListingPhotoModelCopyWithImpl<ListingPhotoModel>(this as ListingPhotoModel, _$identity);

  /// Serializes this ListingPhotoModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListingPhotoModel&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url);

@override
String toString() {
  return 'ListingPhotoModel(url: $url)';
}


}

/// @nodoc
abstract mixin class $ListingPhotoModelCopyWith<$Res>  {
  factory $ListingPhotoModelCopyWith(ListingPhotoModel value, $Res Function(ListingPhotoModel) _then) = _$ListingPhotoModelCopyWithImpl;
@useResult
$Res call({
 String url
});




}
/// @nodoc
class _$ListingPhotoModelCopyWithImpl<$Res>
    implements $ListingPhotoModelCopyWith<$Res> {
  _$ListingPhotoModelCopyWithImpl(this._self, this._then);

  final ListingPhotoModel _self;
  final $Res Function(ListingPhotoModel) _then;

/// Create a copy of ListingPhotoModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? url = null,}) {
  return _then(_self.copyWith(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ListingPhotoModel].
extension ListingPhotoModelPatterns on ListingPhotoModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ListingPhotoModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ListingPhotoModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ListingPhotoModel value)  $default,){
final _that = this;
switch (_that) {
case _ListingPhotoModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ListingPhotoModel value)?  $default,){
final _that = this;
switch (_that) {
case _ListingPhotoModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String url)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ListingPhotoModel() when $default != null:
return $default(_that.url);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String url)  $default,) {final _that = this;
switch (_that) {
case _ListingPhotoModel():
return $default(_that.url);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String url)?  $default,) {final _that = this;
switch (_that) {
case _ListingPhotoModel() when $default != null:
return $default(_that.url);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ListingPhotoModel implements ListingPhotoModel {
  const _ListingPhotoModel({required this.url});
  factory _ListingPhotoModel.fromJson(Map<String, dynamic> json) => _$ListingPhotoModelFromJson(json);

@override final  String url;

/// Create a copy of ListingPhotoModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ListingPhotoModelCopyWith<_ListingPhotoModel> get copyWith => __$ListingPhotoModelCopyWithImpl<_ListingPhotoModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ListingPhotoModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ListingPhotoModel&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url);

@override
String toString() {
  return 'ListingPhotoModel(url: $url)';
}


}

/// @nodoc
abstract mixin class _$ListingPhotoModelCopyWith<$Res> implements $ListingPhotoModelCopyWith<$Res> {
  factory _$ListingPhotoModelCopyWith(_ListingPhotoModel value, $Res Function(_ListingPhotoModel) _then) = __$ListingPhotoModelCopyWithImpl;
@override @useResult
$Res call({
 String url
});




}
/// @nodoc
class __$ListingPhotoModelCopyWithImpl<$Res>
    implements _$ListingPhotoModelCopyWith<$Res> {
  __$ListingPhotoModelCopyWithImpl(this._self, this._then);

  final _ListingPhotoModel _self;
  final $Res Function(_ListingPhotoModel) _then;

/// Create a copy of ListingPhotoModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? url = null,}) {
  return _then(_ListingPhotoModel(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
