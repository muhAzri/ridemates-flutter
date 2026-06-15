import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ridemates/core/network/api_exception.dart';
import 'package:ridemates/features/profile/domain/entities/listing_status.dart';
import 'package:ridemates/features/profile/domain/entities/profile_listing.dart';
import 'package:ridemates/features/profile/domain/entities/user_profile.dart';
import 'package:ridemates/features/profile/domain/usecases/get_my_profile_usecase.dart';
import 'package:ridemates/features/profile/domain/usecases/get_user_listings_usecase.dart';
import 'package:ridemates/features/profile/presentation/bloc/profile/profile_bloc.dart';

class _MockGetMyProfile extends Mock implements GetMyProfileUseCase {}

class _MockGetUserListings extends Mock implements GetUserListingsUseCase {}

void main() {
  late _MockGetMyProfile getMyProfile;
  late _MockGetUserListings getUserListings;

  const profile = UserProfile(
    id: 'usr_1',
    displayName: 'Adi Pratama',
    listingCount: 8,
    threadCount: 23,
  );
  const listings = [
    ProfileListing(
      id: 'lst_1',
      title: 'Shimano 105',
      priceIdr: 2450000,
      status: ListingStatus.active,
    ),
  ];

  setUp(() {
    getMyProfile = _MockGetMyProfile();
    getUserListings = _MockGetUserListings();
  });

  ProfileBloc build() => ProfileBloc(getMyProfile, getUserListings);

  group('ProfileBloc', () {
    blocTest<ProfileBloc, ProfileState>(
      'loads the profile then its listings on started',
      setUp: () {
        when(() => getMyProfile()).thenAnswer((_) async => profile);
        when(() => getUserListings(any())).thenAnswer((_) async => listings);
      },
      build: build,
      act: (bloc) => bloc.add(const ProfileEvent.started()),
      expect: () => const [
        ProfileState(),
        ProfileState(
          status: ProfileStatus.success,
          profile: profile,
          listings: listings,
        ),
      ],
      verify: (_) => verify(() => getUserListings('usr_1')).called(1),
    );

    blocTest<ProfileBloc, ProfileState>(
      'emits failure with the API message when the profile load fails',
      setUp: () => when(() => getMyProfile()).thenThrow(
        const ApiException(message: 'Could not load profile.'),
      ),
      build: build,
      act: (bloc) => bloc.add(const ProfileEvent.started()),
      expect: () => const [
        ProfileState(),
        ProfileState(
          status: ProfileStatus.failure,
          errorMessage: 'Could not load profile.',
        ),
      ],
    );

    blocTest<ProfileBloc, ProfileState>(
      'degrades to an empty grid when only the listings call fails',
      setUp: () {
        when(() => getMyProfile()).thenAnswer((_) async => profile);
        when(() => getUserListings(any())).thenThrow(Exception('boom'));
      },
      build: build,
      act: (bloc) => bloc.add(const ProfileEvent.started()),
      expect: () => const [
        ProfileState(),
        ProfileState(status: ProfileStatus.success, profile: profile),
      ],
    );
  });
}
