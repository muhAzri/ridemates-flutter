// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_preferences_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotificationPreferencesModel _$NotificationPreferencesModelFromJson(
  Map<String, dynamic> json,
) => _NotificationPreferencesModel(
  newMessages: json['newMessages'] as bool? ?? true,
  threadReplies: json['threadReplies'] as bool? ?? true,
);

Map<String, dynamic> _$NotificationPreferencesModelToJson(
  _NotificationPreferencesModel instance,
) => <String, dynamic>{
  'newMessages': instance.newMessages,
  'threadReplies': instance.threadReplies,
};
