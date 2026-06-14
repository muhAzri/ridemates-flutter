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

  Future<void> logOut();

  Future<bool> isAuthenticated();
}
