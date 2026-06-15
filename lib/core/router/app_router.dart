import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:ridemates/core/analytics/analytics_service.dart';
import 'package:ridemates/core/di/injection.dart';
import 'package:ridemates/core/router/app_routes.dart';
import 'package:ridemates/features/auth/presentation/screens/create_account_screen.dart';
import 'package:ridemates/features/auth/presentation/screens/login_screen.dart';
import 'package:ridemates/features/home/presentation/screens/home_shell.dart';
import 'package:ridemates/features/location/presentation/screens/set_location_screen.dart';
import 'package:ridemates/features/profile/presentation/screens/profile_setup_screen.dart';
import 'package:ridemates/features/splash/presentation/screens/splash_screen.dart';

/// Builds the app [GoRouter]. Registered as a singleton in the DI container.
GoRouter createRouter() {
  return GoRouter(
    initialLocation: AppRoutes.splash,
    observers: _analyticsObservers(),
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.createAccount,
        name: 'createAccount',
        builder: (context, state) => const CreateAccountScreen(),
      ),
      GoRoute(
        path: AppRoutes.profileSetup,
        name: 'profileSetup',
        builder: (context, state) => const ProfileSetupScreen(),
      ),
      GoRoute(
        path: AppRoutes.setLocation,
        name: 'setLocation',
        builder: (context, state) => const SetLocationScreen(),
      ),
      GoRoute(
        path: AppRoutes.home,
        name: 'home',
        builder: (context, state) => const HomeShell(),
      ),
    ],
  );
}

/// Where to go after a successful auth (login / register / Google), forcing
/// onboarding so a user can never land on the app with incomplete data —
/// regardless of which screen they authenticated from (contract §3 flags).
String postAuthLocation({
  required bool needsProfileSetup,
  required bool needsLocation,
}) {
  if (needsProfileSetup) return AppRoutes.profileSetup;
  if (needsLocation) return AppRoutes.setLocation;
  return AppRoutes.home;
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
