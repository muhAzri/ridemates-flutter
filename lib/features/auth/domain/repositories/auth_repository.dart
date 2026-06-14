import 'package:ridemates/features/auth/domain/entities/auth_session.dart';

/// Auth port — the data layer implements this; presentation depends only on it.
abstract interface class AuthRepository {
  Future<AuthSession> register({
    required String email,
    required String password,
    required String displayName,
  });

  Future<AuthSession> logIn({
    required String email,
    required String password,
  });

  /// Google sign-in (UA-6): obtains a Google ID token, exchanges it with the
  /// backend, and persists the session. Returns null if the user cancels.
  Future<AuthSession?> signInWithGoogle();

  Future<void> logOut();

  Future<bool> isAuthenticated();
}
