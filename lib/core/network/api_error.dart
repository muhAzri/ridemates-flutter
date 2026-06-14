import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_error.freezed.dart';
part 'api_error.g.dart';

/// Standard error envelope returned by the RideMates API.
///
/// Mirrors the contract's §1.7 shape: `{ "error": { code, message, fields,
/// requestId } }`. Use [ApiErrorEnvelope.fromJson] to parse a full non-2xx
/// body, then read [ApiErrorEnvelope.error].
@freezed
abstract class ApiErrorEnvelope with _$ApiErrorEnvelope {
  const factory ApiErrorEnvelope({required ApiError error}) = _ApiErrorEnvelope;

  factory ApiErrorEnvelope.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorEnvelopeFromJson(json);
}

@freezed
abstract class ApiError with _$ApiError {
  const factory ApiError({
    /// Machine-readable code, e.g. `VALIDATION_ERROR`, `UNAUTHENTICATED`.
    required String code,

    /// Human-readable summary.
    required String message,

    /// Per-field validation errors (present for `VALIDATION_ERROR`).
    @Default(<String, String>{}) Map<String, String> fields,

    /// Server-side request id, useful for support/debugging.
    String? requestId,
  }) = _ApiError;

  factory ApiError.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorFromJson(json);
}
