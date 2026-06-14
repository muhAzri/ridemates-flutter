import 'package:ridemates/features/auth/domain/entities/auth_session.dart';
import 'package:ridemates/features/auth/domain/repositories/auth_repository.dart';

class LogInUseCase {
  const LogInUseCase(this._repository);

  final AuthRepository _repository;

  Future<AuthSession> call({
    required String email,
    required String password,
  }) {
    return _repository.logIn(email: email, password: password);
  }
}
