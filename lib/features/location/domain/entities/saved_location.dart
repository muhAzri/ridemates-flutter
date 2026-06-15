/// Result of saving the user's pin (`PUT /users/me/location`). The server
/// **never** echoes coordinates — not even to the owner (LP-1) — so this holds
/// only the cached area label and when it was last updated.
class SavedLocation {
  const SavedLocation({this.displayArea, this.areaLevel, this.updatedAt});

  final String? displayArea;
  final String? areaLevel;
  final DateTime? updatedAt;
}
