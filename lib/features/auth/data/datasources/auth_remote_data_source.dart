import 'package:dio/dio.dart';
import 'package:ridemates/core/network/api_exception.dart';
import 'package:ridemates/features/auth/data/models/auth_response_model.dart';

class AuthRemoteDataSource {
  AuthRemoteDataSource(this._dio);

  final Dio _dio;

  Future<AuthResponseModel> register({
    required String email,
    required String password,
    required String displayName,
  }) => _postAuth('/auth/register', {
    'email': email,
    'password': password,
    'displayName': displayName,
  });

  Future<AuthResponseModel> login({
    required String email,
    required String password,
  }) => _postAuth('/auth/login', {'email': email, 'password': password});

  Future<AuthResponseModel> socialGoogle(String idToken) =>
      _postAuth('/auth/social/google', {'idToken': idToken});

  Future<void> logout() async {
    try {
      await _dio.post<void>('/auth/logout');
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }

  Future<AuthResponseModel> _postAuth(
    String path,
    Map<String, dynamic> data,
  ) async {
    try {
      final res = await _dio.post<Map<String, dynamic>>(path, data: data);
      return AuthResponseModel.fromJson(res.data!);
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }

  ApiException _toApiException(DioException e) {
    final error = e.error;
    return error is ApiException ? error : ApiException.fromDio(e);
  }
}
