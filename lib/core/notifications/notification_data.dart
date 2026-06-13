/// Parsed payload of a push notification, with the deep-link destination it
/// targets (if any). Keeps deep-link mapping in one place so the tap handler
/// stays trivial.
class NotificationData {
  const NotificationData(this.raw);

  /// The remote message's `data` map (string key/value pairs from FCM).
  final Map<String, dynamic> raw;

  /// An in-app location to navigate to, or `null` when the push has no
  /// destination (→ the tap should just open the app).
  ///
  /// Supports either an explicit `deeplink`/`route` value, or a
  /// `targetType` + `targetId` pair as sent on notification payloads
  /// (API_CONTRACT §17.7: `conversation` | `thread` | `listing`).
  String? get location {
    final explicit = raw['deeplink'] ?? raw['route'];
    if (explicit is String && explicit.isNotEmpty) return explicit;

    final type = raw['targetType'] as String?;
    final id = raw['targetId'] as String?;
    if (type == null || id == null) return null;

    return switch (type) {
      'conversation' => '/conversations/$id',
      'thread' => '/threads/$id',
      'listing' => '/listings/$id',
      _ => null,
    };
  }
}
