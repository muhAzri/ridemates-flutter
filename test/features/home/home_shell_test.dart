import 'dart:typed_data';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ridemates/core/di/injection.dart';
import 'package:ridemates/features/home/presentation/screens/home_shell.dart';
import 'package:ridemates/features/profile/domain/entities/cycling_type.dart';
import 'package:ridemates/features/profile/domain/entities/listing_status.dart';
import 'package:ridemates/features/profile/domain/entities/profile_listing.dart';
import 'package:ridemates/features/profile/domain/entities/user_profile.dart';
import 'package:ridemates/features/profile/domain/repositories/profile_repository.dart';
import 'package:ridemates/features/profile/domain/usecases/get_user_listings_usecase.dart';
import 'package:ridemates/features/profile/presentation/bloc/profile/profile_bloc.dart';
import 'package:ridemates/features/profile/presentation/cubit/current_user_cubit.dart';

import '../../helpers/helpers.dart';

const _profile = UserProfile(
  id: 'usr_1',
  displayName: 'Adi Pratama',
  cyclingType: CyclingType.road,
  displayArea: 'Kebayoran Baru',
  listingCount: 8,
  threadCount: 23,
);

/// The signed-in user comes from the shared store; the Profile tab reads it
/// without touching the network.
class _MockCurrentUserCubit extends MockCubit<CurrentUserState>
    implements CurrentUserCubit {}

/// In-memory profile repository so the Profile tab can resolve listings from
/// [getIt] without touching the network.
class _FakeProfileRepository implements ProfileRepository {
  @override
  Future<UserProfile> getMyProfile() async => _profile;

  @override
  Future<List<ProfileListing>> getUserListings(String userId) async => const [
    ProfileListing(
      id: 'lst_1',
      title: 'Shimano 105',
      priceIdr: 2450000,
      status: ListingStatus.active,
    ),
  ];

  @override
  Future<UserProfile> updateProfile({
    String? displayName,
    String? bio,
    CyclingType? cyclingType,
  }) => throw UnimplementedError();

  @override
  Future<String?> uploadAvatar(Uint8List webpBytes) =>
      throw UnimplementedError();
}

void main() {
  late _MockCurrentUserCubit currentUser;

  setUp(() {
    currentUser = _MockCurrentUserCubit();
    when(() => currentUser.state).thenReturn(
      const CurrentUserState(user: _profile),
    );
    when(() => currentUser.ensureLoaded()).thenAnswer((_) async {});

    final repo = _FakeProfileRepository();
    getIt.registerFactory<ProfileBloc>(
      () => ProfileBloc(currentUser, GetUserListingsUseCase(repo)),
    );
  });

  tearDown(getIt.reset);

  Widget subject() => BlocProvider<CurrentUserCubit>.value(
    value: currentUser,
    child: const HomeShell(),
  );

  group('HomeShell', () {
    testWidgets('renders the four tabs without layout/Material errors', (
      tester,
    ) async {
      await tester.pumpApp(subject());
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
      expect(find.text('Market'), findsOneWidget);
      expect(find.text('Forum'), findsOneWidget);
      expect(find.text('Chats'), findsOneWidget);
      expect(find.text('Profile'), findsOneWidget);

      // Browse (Market) is the default tab.
      expect(find.text('Marketplace'), findsOneWidget);
    });

    testWidgets('switches tabs via the bottom nav', (tester) async {
      await tester.pumpApp(subject());
      await tester.pumpAndSettle();

      await tester.tap(find.text('Forum'));
      await tester.pumpAndSettle();
      expect(find.text('Community'), findsOneWidget);

      await tester.tap(find.text('Chats'));
      await tester.pumpAndSettle();
      // The tab title (distinct from the 'Chats' nav label → two matches).
      expect(find.text('Chats'), findsNWidgets(2));
      expect(find.text('Search chats…'), findsOneWidget);

      await tester.tap(find.text('Profile'));
      await tester.pumpAndSettle();
      // Profile data resolves from the shared store via ProfileBloc.
      expect(find.text('Adi Pratama'), findsOneWidget);

      expect(tester.takeException(), isNull);
    });
  });
}
