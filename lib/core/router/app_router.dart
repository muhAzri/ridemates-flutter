import 'package:go_router/go_router.dart';
import 'package:ridemates/features/counter/counter.dart';

/// Centralised route names/paths so navigation stays type-safe-ish and
/// refactorable from one place.
abstract final class AppRoutes {
  static const home = '/';
}

/// Builds the app [GoRouter]. Registered as a singleton in the DI container.
GoRouter createRouter() {
  return GoRouter(
    initialLocation: AppRoutes.home,
    routes: [
      GoRoute(
        path: AppRoutes.home,
        name: 'home',
        builder: (context, state) => const CounterPage(),
      ),
    ],
  );
}
