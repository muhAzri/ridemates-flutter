import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:ridemates/core/analytics/analytics_service.dart';
import 'package:ridemates/core/location/device_location_service.dart';
import 'package:ridemates/core/media/image_pick_service.dart';
import 'package:ridemates/core/network/dio_client.dart';
import 'package:ridemates/core/network/sse/sse_client.dart';
import 'package:ridemates/core/notifications/push_notification_service.dart';
import 'package:ridemates/core/router/app_router.dart';
import 'package:ridemates/core/router/app_routes.dart';
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
import 'package:ridemates/features/location/data/datasources/location_remote_data_source.dart';
import 'package:ridemates/features/location/data/datasources/nominatim_data_source.dart';
import 'package:ridemates/features/location/data/repositories/location_repository_impl.dart';
import 'package:ridemates/features/location/domain/repositories/location_repository.dart';
import 'package:ridemates/features/location/domain/usecases/resolve_area_usecase.dart';
import 'package:ridemates/features/location/domain/usecases/set_my_location_usecase.dart';
import 'package:ridemates/features/location/presentation/bloc/set_location/set_location_bloc.dart';
import 'package:ridemates/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:ridemates/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:ridemates/features/profile/domain/repositories/profile_repository.dart';
import 'package:ridemates/features/profile/domain/usecases/get_my_profile_usecase.dart';
import 'package:ridemates/features/profile/domain/usecases/get_user_listings_usecase.dart';
import 'package:ridemates/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:ridemates/features/profile/domain/usecases/upload_avatar_usecase.dart';
import 'package:ridemates/features/profile/presentation/bloc/profile/profile_bloc.dart';
import 'package:ridemates/features/profile/presentation/bloc/profile_setup/profile_setup_bloc.dart';
import 'package:ridemates/features/profile/presentation/cubit/current_user_cubit.dart';
import 'package:ridemates/features/settings/data/datasources/settings_remote_data_source.dart';
import 'package:ridemates/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:ridemates/features/settings/domain/repositories/settings_repository.dart';
import 'package:ridemates/features/settings/domain/usecases/get_notification_preferences_usecase.dart';
import 'package:ridemates/features/settings/domain/usecases/update_notification_preferences_usecase.dart';
import 'package:ridemates/features/settings/presentation/cubit/notification_preferences_cubit.dart';

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
    ..registerFactory<GetUserListingsUseCase>(
      () => GetUserListingsUseCase(getIt<ProfileRepository>()),
    )
    ..registerFactory<UpdateProfileUseCase>(
      () => UpdateProfileUseCase(getIt<ProfileRepository>()),
    )
    ..registerFactory<UploadAvatarUseCase>(
      () => UploadAvatarUseCase(getIt<ProfileRepository>()),
    )
    // Shared, persisted (hive_ce) source of the signed-in user's `/me`,
    // consumed by Profile, Settings and any other screen — loaded once.
    ..registerLazySingleton<CurrentUserCubit>(
      () => CurrentUserCubit(getIt<GetMyProfileUseCase>()),
    )
    ..registerLazySingleton<ImagePickService>(ImagePickService.new)
    ..registerFactory<ProfileSetupBloc>(
      () => ProfileSetupBloc(
        getIt<GetMyProfileUseCase>(),
        getIt<UpdateProfileUseCase>(),
        getIt<UploadAvatarUseCase>(),
        getIt<ImagePickService>(),
      ),
    )
    ..registerFactory<ProfileBloc>(
      () => ProfileBloc(
        getIt<CurrentUserCubit>(),
        getIt<GetUserListingsUseCase>(),
      ),
    )
    // --- Location feature --------------------------------------------------
    ..registerLazySingleton<DeviceLocationService>(DeviceLocationService.new)
    ..registerLazySingleton<NominatimDataSource>(NominatimDataSource.new)
    ..registerLazySingleton<LocationRemoteDataSource>(
      () => LocationRemoteDataSource(getIt<Dio>()),
    )
    ..registerLazySingleton<LocationRepository>(
      () => LocationRepositoryImpl(
        getIt<LocationRemoteDataSource>(),
        getIt<NominatimDataSource>(),
      ),
    )
    ..registerFactory<ResolveAreaUseCase>(
      () => ResolveAreaUseCase(getIt<LocationRepository>()),
    )
    ..registerFactory<SetMyLocationUseCase>(
      () => SetMyLocationUseCase(getIt<LocationRepository>()),
    )
    ..registerFactory<SetLocationBloc>(
      () => SetLocationBloc(
        getIt<DeviceLocationService>(),
        getIt<ResolveAreaUseCase>(),
        getIt<SetMyLocationUseCase>(),
      ),
    )
    // --- Settings feature --------------------------------------------------
    ..registerLazySingleton<SettingsRemoteDataSource>(
      () => SettingsRemoteDataSource(getIt<Dio>()),
    )
    ..registerLazySingleton<SettingsRepository>(
      () => SettingsRepositoryImpl(getIt<SettingsRemoteDataSource>()),
    )
    ..registerFactory<GetNotificationPreferencesUseCase>(
      () => GetNotificationPreferencesUseCase(getIt<SettingsRepository>()),
    )
    ..registerFactory<UpdateNotificationPreferencesUseCase>(
      () => UpdateNotificationPreferencesUseCase(getIt<SettingsRepository>()),
    )
    // New cubit per Settings open → toggles are always fetched fresh.
    ..registerFactory<NotificationPreferencesCubit>(
      () => NotificationPreferencesCubit(
        getIt<GetNotificationPreferencesUseCase>(),
        getIt<UpdateNotificationPreferencesUseCase>(),
      ),
    );
}
