import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:ridemates/core/notifications/notification_data.dart';

/// Called when the user taps a notification (foreground, background or cold
/// start). Receives the parsed payload so callers can deep-link.
typedef NotificationTapCallback = void Function(NotificationData data);

/// Wraps Firebase Cloud Messaging + local notifications.
///
/// - Requests permission and exposes the device token (register it with the
///   backend via `POST /me/devices`, contract NT-3/R15).
/// - Renders foreground messages as local notifications (Android shows nothing
///   for foreground pushes otherwise).
/// - Routes every tap through [NotificationTapCallback]; deep-linking is parsed
///   and ready, but for now a tap simply opens the app.
class PushNotificationService {
  PushNotificationService({
    required FirebaseMessaging messaging,
    required FlutterLocalNotificationsPlugin localNotifications,
  }) : _messaging = messaging,
       _local = localNotifications;

  final FirebaseMessaging _messaging;
  final FlutterLocalNotificationsPlugin _local;

  NotificationTapCallback? _onTap;

  /// Channel id must match `default_notification_channel_id` in the manifest.
  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'ridemates_default_channel',
    'General',
    description: 'General RideMates notifications',
    importance: Importance.high,
  );

  Future<void> initialize({NotificationTapCallback? onTap}) async {
    _onTap = onTap;

    await _messaging.requestPermission();
    await _messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    await _initLocalNotifications();

    FirebaseMessaging.onMessage.listen(_onForegroundMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleRemoteTap);

    // App launched from a terminated state by tapping a notification.
    final initial = await _messaging.getInitialMessage();
    if (initial != null) _handleRemoteTap(initial);
  }

  /// The FCM registration token for this device (null if unavailable).
  Future<String?> getToken() => _messaging.getToken();

  /// Emits whenever the FCM token rotates — re-register with the backend.
  Stream<String> get onTokenRefresh => _messaging.onTokenRefresh;

  Future<void> _initLocalNotifications() async {
    const settings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );
    await _local.initialize(
      settings: settings,
      onDidReceiveNotificationResponse: _onLocalTap,
    );
    await _local
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(_channel);
  }

  void _onForegroundMessage(RemoteMessage message) {
    final notification = message.notification;
    if (notification == null) return;

    unawaited(
      _local.show(
        id: notification.hashCode,
        title: notification.title,
        body: notification.body,
        notificationDetails: NotificationDetails(
          android: AndroidNotificationDetails(
            _channel.id,
            _channel.name,
            channelDescription: _channel.description,
            importance: Importance.high,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
          ),
          iOS: const DarwinNotificationDetails(),
        ),
        payload: jsonEncode(message.data),
      ),
    );
  }

  void _onLocalTap(NotificationResponse response) {
    final payload = response.payload;
    final data = (payload == null || payload.isEmpty)
        ? const <String, dynamic>{}
        : jsonDecode(payload) as Map<String, dynamic>;
    _onTap?.call(NotificationData(data));
  }

  void _handleRemoteTap(RemoteMessage message) =>
      _onTap?.call(NotificationData(message.data));
}
