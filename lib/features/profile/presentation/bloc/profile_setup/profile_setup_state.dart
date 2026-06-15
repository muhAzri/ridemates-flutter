part of 'profile_setup_bloc.dart';

@freezed
abstract class ProfileSetupState with _$ProfileSetupState {
  const factory ProfileSetupState({
    @Default(true) bool isLoading,
    @Default(false) bool isUploadingAvatar,
    @Default(FormStatus.initial) FormStatus status,
    String? avatarUrl,
    String? displayName,
    String? bio,
    CyclingType? cyclingType,
    String? errorMessage,
  }) = _ProfileSetupState;
}
