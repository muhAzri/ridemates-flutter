part of 'profile_setup_bloc.dart';

@freezed
sealed class ProfileSetupEvent with _$ProfileSetupEvent {
  const factory ProfileSetupEvent.started() = ProfileSetupStarted;

  const factory ProfileSetupEvent.cyclingTypeSelected(CyclingType cyclingType) =
      ProfileSetupCyclingTypeSelected;

  const factory ProfileSetupEvent.avatarPickRequested() =
      ProfileSetupAvatarPickRequested;

  const factory ProfileSetupEvent.submitted({
    required String displayName,
    required String bio,
  }) = ProfileSetupSubmitted;
}
