part of 'profile_setup_bloc.dart';

@freezed
abstract class ProfileSetupState with _$ProfileSetupState {
  const factory ProfileSetupState({
    CyclingType? cyclingType,
    @Default(FormStatus.initial) FormStatus status,
    String? errorMessage,
  }) = _ProfileSetupState;
}
