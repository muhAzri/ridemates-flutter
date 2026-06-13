import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ridemates/core/config/app_config.dart';
import 'package:ridemates/core/network/api_exception.dart';

/// Builds the app's configured [Dio] instance.
///
/// - Base URL comes from the active [AppConfig].
/// - Sensible timeouts.
/// - An interceptor that maps transport-level [DioException]s into
///   domain-level [ApiException]s (parsing the §1.7 error envelope).
/// - A lightweight logging interceptor (dev only).
Dio buildDio({String? Function()? tokenProvider}) {
  final dio = Dio(
    BaseOptions(
      baseUrl: AppConfig.instance.apiBaseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 15),
      contentType: Headers.jsonContentType,
    ),
  );

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        final token = tokenProvider?.call();
        if (token != null && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },
      onError: (e, handler) {
        // Re-wrap as ApiException so call sites depend on the domain type.
        handler.reject(
          DioException(
            requestOptions: e.requestOptions,
            response: e.response,
            type: e.type,
            error: ApiException.fromDio(e),
          ),
        );
      },
    ),
  );

  if (AppConfig.instance.flavor != AppFlavor.production) {
    dio.interceptors.add(
      LogInterceptor(
        logPrint: (o) => log('$o', name: 'Dio'),
      ),
    );
  }

  return dio;
}
