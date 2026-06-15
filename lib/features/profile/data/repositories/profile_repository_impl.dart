import 'dart:typed_data';

import 'package:ridemates/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:ridemates/features/profile/data/services/profile_mapper.dart';
import 'package:ridemates/features/profile/domain/entities/cycling_type.dart';
import 'package:ridemates/features/profile/domain/entities/profile_listing.dart';
import 'package:ridemates/features/profile/domain/entities/user_profile.dart';
import 'package:ridemates/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl(this._remote);

  final ProfileRemoteDataSource _remote;

  @override
  Future<UserProfile> getMyProfile() async {
    final model = await _remote.getMe();
    return model.toEntity();
  }

  @override
  Future<List<ProfileListing>> getUserListings(String userId) async {
    final models = await _remote.getUserListings(userId);
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<UserProfile> updateProfile({
    String? displayName,
    String? bio,
    CyclingType? cyclingType,
  }) async {
    final body = <String, dynamic>{
      'displayName': ?displayName,
      'bio': ?bio,
      'cyclingType': ?cyclingType?.apiValue,
    };
    final model = await _remote.updateProfile(body);
    return model.toEntity();
  }

  @override
  Future<String?> uploadAvatar(Uint8List webpBytes) =>
      _remote.uploadAvatar(webpBytes);
}
