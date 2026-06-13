import 'package:dio/dio.dart';
import 'package:ridemates/core/network/api_error.dart';

/// Domain-level exception thrown when an API call fails.
///
/// Wraps the transport-level [DioException] and, when the server returned the
/// standard error envelope (§1.7), the parsed [ApiError].
class ApiException implements Exception {
  const ApiException({
    required this.message,
    this.statusCode,
    this.error,
    this.isNetworkError = false,
  });

  /// Builds an [ApiException] from a Dio failure, parsing the error envelope
  /// when present.
  factory ApiException.fromDio(DioException e) {
    final statusCode = e.response?.statusCode;
    final data = e.response?.data;

    ApiError? error;
    if (data is Map<String, dynamic> && data['error'] is Map) {
      try {
        error = ApiErrorEnvelope.fromJson(data).error;
      } on Object {
        error = null;
      }
    }

    final isNetwork = switch (e.type) {
      DioExceptionType.connectionError ||
      DioExceptionType.connectionTimeout ||
      DioExceptionType.receiveTimeout ||
      DioExceptionType.sendTimeout =>
        true,
      _ => false,
    };

    return ApiException(
      message: error?.message ?? e.message ?? 'Something went wrong.',
      statusCode: statusCode,
      error: error,
      isNetworkError: isNetwork,
    );
  }

  /// Human-readable message suitable for surfacing to the UI.
  final String message;

  /// HTTP status code, when the request reached the server.
  final int? statusCode;

  /// Parsed error envelope, when the server returned one.
  final ApiError? error;

  /// True for timeouts / no-connectivity failures (no server response).
  final bool isNetworkError;

  /// Machine-readable code from the envelope, e.g. `UNAUTHENTICATED`.
  String? get code => error?.code;

  @override
  String toString() => 'ApiException(${statusCode ?? '-'}: $message)';
}
