import 'package:ridemates/core/storage/token_storage.dart';
import 'package:ridemates/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:ridemates/features/auth/data/datasources/google_auth_data_source.dart';
import 'package:ridemates/features/auth/data/models/auth_response_model.dart';
import 'package:ridemates/features/auth/data/services/auth_mapper.dart';
import 'package:ridemates/features/auth/domain/entities/auth_session.dart';
import 'package:ridemates/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required AuthRemoteDataSource remote,
    required GoogleAuthDataSource googleAuth,
    required TokenStorage tokenStorage,
  }) : _remote = remote,
       _googleAuth = googleAuth,
       _tokenStorage = tokenStorage;

  final AuthRemoteDataSource _remote;
  final GoogleAuthDataSource _googleAuth;
  final TokenStorage _tokenStorage;

  @override
  Future<AuthSession> register({
    required String email,
    required String password,
    required String displayName,
  }) async {
    final model = await _remote.register(
      email: email,
      password: password,
      displayName: displayName,
    );
    await _persist(model);
    return model.toEntity();
  }

  @override
  Future<AuthSession> logIn({
    required String email,
    required String password,
  }) async {
    final model = await _remote.login(email: email, password: password);
    await _persist(model);
    return model.toEntity();
  }

  @override
  Future<AuthSession?> signInWithGoogle() async {
    final idToken = await _googleAuth.getIdToken();
    if (idToken == null) return null; // user cancelled
    final model = await _remote.socialGoogle(idToken);
    await _persist(model);
    return model.toEntity();
  }

  @override
  Future<void> logOut() async {
    try {
      await _remote.logout();
    } on Object {
      // Best-effort: even if the server call fails, clear local tokens below.
    } finally {
      await _tokenStorage.clearTokens();
    }
  }

  @override
  Future<bool> isAuthenticated() async =>
      (await _tokenStorage.readRefreshToken())?.isNotEmpty ?? false;

  Future<void> _persist(AuthResponseModel model) => _tokenStorage.saveTokens(
    accessToken: model.tokens.accessToken,
    refreshToken: model.tokens.refreshToken,
  );
}
