// Ignore for testing purposes
// ignore_for_file: prefer_const_constructors

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:ridemates/app/app.dart';
import 'package:ridemates/core/di/injection.dart';
import 'package:ridemates/features/auth/presentation/screens/login_screen.dart';
import 'package:ridemates/features/splash/presentation/screens/splash_screen.dart';

/// Minimal in-memory [Storage] so [HydratedBloc]-backed cubits (e.g.
/// CurrentUserCubit) can be constructed in widget tests.
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
  group('App', () {
    setUp(() async {
      // No stored tokens → splash should route to login.
      FlutterSecureStorage.setMockInitialValues({});
      HydratedBloc.storage = _InMemoryStorage();
      await getIt.reset();
      await configureDependencies();
    });

    tearDown(getIt.reset);

    testWidgets('shows splash then routes to login when signed out', (
      tester,
    ) async {
      await tester.pumpWidget(App());
      expect(find.byType(SplashScreen), findsOneWidget);

      await tester.pump(const Duration(milliseconds: 1300));
      await tester.pumpAndSettle();
      expect(find.byType(LoginScreen), findsOneWidget);
    });
  });
}
