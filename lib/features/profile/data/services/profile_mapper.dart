import 'package:ridemates/features/profile/data/models/profile_listing_model.dart';
import 'package:ridemates/features/profile/data/models/user_profile_model.dart';
import 'package:ridemates/features/profile/domain/entities/cycling_type.dart';
import 'package:ridemates/features/profile/domain/entities/listing_status.dart';
import 'package:ridemates/features/profile/domain/entities/profile_listing.dart';
import 'package:ridemates/features/profile/domain/entities/user_profile.dart';

extension UserProfileModelMapper on UserProfileModel {
  UserProfile toEntity() => UserProfile(
    id: id,
    displayName: displayName,
    bio: bio,
    cyclingType: CyclingType.fromApiValue(cyclingType),
    avatarUrl: avatarUrl,
    displayArea: displayArea,
    listingCount: listingCount,
    threadCount: threadCount,
  );
}

extension ProfileListingModelMapper on ProfileListingModel {
  ProfileListing toEntity() => ProfileListing(
    id: id,
    title: title,
    priceIdr: priceIdr,
    status: ListingStatus.fromApiValue(status),
    photoUrl: photos.isNotEmpty ? photos.first.url : null,
    displayArea: displayArea,
  );
}
