import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:ridemates/core/network/api_exception.dart';
import 'package:ridemates/features/profile/data/models/user_profile_model.dart';

class ProfileRemoteDataSource {
  ProfileRemoteDataSource(this._dio);

  final Dio _dio;

  Future<UserProfileModel> getMe() async {
    try {
      final res = await _dio.get<Map<String, dynamic>>('/users/me');
      return UserProfileModel.fromJson(res.data!);
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }

  Future<UserProfileModel> updateProfile(Map<String, dynamic> body) async {
    try {
      final res = await _dio.patch<Map<String, dynamic>>(
        '/users/me',
        data: body,
      );
      return UserProfileModel.fromJson(res.data!);
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }

  Future<String?> uploadAvatar(Uint8List webpBytes) async {
    try {
      final form = FormData.fromMap({
        'file': MultipartFile.fromBytes(
          webpBytes,
          filename: 'avatar.webp',
          contentType: DioMediaType('image', 'webp'),
        ),
      });
      final res = await _dio.post<Map<String, dynamic>>(
        '/users/me/avatar',
        data: form,
      );
      return res.data?['avatarUrl'] as String?;
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }

  ApiException _toApiException(DioException e) {
    final error = e.error;
    return error is ApiException ? error : ApiException.fromDio(e);
  }
}
