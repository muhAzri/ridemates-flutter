/// The human-readable area resolved from coordinates by a client-side
/// reverse geocoder (contract R14 / FSD §5.2.1). Cosmetic only — the server
/// recomputes proximity from the precise pin, never from this label (LP-3).
class ResolvedArea {
  const ResolvedArea({this.displayArea, this.areaLevel});

  /// e.g. `"Kebayoran Baru"`. Null when the geocoder could not resolve a name.
  final String? displayArea;

  /// Granularity of [displayArea], e.g. `"kecamatan"` (contract R8).
  final String? areaLevel;
}
