import 'package:ridemates/features/profile/domain/entities/profile_listing.dart';
import 'package:ridemates/features/profile/domain/repositories/profile_repository.dart';

class GetUserListingsUseCase {
  const GetUserListingsUseCase(this._repository);

  final ProfileRepository _repository;

  Future<List<ProfileListing>> call(String userId) =>
      _repository.getUserListings(userId);
}
