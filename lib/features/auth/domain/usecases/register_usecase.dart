import 'package:ridemates/features/auth/domain/entities/auth_session.dart';
import 'package:ridemates/features/auth/domain/repositories/auth_repository.dart';

class RegisterUseCase {
  const RegisterUseCase(this._repository);

  final AuthRepository _repository;

  Future<AuthSession> call({
    required String email,
    required String password,
    required String displayName,
  }) {
    return _repository.register(
      email: email,
      password: password,
      displayName: displayName,
    );
  }
}
