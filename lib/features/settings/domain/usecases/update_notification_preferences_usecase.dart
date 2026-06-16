import 'package:ridemates/features/settings/domain/entities/notification_preferences.dart';
import 'package:ridemates/features/settings/domain/repositories/settings_repository.dart';

class UpdateNotificationPreferencesUseCase {
  const UpdateNotificationPreferencesUseCase(this._repository);

  final SettingsRepository _repository;

  Future<NotificationPreferences> call({
    bool? newMessages,
    bool? threadReplies,
  }) => _repository.updateNotificationPreferences(
    newMessages: newMessages,
    threadReplies: threadReplies,
  );
}
