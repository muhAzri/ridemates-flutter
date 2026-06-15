import 'package:ridemates/features/profile/domain/entities/cycling_type.dart';

/// The signed-in user's own profile (contract §17.1 self projection — the
/// subset onboarding & settings care about).
class UserProfile {
  const UserProfile({
    required this.id,
    required this.displayName,
    this.bio,
    this.cyclingType,
    this.avatarUrl,
  });

  final String id;
  final String displayName;
  final String? bio;
  final CyclingType? cyclingType;
  final String? avatarUrl;
}
