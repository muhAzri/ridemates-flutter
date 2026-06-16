import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ridemates/features/profile/domain/entities/listing_status.dart';
import 'package:ridemates/features/profile/domain/entities/profile_listing.dart';
import 'package:ridemates/features/profile/domain/entities/user_profile.dart';
import 'package:ridemates/features/profile/domain/usecases/get_user_listings_usecase.dart';
import 'package:ridemates/features/profile/presentation/bloc/profile/profile_bloc.dart';
import 'package:ridemates/features/profile/presentation/cubit/current_user_cubit.dart';

class _MockCurrentUserCubit extends MockCubit<CurrentUserState>
    implements CurrentUserCubit {}

class _MockGetUserListings extends Mock implements GetUserListingsUseCase {}

void main() {
  late _MockCurrentUserCubit currentUser;
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
    currentUser = _MockCurrentUserCubit();
    getUserListings = _MockGetUserListings();
    when(() => currentUser.ensureLoaded()).thenAnswer((_) async {});
    when(() => currentUser.refresh()).thenAnswer((_) async {});
  });

  ProfileBloc build() => ProfileBloc(currentUser, getUserListings);

  group('ProfileBloc', () {
    blocTest<ProfileBloc, ProfileState>(
      'loads the shared profile then its listings on started',
      setUp: () {
        when(() => currentUser.state).thenReturn(
          const CurrentUserState(user: profile),
        );
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
      verify: (_) {
        verify(() => currentUser.ensureLoaded()).called(1);
        verify(() => getUserListings('usr_1')).called(1);
      },
    );

    blocTest<ProfileBloc, ProfileState>(
      'emits failure with the store message when the profile is unavailable',
      setUp: () => when(() => currentUser.state).thenReturn(
        const CurrentUserState(errorMessage: 'Could not load profile.'),
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
        when(() => currentUser.state).thenReturn(
          const CurrentUserState(user: profile),
        );
        when(() => getUserListings(any())).thenThrow(Exception('boom'));
      },
      build: build,
      act: (bloc) => bloc.add(const ProfileEvent.started()),
      expect: () => const [
        ProfileState(),
        ProfileState(status: ProfileStatus.success, profile: profile),
      ],
    );

    blocTest<ProfileBloc, ProfileState>(
      'forces a store refresh on pull-to-refresh',
      setUp: () {
        when(() => currentUser.state).thenReturn(
          const CurrentUserState(user: profile),
        );
        when(() => getUserListings(any())).thenAnswer((_) async => listings);
      },
      build: build,
      act: (bloc) => bloc.add(const ProfileEvent.refreshed()),
      verify: (_) {
        verify(() => currentUser.refresh()).called(1);
        verifyNever(() => currentUser.ensureLoaded());
      },
    );
  });
}
