/// The kind of riding a member does (contract §17.1 `cyclingType`).
///
/// Pure domain enum — display labels are localised in the presentation layer,
/// not stored here.
enum CyclingType {
  road,
  mtb,
  gravel,
  folding,
  casual;

  /// Wire value sent to / received from the API (`road|mtb|gravel|folding|casual`).
  String get apiValue => name;
}
