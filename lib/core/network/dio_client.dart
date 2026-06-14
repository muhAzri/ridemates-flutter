import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ridemates/core/config/app_config.dart';
import 'package:ridemates/core/network/api_exception.dart';
import 'package:ridemates/core/network/auth_interceptor.dart';
import 'package:ridemates/core/storage/token_storage.dart';

BaseOptions _baseOptions() => BaseOptions(
  baseUrl: AppConfig.instance.apiBaseUrl,
  connectTimeout: const Duration(seconds: 15),
  receiveTimeout: const Duration(seconds: 15),
  sendTimeout: const Duration(seconds: 15),
  contentType: Headers.jsonContentType,
);

/// Builds the app's configured [Dio]: base URL/timeouts from [AppConfig], the
/// [AuthInterceptor] (bearer + single-flight 401 refresh), an error→
/// [ApiException] mapper, and a dev-only logger.
Dio buildDio(TokenStorage tokenStorage, {void Function()? onSessionExpired}) {
  final dio = Dio(_baseOptions());
  // Plain client (no auth interceptor) used for token refresh + request replay,
  // so refresh/retry never recurse back through [AuthInterceptor].
  final refreshClient = Dio(_baseOptions());

  dio.interceptors.add(
    AuthInterceptor(
      tokenStorage: tokenStorage,
      refreshClient: refreshClient,
      onSessionExpired: onSessionExpired,
    ),
  );

  dio.interceptors.add(
    InterceptorsWrapper(
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
      LogInterceptor(logPrint: (o) => log('$o', name: 'Dio')),
    );
  }

  return dio;
}
