import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:ridemates/core/analytics/analytics_service.dart';
import 'package:ridemates/core/media/image_pick_service.dart';
import 'package:ridemates/core/network/dio_client.dart';
import 'package:ridemates/core/network/sse/sse_client.dart';
import 'package:ridemates/core/notifications/push_notification_service.dart';
import 'package:ridemates/core/router/app_router.dart';
import 'package:ridemates/core/storage/secure_token_storage.dart';
import 'package:ridemates/core/storage/token_storage.dart';
import 'package:ridemates/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:ridemates/features/auth/data/datasources/google_auth_data_source.dart';
import 'package:ridemates/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:ridemates/features/auth/domain/repositories/auth_repository.dart';
import 'package:ridemates/features/auth/domain/usecases/google_sign_in_usecase.dart';
import 'package:ridemates/features/auth/domain/usecases/login_usecase.dart';
import 'package:ridemates/features/auth/domain/usecases/logout_usecase.dart';
import 'package:ridemates/features/auth/domain/usecases/register_usecase.dart';
import 'package:ridemates/features/auth/presentation/bloc/create_account/create_account_bloc.dart';
import 'package:ridemates/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:ridemates/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:ridemates/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:ridemates/features/profile/domain/repositories/profile_repository.dart';
import 'package:ridemates/features/profile/domain/usecases/get_my_profile_usecase.dart';
import 'package:ridemates/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:ridemates/features/profile/domain/usecases/upload_avatar_usecase.dart';
import 'package:ridemates/features/profile/presentation/bloc/profile_setup/profile_setup_bloc.dart';

/// Global service locator.
final GetIt getIt = GetIt.instance;

/// Registers app-wide dependencies. Call once from `bootstrap`, before
/// `runApp` (and after `initializeFirebase`).
Future<void> configureDependencies() async {
  // --- Core ---------------------------------------------------------------
  getIt
    ..registerLazySingleton<FlutterSecureStorage>(FlutterSecureStorage.new)
    ..registerLazySingleton<TokenStorage>(
      () => SecureTokenStorage(getIt<FlutterSecureStorage>()),
    )
    ..registerLazySingleton<Dio>(
      () => buildDio(
        getIt<TokenStorage>(),
        // On unrecoverable auth failure, drop the user back to login.
        onSessionExpired: () => getIt<GoRouter>().go(AppRoutes.login),
      ),
    )
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
    )
    // --- Auth feature ------------------------------------------------------
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSource(getIt<Dio>()),
    )
    ..registerLazySingleton<GoogleAuthDataSource>(GoogleAuthDataSource.new)
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        remote: getIt<AuthRemoteDataSource>(),
        googleAuth: getIt<GoogleAuthDataSource>(),
        tokenStorage: getIt<TokenStorage>(),
      ),
    )
    ..registerFactory<RegisterUseCase>(
      () => RegisterUseCase(getIt<AuthRepository>()),
    )
    ..registerFactory<LogInUseCase>(() => LogInUseCase(getIt<AuthRepository>()))
    ..registerFactory<LogOutUseCase>(
      () => LogOutUseCase(getIt<AuthRepository>()),
    )
    ..registerFactory<GoogleSignInUseCase>(
      () => GoogleSignInUseCase(getIt<AuthRepository>()),
    )
    ..registerFactory<LoginBloc>(
      () => LoginBloc(getIt<LogInUseCase>(), getIt<GoogleSignInUseCase>()),
    )
    ..registerFactory<CreateAccountBloc>(
      () => CreateAccountBloc(
        getIt<RegisterUseCase>(),
        getIt<GoogleSignInUseCase>(),
      ),
    )
    // --- Profile feature ---------------------------------------------------
    ..registerLazySingleton<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSource(getIt<Dio>()),
    )
    ..registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(getIt<ProfileRemoteDataSource>()),
    )
    ..registerFactory<GetMyProfileUseCase>(
      () => GetMyProfileUseCase(getIt<ProfileRepository>()),
    )
    ..registerFactory<UpdateProfileUseCase>(
      () => UpdateProfileUseCase(getIt<ProfileRepository>()),
    )
    ..registerFactory<UploadAvatarUseCase>(
      () => UploadAvatarUseCase(getIt<ProfileRepository>()),
    )
    ..registerLazySingleton<ImagePickService>(ImagePickService.new)
    ..registerFactory<ProfileSetupBloc>(
      () => ProfileSetupBloc(
        getIt<GetMyProfileUseCase>(),
        getIt<UpdateProfileUseCase>(),
        getIt<UploadAvatarUseCase>(),
        getIt<ImagePickService>(),
      ),
    );
}
