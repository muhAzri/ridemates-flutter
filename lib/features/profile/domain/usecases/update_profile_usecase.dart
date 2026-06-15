import 'package:ridemates/features/profile/domain/entities/cycling_type.dart';
import 'package:ridemates/features/profile/domain/entities/user_profile.dart';
import 'package:ridemates/features/profile/domain/repositories/profile_repository.dart';

class UpdateProfileUseCase {
  const UpdateProfileUseCase(this._repository);

  final ProfileRepository _repository;

  Future<UserProfile> call({
    String? displayName,
    String? bio,
    CyclingType? cyclingType,
  }) => _repository.updateProfile(
    displayName: displayName,
    bio: bio,
    cyclingType: cyclingType,
  );
}
