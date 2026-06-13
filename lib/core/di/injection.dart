import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:ridemates/core/analytics/analytics_service.dart';
import 'package:ridemates/core/network/dio_client.dart';
import 'package:ridemates/core/network/sse/sse_client.dart';
import 'package:ridemates/core/notifications/push_notification_service.dart';
import 'package:ridemates/core/router/app_router.dart';

/// Global service locator.
final GetIt getIt = GetIt.instance;

/// Registers app-wide dependencies. Call once from `bootstrap`, before
/// `runApp` (and after `initializeFirebase`).
Future<void> configureDependencies() async {
  // --- Core ---------------------------------------------------------------
  getIt
    ..registerLazySingleton<Dio>(buildDio)
    ..registerLazySingleton<GoRouter>(createRouter)
    // SSE transport for the realtime stream (contract §10). Wire a real token
    // provider (e.g. from the auth store) once auth lands; null = anonymous.
    ..registerFactory<SseClient>(SseClient.new)
    // --- Firebase ----------------------------------------------------------
    ..registerLazySingleton<FirebaseAnalytics>(() => FirebaseAnalytics.instance)
    ..registerLazySingleton<AnalyticsService>(
      () => AnalyticsService(getIt<FirebaseAnalytics>()),
    )
    ..registerLazySingleton<FirebaseMessaging>(() => FirebaseMessaging.instance)
    ..registerLazySingleton<FlutterLocalNotificationsPlugin>(
      FlutterLocalNotificationsPlugin.new,
    )
    ..registerLazySingleton<PushNotificationService>(
      () => PushNotificationService(
        messaging: getIt<FirebaseMessaging>(),
        localNotifications: getIt<FlutterLocalNotificationsPlugin>(),
      ),
    );

  // --- Data sources / repositories / blocs --------------------------------
  // Register feature dependencies here as the app grows, e.g.:
  //   getIt.registerLazySingleton<AuthRepository>(
  //     () => AuthRepository(getIt<Dio>()),
  //   );
}
