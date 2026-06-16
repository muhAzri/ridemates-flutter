import 'package:ridemates/features/settings/domain/entities/notification_preferences.dart';
import 'package:ridemates/features/settings/domain/repositories/settings_repository.dart';

class GetNotificationPreferencesUseCase {
  const GetNotificationPreferencesUseCase(this._repository);

  final SettingsRepository _repository;

  Future<NotificationPreferences> call() =>
      _repository.getNotificationPreferences();
}
