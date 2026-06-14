import 'package:ridemates/features/auth/domain/entities/auth_tokens.dart';
import 'package:ridemates/features/auth/domain/entities/auth_user.dart';

class AuthSession {
  const AuthSession({
    required this.user,
    required this.tokens,
    required this.needsProfileSetup,
    required this.needsLocation,
  });

  final AuthUser user;
  final AuthTokens tokens;
  final bool needsProfileSetup;
  final bool needsLocation;
}
