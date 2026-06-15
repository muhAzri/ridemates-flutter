// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserProfileModel _$UserProfileModelFromJson(Map<String, dynamic> json) =>
    _UserProfileModel(
      id: json['id'] as String,
      displayName: json['displayName'] as String,
      bio: json['bio'] as String?,
      cyclingType: json['cyclingType'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      displayArea: json['displayArea'] as String?,
      listingCount: (json['listingCount'] as num?)?.toInt() ?? 0,
      threadCount: (json['threadCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$UserProfileModelToJson(_UserProfileModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'displayName': instance.displayName,
      'bio': instance.bio,
      'cyclingType': instance.cyclingType,
      'avatarUrl': instance.avatarUrl,
      'displayArea': instance.displayArea,
      'listingCount': instance.listingCount,
      'threadCount': instance.threadCount,
    };
