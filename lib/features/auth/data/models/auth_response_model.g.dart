// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuthResponseModel _$AuthResponseModelFromJson(Map<String, dynamic> json) =>
    _AuthResponseModel(
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      tokens: AuthTokensModel.fromJson(json['tokens'] as Map<String, dynamic>),
      needsProfileSetup: json['needsProfileSetup'] as bool? ?? false,
      needsLocation: json['needsLocation'] as bool? ?? false,
    );

Map<String, dynamic> _$AuthResponseModelToJson(_AuthResponseModel instance) =>
    <String, dynamic>{
      'user': instance.user,
      'tokens': instance.tokens,
      'needsProfileSetup': instance.needsProfileSetup,
      'needsLocation': instance.needsLocation,
    };
