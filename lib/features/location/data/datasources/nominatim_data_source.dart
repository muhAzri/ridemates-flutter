import 'package:dio/dio.dart';
import 'package:ridemates/features/location/data/models/nominatim_result_model.dart';

/// Client-side reverse geocoder backed by **OpenStreetMap Nominatim** (free).
///
/// Per contract R14 the server is *not* a geocoder proxy, so this calls the
/// public OSM service directly. Its own [Dio] is used (not the app client) so
/// requests carry no bearer token and don't hit the API base URL. We send a
/// descriptive `User-Agent` and `accept-language` as Nominatim's usage policy
/// requires, and keep timeouts short so geocoding never blocks saving.
class NominatimDataSource {
  NominatimDataSource({Dio? dio})
    : _dio =
          dio ??
          Dio(
            BaseOptions(
              baseUrl: 'https://nominatim.openstreetmap.org',
              connectTimeout: const Duration(seconds: 8),
              receiveTimeout: const Duration(seconds: 8),
              headers: const {
                'User-Agent': 'RideMates/1.0 (cycling community app)',
                'Accept-Language': 'id,en',
              },
            ),
          );

  final Dio _dio;

  /// Reverse-geocodes a coordinate to an area label, or null on any failure
  /// (the caller saves the pin regardless — the area is cosmetic).
  Future<NominatimResultModel?> reverse({
    required double lat,
    required double lng,
  }) async {
    try {
      final res = await _dio.get<Map<String, dynamic>>(
        '/reverse',
        queryParameters: <String, dynamic>{
          'lat': lat,
          'lon': lng,
          'format': 'jsonv2',
          'zoom': 14, // ~suburb / kecamatan granularity
          'addressdetails': 1,
        },
      );
      final data = res.data;
      if (data == null) return null;
      return NominatimResultModel.fromJson(data);
    } on DioException {
      return null;
    }
  }
}
