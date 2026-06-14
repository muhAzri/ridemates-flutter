import 'package:dio/dio.dart';
import 'package:ridemates/core/storage/token_storage.dart';

/// Attaches the bearer token and transparently refreshes it on `401`.
///
/// **Single-flight refresh:** if several requests fail with `401` at the same
/// time (e.g. a screen fires four calls with an expired token), only ONE
/// `POST /auth/refresh` is made — the rest await that same in-flight refresh and
/// are then retried with the new token. No refresh stampede.
class AuthInterceptor extends Interceptor {
  AuthInterceptor({
    required TokenStorage tokenStorage,
    required Dio refreshClient,
    this.onSessionExpired,
  }) : _tokenStorage = tokenStorage,
       _refreshClient = refreshClient;

  final TokenStorage _tokenStorage;

  /// Plain Dio (no auth interceptor) used to refresh + replay requests, so we
  /// never recurse back into this interceptor.
  final Dio _refreshClient;

  /// Invoked when refresh is impossible/failed (tokens already cleared here).
  final void Function()? onSessionExpired;

  /// The in-flight refresh shared by all concurrent 401s (single-flight guard).
  Future<String?>? _refreshing;

  static const String _retriedKey = 'auth_retried';

  bool _isAuthRoute(String path) =>
      path.contains('/auth/login') ||
      path.contains('/auth/register') ||
      path.contains('/auth/social') ||
      path.contains('/auth/refresh');

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = _tokenStorage.accessToken;
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final options = err.requestOptions;
    final is401 = err.response?.statusCode == 401;
    final alreadyRetried = options.extra[_retriedKey] == true;

    if (!is401 || alreadyRetried || _isAuthRoute(options.path)) {
      return handler.next(err);
    }

    final newToken = await _refresh();
    if (newToken == null) {
      await _tokenStorage.clearTokens();
      onSessionExpired?.call();
      return handler.next(err);
    }

    try {
      options
        ..headers['Authorization'] = 'Bearer $newToken'
        ..extra[_retriedKey] = true;
      final response = await _refreshClient.fetch<dynamic>(options);
      return handler.resolve(response);
    } on DioException catch (e) {
      return handler.next(e);
    }
  }

  /// Returns the new access token, or null if refresh failed. Coalesces
  /// concurrent callers onto a single refresh.
  Future<String?> _refresh() {
    return _refreshing ??= _performRefresh().whenComplete(() {
      _refreshing = null;
    });
  }

  Future<String?> _performRefresh() async {
    final refreshToken = await _tokenStorage.readRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) return null;
    try {
      final res = await _refreshClient.post<Map<String, dynamic>>(
        '/auth/refresh',
        data: {'refreshToken': refreshToken},
      );
      final tokens = res.data?['tokens'] as Map<String, dynamic>?;
      if (tokens == null) return null;
      final accessToken = tokens['accessToken'] as String;
      final newRefreshToken = tokens['refreshToken'] as String;
      await _tokenStorage.saveTokens(
        accessToken: accessToken,
        refreshToken: newRefreshToken,
      );
      return accessToken;
    } on DioException {
      return null;
    }
  }
}
