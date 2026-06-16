import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ridemates/features/profile/domain/entities/user_profile.dart';
import 'package:ridemates/features/profile/domain/usecases/get_my_profile_usecase.dart';
import 'package:ridemates/features/profile/presentation/cubit/current_user_cubit.dart';

class _MockGetMyProfile extends Mock implements GetMyProfileUseCase {}

/// Minimal in-memory [Storage] so the HydratedCubit can be built in tests.
class _InMemoryStorage implements Storage {
  final _store = <String, dynamic>{};

  @override
  dynamic read(String key) => _store[key];

  @override
  Future<void> write(String key, dynamic value) async => _store[key] = value;

  @override
  Future<void> delete(String key) async => _store.remove(key);

  @override
  Future<void> clear() async => _store.clear();

  @override
  Future<void> close() async {}
}

void main() {
  late _MockGetMyProfile getMyProfile;

  const profile = UserProfile(id: 'usr_1', displayName: 'Adi Pratama');

  setUpAll(() {
    HydratedBloc.storage = _InMemoryStorage();
  });

  setUp(() {
    getMyProfile = _MockGetMyProfile();
  });

  CurrentUserCubit build() => CurrentUserCubit(getMyProfile);

  test('ensureLoaded fetches /me and exposes the user', () async {
    when(() => getMyProfile()).thenAnswer((_) async => profile);
    final cubit = build();

    await cubit.ensureLoaded();

    expect(cubit.state.user, profile);
    verify(() => getMyProfile()).called(1);
  });

  test(
    'concurrent ensureLoaded callers join one in-flight fetch and all '
    'observe the user (regression: spurious error after re-login)',
    () async {
      // A controllable in-flight request, so the second caller arrives while
      // the first is still pending — the original race.
      final completer = Completer<UserProfile>();
      when(() => getMyProfile()).thenAnswer((_) => completer.future);
      final cubit = build();

      final first = cubit.ensureLoaded();
      final second = cubit.ensureLoaded();

      // Both joined the same request — the use case ran exactly once.
      verify(() => getMyProfile()).called(1);

      completer.complete(profile);
      await Future.wait([first, second]);

      // The second caller did not read a not-yet-loaded (null) user.
      expect(cubit.state.user, profile);
    },
  );

  test('ensureLoaded is a no-op once loaded', () async {
    when(() => getMyProfile()).thenAnswer((_) async => profile);
    final cubit = build();

    await cubit.ensureLoaded();
    await cubit.ensureLoaded();

    verify(() => getMyProfile()).called(1);
  });

  test('signOut clears the user and allows a fresh load afterwards', () async {
    when(() => getMyProfile()).thenAnswer((_) async => profile);
    final cubit = build();
    await cubit.ensureLoaded();

    await cubit.signOut();
    expect(cubit.state.user, isNull);

    await cubit.ensureLoaded();
    expect(cubit.state.user, profile);
    verify(() => getMyProfile()).called(2);
  });

  test('refresh forces another fetch even after loading', () async {
    when(() => getMyProfile()).thenAnswer((_) async => profile);
    final cubit = build();

    await cubit.ensureLoaded();
    await cubit.refresh();

    verify(() => getMyProfile()).called(2);
  });
}
