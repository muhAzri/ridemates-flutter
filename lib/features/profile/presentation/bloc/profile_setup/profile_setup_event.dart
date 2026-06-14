part of 'profile_setup_bloc.dart';

@freezed
sealed class ProfileSetupEvent with _$ProfileSetupEvent {
  /// User picked their riding type chip.
  const factory ProfileSetupEvent.cyclingTypeSelected(CyclingType cyclingType) =
      ProfileSetupCyclingTypeSelected;

  /// User submitted the profile form with validated fields.
  const factory ProfileSetupEvent.submitted({
    required String displayName,
    required String bio,
  }) = ProfileSetupSubmitted;
}
