import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:ridemates/core/analytics/analytics_service.dart';
import 'package:ridemates/core/di/injection.dart';
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
    observers: _analyticsObservers(),
    routes: [
      GoRoute(
        path: AppRoutes.home,
        name: 'home',
        builder: (context, state) => const CounterPage(),
      ),
    ],
  );
}

/// Auto-logs screen views to Firebase Analytics. Skipped gracefully when
/// Firebase isn't initialised (e.g. in widget tests).
List<NavigatorObserver> _analyticsObservers() {
  try {
    return [getIt<AnalyticsService>().navigatorObserver];
  } on Object {
    return const [];
  }
}
