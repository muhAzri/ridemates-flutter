import 'package:dio/dio.dart';
import 'package:ridemates/core/network/api_exception.dart';
import 'package:ridemates/features/location/data/models/location_response_model.dart';

class LocationRemoteDataSource {
  LocationRemoteDataSource(this._dio);

  final Dio _dio;

  /// `PUT /users/me/location` (MP-9). Coordinates are sent on write only and
  /// never echoed back. The area label is optional.
  Future<LocationResponseModel> setLocation({
    required double lat,
    required double lng,
    String? displayArea,
    String? areaLevel,
  }) async {
    try {
      final res = await _dio.put<Map<String, dynamic>>(
        '/users/me/location',
        data: <String, dynamic>{
          'lat': lat,
          'lng': lng,
          'displayArea': ?displayArea,
          'areaLevel': ?areaLevel,
        },
      );
      return LocationResponseModel.fromJson(res.data!);
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }

  ApiException _toApiException(DioException e) {
    final error = e.error;
    return error is ApiException ? error : ApiException.fromDio(e);
  }
}
