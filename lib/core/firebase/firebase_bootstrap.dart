import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/foundation.dart';
import 'package:ridemates/firebase_options.dart';

/// Initialises Firebase and wires Crashlytics, Performance and Analytics.
///
/// Call once, early in `bootstrap`, before `runApp`. Collection is disabled in
/// debug builds so local development never pollutes production dashboards.
Future<void> initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final crashlytics = FirebaseCrashlytics.instance;
  await crashlytics.setCrashlyticsCollectionEnabled(!kDebugMode);

  // Route uncaught Flutter framework errors and async/platform errors to
  // Crashlytics (no runZonedGuarded needed with PlatformDispatcher.onError).
  FlutterError.onError = crashlytics.recordFlutterFatalError;
  PlatformDispatcher.instance.onError = (error, stack) {
    unawaited(crashlytics.recordError(error, stack, fatal: true));
    return true;
  };

  await FirebasePerformance.instance.setPerformanceCollectionEnabled(
    !kDebugMode,
  );
  await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(!kDebugMode);
}
