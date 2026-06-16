import 'package:ridemates/features/settings/domain/entities/notification_preferences.dart';

abstract interface class SettingsRepository {
  /// Fetches the notification toggles (`GET /me/notification-preferences`).
  Future<NotificationPreferences> getNotificationPreferences();

  /// Updates the toggles (`PATCH /me/notification-preferences`). Only non-null
  /// fields are sent.
  Future<NotificationPreferences> updateNotificationPreferences({
    bool? newMessages,
    bool? threadReplies,
  });
}
