import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ridemates/core/network/api_exception.dart';
import 'package:ridemates/features/settings/domain/entities/notification_preferences.dart';
import 'package:ridemates/features/settings/domain/usecases/get_notification_preferences_usecase.dart';
import 'package:ridemates/features/settings/domain/usecases/update_notification_preferences_usecase.dart';
import 'package:ridemates/features/settings/presentation/cubit/notification_preferences_cubit.dart';

class _MockGet extends Mock implements GetNotificationPreferencesUseCase {}

class _MockUpdate extends Mock
    implements UpdateNotificationPreferencesUseCase {}

void main() {
  late _MockGet get;
  late _MockUpdate update;

  const bothOn = NotificationPreferences(
    newMessages: true,
    threadReplies: true,
  );
  const messagesOff = NotificationPreferences(
    newMessages: false,
    threadReplies: true,
  );
  const repliesOff = NotificationPreferences(
    newMessages: true,
    threadReplies: false,
  );

  setUp(() {
    get = _MockGet();
    update = _MockUpdate();
  });

  NotificationPreferencesCubit build() =>
      NotificationPreferencesCubit(get, update);

  group('load', () {
    blocTest<NotificationPreferencesCubit, NotificationPreferencesState>(
      'fetches the toggles on open',
      setUp: () => when(() => get()).thenAnswer((_) async => bothOn),
      build: build,
      act: (c) => c.load(),
      expect: () => const [
        NotificationPreferencesState(isLoading: true),
        NotificationPreferencesState(prefs: bothOn),
      ],
    );

    blocTest<NotificationPreferencesCubit, NotificationPreferencesState>(
      'surfaces the API message on a failed load',
      setUp: () => when(() => get()).thenThrow(
        const ApiException(message: 'No connection.'),
      ),
      build: build,
      act: (c) => c.load(),
      expect: () => const [
        NotificationPreferencesState(isLoading: true),
        NotificationPreferencesState(loadErrorMessage: 'No connection.'),
      ],
    );
  });

  group('optimistic toggle', () {
    blocTest<NotificationPreferencesCubit, NotificationPreferencesState>(
      'flips immediately then confirms with the saved value',
      setUp: () {
        when(() => get()).thenAnswer((_) async => bothOn);
        when(() => update(newMessages: false))
            .thenAnswer((_) async => messagesOff);
      },
      build: build,
      act: (c) async {
        await c.load();
        await c.setNewMessages(enabled: false);
      },
      skip: 2, // the two load() states
      // Optimistic flip and the server confirmation carry the same value, so
      // the duplicate state collapses to a single emission.
      expect: () => const [NotificationPreferencesState(prefs: messagesOff)],
      verify: (_) => verify(() => update(newMessages: false)).called(1),
    );

    blocTest<NotificationPreferencesCubit, NotificationPreferencesState>(
      'reverts and emits a saveError when the PATCH fails',
      setUp: () {
        when(() => get()).thenAnswer((_) async => bothOn);
        when(() => update(threadReplies: false)).thenThrow(
          const ApiException(message: 'Save failed.'),
        );
      },
      build: build,
      act: (c) async {
        await c.load();
        await c.setThreadReplies(enabled: false);
      },
      skip: 2,
      expect: () => const [
        NotificationPreferencesState(prefs: repliesOff), // optimistic flip
        NotificationPreferencesState(
          prefs: bothOn, // reverted
          saveError: SaveError('Save failed.'),
        ),
      ],
    );

    blocTest<NotificationPreferencesCubit, NotificationPreferencesState>(
      'ignores a toggle before preferences have loaded',
      build: build,
      act: (c) => c.setNewMessages(enabled: false),
      expect: () => const <NotificationPreferencesState>[],
      verify: (_) => verifyNever(
        () => update(newMessages: any(named: 'newMessages')),
      ),
    );
  });
}
