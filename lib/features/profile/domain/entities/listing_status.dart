/// Lifecycle state of a marketplace listing (contract §17.2 `status`).
///
/// Pure domain enum — display labels are localised in the presentation layer.
enum ListingStatus {
  active,
  sold,
  inactive;

  /// Wire value (`active|sold|inactive`).
  String get apiValue => name;

  /// Parses an API value, defaulting to [active] for absent/unknown values.
  static ListingStatus fromApiValue(String? value) {
    for (final status in values) {
      if (status.name == value) return status;
    }
    return ListingStatus.active;
  }
}
