import 'package:ridemates/features/settings/data/datasources/settings_remote_data_source.dart';
import 'package:ridemates/features/settings/data/models/notification_preferences_model.dart';
import 'package:ridemates/features/settings/domain/entities/notification_preferences.dart';
import 'package:ridemates/features/settings/domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  SettingsRepositoryImpl(this._remote);

  final SettingsRemoteDataSource _remote;

  @override
  Future<NotificationPreferences> getNotificationPreferences() async {
    final model = await _remote.getNotificationPreferences();
    return model.toEntity();
  }

  @override
  Future<NotificationPreferences> updateNotificationPreferences({
    bool? newMessages,
    bool? threadReplies,
  }) async {
    final body = <String, dynamic>{
      'newMessages': ?newMessages,
      'threadReplies': ?threadReplies,
    };
    final model = await _remote.updateNotificationPreferences(body);
    return model.toEntity();
  }
}

extension on NotificationPreferencesModel {
  NotificationPreferences toEntity() => NotificationPreferences(
    newMessages: newMessages,
    threadReplies: threadReplies,
  );
}
