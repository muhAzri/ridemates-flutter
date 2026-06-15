part of 'set_location_bloc.dart';

@freezed
abstract class SetLocationState with _$SetLocationState {
  const factory SetLocationState({
    /// Acquiring the device position (initial centre or recenter).
    @Default(false) bool isLocating,

    /// Reverse-geocoding the current pin into an area label.
    @Default(false) bool isResolving,

    /// The confirmed-pin lifecycle for the "Confirm location" button.
    @Default(FormStatus.initial) FormStatus status,

    /// The current pin (map centre). Source of truth sent on confirm (LP-1).
    @Default(_defaultCenter) LatLng pin,

    /// One-shot target the screen animates the map to (device / recenter).
    LatLng? recenter,

    /// Resolved area label, e.g. `"Kebayoran Baru"` — null while unresolved.
    String? displayArea,

    /// Granularity of [displayArea], e.g. `"kecamatan"`.
    String? areaLevel,

    String? errorMessage,
  }) = _SetLocationState;
}
