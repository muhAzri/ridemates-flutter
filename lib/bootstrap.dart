import 'dart:async';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ridemates/core/di/injection.dart';
import 'package:ridemates/core/firebase/firebase_bootstrap.dart';
import 'package:ridemates/core/notifications/fcm_background_handler.dart';
import 'package:ridemates/core/notifications/notification_data.dart';
import 'package:ridemates/core/notifications/push_notification_service.dart';
import 'package:ridemates/core/storage/token_storage.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase first: initializeFirebase() installs the Crashlytics error
  // handlers, so anything after this is captured.
  await initializeFirebase();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  Bloc.observer = const AppBlocObserver();

  // Persisted bloc/cubit state (e.g. the signed-in user's /me snapshot) lives
  // in a hive_ce box under the app documents dir — hydrated_bloc is hive_ce
  // backed, so screens can read the last-known profile instantly on cold start.
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory(
      (await getApplicationDocumentsDirectory()).path,
    ),
  );

  await configureDependencies();

  // Load any stored access token into memory so the first authed request and
  // the Dio interceptor have it synchronously.
  await getIt<TokenStorage>().hydrate();

  // Foreground display + tap routing. For now every tap just opens the app;
  // deep-link routing is parsed and ready to enable (see [_onNotificationTap]).
  await getIt<PushNotificationService>().initialize(onTap: _onNotificationTap);

  runApp(await builder());
}

/// Handles a notification tap. Deep-linking is fully parsed
/// ([NotificationData.location]); routing is intentionally not wired yet, so a
/// tap simply brings the app to the foreground. Enable per-feature routing by
/// uncommenting the navigation once the target routes exist:
///
/// ```dart
/// final location = data.location;
/// if (location != null) getIt<GoRouter>().go(location);
/// ```
void _onNotificationTap(NotificationData data) {
  final location = data.location;
  if (location != null) {
    log('Notification deep-link (not yet routed): $location', name: 'push');
  }
}
