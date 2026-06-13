import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:ridemates/core/network/dio_client.dart';
import 'package:ridemates/core/network/sse/sse_client.dart';
import 'package:ridemates/core/router/app_router.dart';

/// Global service locator.
final GetIt getIt = GetIt.instance;

/// Registers app-wide dependencies. Call once from `bootstrap`, before
/// `runApp`.
Future<void> configureDependencies() async {
  // --- Core ---------------------------------------------------------------
  getIt
    ..registerLazySingleton<Dio>(buildDio)
    ..registerLazySingleton<GoRouter>(createRouter)
    // SSE transport for the realtime stream (contract §10). Wire a real token
    // provider (e.g. from the auth store) once auth lands; null = anonymous.
    ..registerFactory<SseClient>(SseClient.new);

  // --- Data sources / repositories / blocs --------------------------------
  // Register feature dependencies here as the app grows, e.g.:
  //   getIt.registerLazySingleton<AuthRepository>(
  //     () => AuthRepository(getIt<Dio>()),
  //   );
}
