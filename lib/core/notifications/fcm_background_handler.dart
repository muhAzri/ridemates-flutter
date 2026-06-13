import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:ridemates/firebase_options.dart';

/// Handles FCM messages received while the app is terminated/backgrounded.
///
/// Runs in its own isolate, so Firebase must be re-initialised here. Messages
/// carrying a `notification` block are displayed by the OS automatically; this
/// hook exists for future data-only handling.
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
