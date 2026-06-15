part of 'profile_bloc.dart';

@freezed
sealed class ProfileEvent with _$ProfileEvent {
  /// Initial load of the profile + listings.
  const factory ProfileEvent.started() = ProfileStarted;

  /// Re-fetch (pull-to-refresh / retry).
  const factory ProfileEvent.refreshed() = ProfileRefreshed;
}
