import 'package:ridemates/features/auth/domain/entities/auth_session.dart';
import 'package:ridemates/features/auth/domain/repositories/auth_repository.dart';

class GoogleSignInUseCase {
  const GoogleSignInUseCase(this._repository);

  final AuthRepository _repository;

  /// Returns the session, or null if the user cancels the Google flow.
  Future<AuthSession?> call() => _repository.signInWithGoogle();
}
