// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserModel _$UserModelFromJson(Map<String, dynamic> json) => _UserModel(
  id: json['id'] as String,
  email: json['email'] as String,
  displayName: json['displayName'] as String,
  bio: json['bio'] as String?,
  cyclingType: json['cyclingType'] as String?,
  avatarUrl: json['avatarUrl'] as String?,
  contactPreference: json['contactPreference'] as String?,
  displayArea: json['displayArea'] as String?,
  areaLevel: json['areaLevel'] as String?,
  ratingAverage: (json['ratingAverage'] as num?)?.toDouble(),
  listingCount: (json['listingCount'] as num?)?.toInt() ?? 0,
  threadCount: (json['threadCount'] as num?)?.toInt() ?? 0,
  role: json['role'] as String? ?? 'user',
  createdAt: json['createdAt'] as String?,
);

Map<String, dynamic> _$UserModelToJson(_UserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'displayName': instance.displayName,
      'bio': instance.bio,
      'cyclingType': instance.cyclingType,
      'avatarUrl': instance.avatarUrl,
      'contactPreference': instance.contactPreference,
      'displayArea': instance.displayArea,
      'areaLevel': instance.areaLevel,
      'ratingAverage': instance.ratingAverage,
      'listingCount': instance.listingCount,
      'threadCount': instance.threadCount,
      'role': instance.role,
      'createdAt': instance.createdAt,
    };
