import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

/// Reads the device's current GPS position to auto-centre the map.
///
/// Geolocation only *centres* the map client-side — the confirmed pin is the
/// single source of truth sent to the server (FSD §5.2.1). This is best-effort:
/// it returns null when location services are off or permission is denied, and
/// the caller falls back to a sensible default centre.
class DeviceLocationService {
  /// Ensures permission, then returns the current position, or null if it is
  /// unavailable / denied. Never throws.
  Future<LatLng?> currentPosition() async {
    try {
      if (!await Geolocator.isLocationServiceEnabled()) return null;

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return null;
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 10),
        ),
      );
      return LatLng(position.latitude, position.longitude);
    } on Object {
      return null;
    }
  }
}
