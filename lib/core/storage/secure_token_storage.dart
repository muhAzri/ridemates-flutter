import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ridemates/core/storage/token_storage.dart';

/// [TokenStorage] backed by `flutter_secure_storage` (Keystore on Android,
/// Keychain on iOS). Keeps the access token in memory for synchronous reads.
class SecureTokenStorage implements TokenStorage {
  SecureTokenStorage(this._storage);

  final FlutterSecureStorage _storage;

  static const String _accessKey = 'rm_access_token';
  static const String _refreshKey = 'rm_refresh_token';

  String? _cachedAccessToken;

  @override
  String? get accessToken => _cachedAccessToken;

  @override
  Future<void> hydrate() async {
    _cachedAccessToken = await _storage.read(key: _accessKey);
  }

  @override
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    _cachedAccessToken = accessToken;
    await _storage.write(key: _accessKey, value: accessToken);
    await _storage.write(key: _refreshKey, value: refreshToken);
  }

  @override
  Future<String?> readRefreshToken() => _storage.read(key: _refreshKey);

  @override
  Future<void> clearTokens() async {
    _cachedAccessToken = null;
    await _storage.delete(key: _accessKey);
    await _storage.delete(key: _refreshKey);
  }
}
