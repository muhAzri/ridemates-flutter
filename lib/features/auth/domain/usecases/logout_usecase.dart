import 'package:ridemates/features/auth/domain/repositories/auth_repository.dart';

class LogOutUseCase {
  const LogOutUseCase(this._repository);

  final AuthRepository _repository;

  Future<void> call() => _repository.logOut();
}
