import 'package:ridemates/features/location/domain/entities/resolved_area.dart';
import 'package:ridemates/features/location/domain/entities/saved_location.dart';

abstract interface class LocationRepository {
  /// Resolves a coordinate to an area label using a client-side OSM geocoder
  /// (contract R14). Returns null when the geocoder is unreachable or finds
  /// nothing — callers must treat the area as optional and never block on it.
  Future<ResolvedArea?> resolveArea({
    required double lat,
    required double lng,
  });

  /// Persists the confirmed pin (`PUT /users/me/location`, MP-9). Precise
  /// `lat`/`lng` are sent on write only; the optional resolved area is cached
  /// server-side as-is. Saving must not be blocked by a missing area (LP-1).
  Future<SavedLocation> setMyLocation({
    required double lat,
    required double lng,
    String? displayArea,
    String? areaLevel,
  });
}
