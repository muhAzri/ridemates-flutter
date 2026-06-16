import 'package:dio/dio.dart';
import 'package:ridemates/core/network/api_exception.dart';
import 'package:ridemates/features/settings/data/models/notification_preferences_model.dart';

/// Talks to the Settings-backing endpoints (contract §14 / R6).
class SettingsRemoteDataSource {
  SettingsRemoteDataSource(this._dio);

  final Dio _dio;

  /// `GET /me/notification-preferences`.
  Future<NotificationPreferencesModel> getNotificationPreferences() async {
    try {
      final res = await _dio.get<Map<String, dynamic>>(
        '/me/notification-preferences',
      );
      return NotificationPreferencesModel.fromJson(res.data!);
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }

  /// `PATCH /me/notification-preferences` — accepts a partial of the toggles.
  Future<NotificationPreferencesModel> updateNotificationPreferences(
    Map<String, dynamic> body,
  ) async {
    try {
      final res = await _dio.patch<Map<String, dynamic>>(
        '/me/notification-preferences',
        data: body,
      );
      return NotificationPreferencesModel.fromJson(res.data!);
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }

  ApiException _toApiException(DioException e) {
    final error = e.error;
    return error is ApiException ? error : ApiException.fromDio(e);
  }
}
