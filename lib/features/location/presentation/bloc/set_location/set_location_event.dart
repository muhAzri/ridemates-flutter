part of 'set_location_bloc.dart';

@freezed
sealed class SetLocationEvent with _$SetLocationEvent {
  /// Screen opened — auto-centre on the device and resolve the area.
  const factory SetLocationEvent.started() = SetLocationStarted;

  /// The map settled on a new centre (the pin). Triggers area resolution.
  const factory SetLocationEvent.pinMoved(LatLng point) = SetLocationPinMoved;

  /// User tapped the recenter control — re-acquire the device position.
  const factory SetLocationEvent.recenterRequested() =
      SetLocationRecenterRequested;

  /// User confirmed the pin — persist it (`PUT /users/me/location`).
  const factory SetLocationEvent.confirmed() = SetLocationConfirmed;
}
