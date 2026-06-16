import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_preferences_model.freezed.dart';
part 'notification_preferences_model.g.dart';

/// Wire model for `GET/PATCH /me/notification-preferences` (contract §14 / R6):
/// `{ "newMessages": true, "threadReplies": true }`. Defaults to opted in.
@freezed
abstract class NotificationPreferencesModel
    with _$NotificationPreferencesModel {
  const factory NotificationPreferencesModel({
    @Default(true) bool newMessages,
    @Default(true) bool threadReplies,
  }) = _NotificationPreferencesModel;

  factory NotificationPreferencesModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationPreferencesModelFromJson(json);
}
