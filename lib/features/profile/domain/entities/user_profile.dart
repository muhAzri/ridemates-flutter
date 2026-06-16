import 'package:ridemates/features/profile/domain/entities/cycling_type.dart';

/// The signed-in user's own profile (contract §17.1 self projection).
class UserProfile {
  const UserProfile({
    required this.id,
    required this.displayName,
    this.email,
    this.bio,
    this.cyclingType,
    this.avatarUrl,
    this.displayArea,
    this.listingCount = 0,
    this.threadCount = 0,
  });

  final String id;
  final String displayName;

  /// Self projection only — never present on the public projection (§17.1).
  final String? email;

  final String? bio;
  final CyclingType? cyclingType;
  final String? avatarUrl;

  /// Coarse area label only — never coordinates (LP-1).
  final String? displayArea;

  /// Aggregate counts shown on the profile stat strip (screen 15).
  final int listingCount;
  final int threadCount;
}
