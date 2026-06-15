import 'dart:typed_data';

import 'package:ridemates/features/profile/domain/entities/cycling_type.dart';
import 'package:ridemates/features/profile/domain/entities/profile_listing.dart';
import 'package:ridemates/features/profile/domain/entities/user_profile.dart';

abstract interface class ProfileRepository {
  /// Fetches the signed-in user's profile (`GET /users/me`).
  Future<UserProfile> getMyProfile();

  /// Fetches a user's listings (`GET /users/{userId}/listings`).
  Future<List<ProfileListing>> getUserListings(String userId);

  /// Updates editable profile fields (`PATCH /users/me`). Only non-null fields
  /// are sent.
  Future<UserProfile> updateProfile({
    String? displayName,
    String? bio,
    CyclingType? cyclingType,
  });

  /// Uploads a new avatar (`POST /users/me/avatar`, multipart WebP) and returns
  /// the new avatar URL (null when cleared).
  Future<String?> uploadAvatar(Uint8List webpBytes);
}
