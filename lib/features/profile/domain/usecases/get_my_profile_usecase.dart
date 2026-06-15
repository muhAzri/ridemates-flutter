import 'package:ridemates/features/profile/domain/entities/user_profile.dart';
import 'package:ridemates/features/profile/domain/repositories/profile_repository.dart';

class GetMyProfileUseCase {
  const GetMyProfileUseCase(this._repository);

  final ProfileRepository _repository;

  Future<UserProfile> call() => _repository.getMyProfile();
}
