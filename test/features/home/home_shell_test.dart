import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:ridemates/core/di/injection.dart';
import 'package:ridemates/features/home/presentation/screens/home_shell.dart';
import 'package:ridemates/features/profile/domain/entities/cycling_type.dart';
import 'package:ridemates/features/profile/domain/entities/listing_status.dart';
import 'package:ridemates/features/profile/domain/entities/profile_listing.dart';
import 'package:ridemates/features/profile/domain/entities/user_profile.dart';
import 'package:ridemates/features/profile/domain/repositories/profile_repository.dart';
import 'package:ridemates/features/profile/domain/usecases/get_my_profile_usecase.dart';
import 'package:ridemates/features/profile/domain/usecases/get_user_listings_usecase.dart';
import 'package:ridemates/features/profile/presentation/bloc/profile/profile_bloc.dart';

import '../../helpers/helpers.dart';

/// In-memory profile repository so the Profile tab can resolve [ProfileBloc]
/// from [getIt] without touching the network.
class _FakeProfileRepository implements ProfileRepository {
  @override
  Future<UserProfile> getMyProfile() async => const UserProfile(
    id: 'usr_1',
    displayName: 'Adi Pratama',
    cyclingType: CyclingType.road,
    displayArea: 'Kebayoran Baru',
    listingCount: 8,
    threadCount: 23,
  );

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
  setUp(() {
    final repo = _FakeProfileRepository();
    getIt.registerFactory<ProfileBloc>(
      () => ProfileBloc(
        GetMyProfileUseCase(repo),
        GetUserListingsUseCase(repo),
      ),
    );
  });

  tearDown(getIt.reset);

  group('HomeShell', () {
    testWidgets('renders the four tabs without layout/Material errors', (
      tester,
    ) async {
      await tester.pumpApp(const HomeShell());
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
      await tester.pumpApp(const HomeShell());
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
      // Profile data resolves from the fake repo via ProfileBloc.
      expect(find.text('Adi Pratama'), findsOneWidget);

      expect(tester.takeException(), isNull);
    });
  });
}
