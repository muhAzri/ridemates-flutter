import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:ridemates/core/network/api_exception.dart';
import 'package:ridemates/features/profile/data/models/profile_listing_model.dart';
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

  /// First page of a user's listings (`GET /users/{userId}/listings`).
  /// Returns the items from the §1.5 `{ data, page }` envelope.
  Future<List<ProfileListingModel>> getUserListings(String userId) async {
    try {
      final res = await _dio.get<Map<String, dynamic>>(
        '/users/$userId/listings',
      );
      final data = (res.data?['data'] as List<dynamic>? ?? <dynamic>[])
          .cast<Map<String, dynamic>>();
      return data.map(ProfileListingModel.fromJson).toList();
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

  /// Avatar upload is **pre-signed / direct-to-storage** (API_CONTRACT.md R16),
  /// so the WebP bytes go straight to the object store and never transit the
  /// API server. Three steps: (1) ask the API for a pre-signed PUT, (2) upload
  /// the bytes to that URL, (3) confirm so the server records the avatar URL.
  Future<String?> uploadAvatar(Uint8List webpBytes) async {
    try {
      // Step 1 — pre-signed PUT for this content type.
      final issued = await _dio.post<Map<String, dynamic>>(
        '/users/me/avatar/upload-url',
        data: <String, dynamic>{'contentType': 'image/webp'},
      );
      final uploadUrl = issued.data!['uploadUrl'] as String;
      final rawHeaders =
          issued.data!['headers'] as Map<String, dynamic>? ??
          <String, dynamic>{};
      final signedHeaders = rawHeaders.map(
        (key, value) => MapEntry(key, value.toString()),
      );

      // Step 2 — upload bytes straight to storage. A bare Dio is used so the
      // API client's baseUrl and auth interceptor don't touch the signed S3
      // request (an extra Authorization header would clash with the
      // query-string auth). The signed `headers` (e.g. x-amz-acl) go verbatim.
      await Dio().put<void>(
        uploadUrl,
        data: Stream<List<int>>.fromIterable(<List<int>>[webpBytes]),
        options: Options(
          contentType: 'image/webp',
          headers: <String, dynamic>{
            ...signedHeaders,
            Headers.contentLengthHeader: webpBytes.length,
          },
        ),
      );

      // Step 3 — confirm; the server validates the object and returns its URL.
      final res = await _dio.put<Map<String, dynamic>>('/users/me/avatar');
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
