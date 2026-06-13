import 'package:firebase_analytics/firebase_analytics.dart';

/// Thin wrapper around [FirebaseAnalytics] — the single entry point for logging
/// events and identifying users. Features depend on this, not the SDK directly.
class AnalyticsService {
  AnalyticsService(this._analytics)
    : navigatorObserver = FirebaseAnalyticsObserver(analytics: _analytics);

  final FirebaseAnalytics _analytics;

  /// Add to `MaterialApp.router`'s router observers to auto-log screen views.
  final FirebaseAnalyticsObserver navigatorObserver;

  Future<void> logEvent(String name, {Map<String, Object>? parameters}) =>
      _analytics.logEvent(name: name, parameters: parameters);

  Future<void> setUserId(String? id) => _analytics.setUserId(id: id);

  Future<void> setUserProperty({
    required String name,
    required String? value,
  }) => _analytics.setUserProperty(name: name, value: value);
}
