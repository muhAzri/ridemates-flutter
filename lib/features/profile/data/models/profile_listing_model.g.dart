// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_listing_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProfileListingModel _$ProfileListingModelFromJson(Map<String, dynamic> json) =>
    _ProfileListingModel(
      id: json['id'] as String,
      title: json['title'] as String,
      priceIdr: (json['priceIdr'] as num).toInt(),
      status: json['status'] as String?,
      displayArea: json['displayArea'] as String?,
      photos:
          (json['photos'] as List<dynamic>?)
              ?.map(
                (e) => ListingPhotoModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const <ListingPhotoModel>[],
    );

Map<String, dynamic> _$ProfileListingModelToJson(
  _ProfileListingModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'priceIdr': instance.priceIdr,
  'status': instance.status,
  'displayArea': instance.displayArea,
  'photos': instance.photos,
};

_ListingPhotoModel _$ListingPhotoModelFromJson(Map<String, dynamic> json) =>
    _ListingPhotoModel(url: json['url'] as String);

Map<String, dynamic> _$ListingPhotoModelToJson(_ListingPhotoModel instance) =>
    <String, dynamic>{'url': instance.url};
