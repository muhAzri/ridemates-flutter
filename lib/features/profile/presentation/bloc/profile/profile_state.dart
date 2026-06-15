part of 'profile_bloc.dart';

/// Load lifecycle for the Profile tab.
enum ProfileStatus { loading, success, failure }

@freezed
abstract class ProfileState with _$ProfileState {
  const factory ProfileState({
    @Default(ProfileStatus.loading) ProfileStatus status,
    UserProfile? profile,
    @Default(<ProfileListing>[]) List<ProfileListing> listings,
    String? errorMessage,
  }) = _ProfileState;
}
