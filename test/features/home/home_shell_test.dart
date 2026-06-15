import 'package:flutter_test/flutter_test.dart';
import 'package:ridemates/features/home/presentation/screens/home_shell.dart';

import '../../helpers/helpers.dart';

void main() {
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
      expect(find.text('Adi Pratama'), findsOneWidget);

      expect(tester.takeException(), isNull);
    });
  });
}
