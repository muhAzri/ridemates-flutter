/// Secure persistence for auth tokens. Used by both the network layer (Dio
/// attaches [accessToken]) and the auth feature's data layer.
abstract interface class TokenStorage {
  /// Loads the access token into memory so [accessToken] is available
  /// synchronously to the Dio interceptor. Call once on startup.
  Future<void> hydrate();

  /// Cached access token (synchronous, for interceptors).
  String? get accessToken;

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  });

  Future<String?> readRefreshToken();

  Future<void> clearTokens();
}
