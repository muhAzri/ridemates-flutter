// Ignore for testing purposes
// ignore_for_file: prefer_const_constructors

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ridemates/app/app.dart';
import 'package:ridemates/core/di/injection.dart';
import 'package:ridemates/features/auth/presentation/screens/login_screen.dart';
import 'package:ridemates/features/splash/presentation/screens/splash_screen.dart';

void main() {
  group('App', () {
    setUp(() async {
      // No stored tokens → splash should route to login.
      FlutterSecureStorage.setMockInitialValues({});
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
