import 'package:ridemates/features/profile/data/models/user_profile_model.dart';
import 'package:ridemates/features/profile/domain/entities/cycling_type.dart';
import 'package:ridemates/features/profile/domain/entities/user_profile.dart';

extension UserProfileModelMapper on UserProfileModel {
  UserProfile toEntity() => UserProfile(
    id: id,
    displayName: displayName,
    bio: bio,
    cyclingType: CyclingType.fromApiValue(cyclingType),
    avatarUrl: avatarUrl,
  );
}
