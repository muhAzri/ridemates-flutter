// Ignore for testing purposes
// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:ridemates/app/app.dart';
import 'package:ridemates/core/di/injection.dart';
import 'package:ridemates/features/counter/counter.dart';

void main() {
  group('App', () {
    setUp(() async {
      await getIt.reset();
      await configureDependencies();
    });

    tearDown(getIt.reset);

    testWidgets('renders CounterPage', (tester) async {
      await tester.pumpWidget(App());
      expect(find.byType(CounterPage), findsOneWidget);
    });
  });
}
