// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LocationResponseModel _$LocationResponseModelFromJson(
  Map<String, dynamic> json,
) => _LocationResponseModel(
  displayArea: json['displayArea'] as String?,
  areaLevel: json['areaLevel'] as String?,
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$LocationResponseModelToJson(
  _LocationResponseModel instance,
) => <String, dynamic>{
  'displayArea': instance.displayArea,
  'areaLevel': instance.areaLevel,
  'updatedAt': instance.updatedAt?.toIso8601String(),
};
