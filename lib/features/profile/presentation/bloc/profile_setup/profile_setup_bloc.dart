import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ridemates/core/forms/form_status.dart';
import 'package:ridemates/core/media/image_pick_service.dart';
import 'package:ridemates/core/network/api_exception.dart';
import 'package:ridemates/features/profile/domain/entities/cycling_type.dart';
import 'package:ridemates/features/profile/domain/usecases/get_my_profile_usecase.dart';
import 'package:ridemates/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:ridemates/features/profile/domain/usecases/upload_avatar_usecase.dart';

part 'profile_setup_event.dart';
part 'profile_setup_state.dart';
part 'profile_setup_bloc.freezed.dart';

class ProfileSetupBloc extends Bloc<ProfileSetupEvent, ProfileSetupState> {
  ProfileSetupBloc(
    this._getMyProfile,
    this._updateProfile,
    this._uploadAvatar,
    this._imagePick,
  ) : super(const ProfileSetupState()) {
    on<ProfileSetupStarted>(_onStarted);
    on<ProfileSetupCyclingTypeSelected>(_onCyclingTypeSelected);
    on<ProfileSetupAvatarPickRequested>(_onAvatarPickRequested);
    on<ProfileSetupSubmitted>(_onSubmitted);
  }

  final GetMyProfileUseCase _getMyProfile;
  final UpdateProfileUseCase _updateProfile;
  final UploadAvatarUseCase _uploadAvatar;
  final ImagePickService _imagePick;

  Future<void> _onStarted(
    ProfileSetupStarted event,
    Emitter<ProfileSetupState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      // Prefill from the existing profile — Google sign-in auto-populates
      // displayName/avatarUrl, so the avatar shows up here ready to keep.
      final profile = await _getMyProfile();
      emit(
        state.copyWith(
          isLoading: false,
          avatarUrl: profile.avatarUrl,
          displayName: profile.displayName,
          bio: profile.bio,
          cyclingType: profile.cyclingType,
        ),
      );
    } on Object {
      emit(state.copyWith(isLoading: false));
    }
  }

  void _onCyclingTypeSelected(
    ProfileSetupCyclingTypeSelected event,
    Emitter<ProfileSetupState> emit,
  ) {
    emit(state.copyWith(cyclingType: event.cyclingType));
  }

  Future<void> _onAvatarPickRequested(
    ProfileSetupAvatarPickRequested event,
    Emitter<ProfileSetupState> emit,
  ) async {
    final bytes = await _imagePick.pickAvatar();
    if (bytes == null) return; // user cancelled the picker
    emit(state.copyWith(isUploadingAvatar: true, errorMessage: null));
    try {
      final avatarUrl = await _uploadAvatar(bytes);
      emit(state.copyWith(isUploadingAvatar: false, avatarUrl: avatarUrl));
    } on ApiException catch (e) {
      emit(
        state.copyWith(isUploadingAvatar: false, errorMessage: e.message),
      );
    } on Object {
      emit(state.copyWith(isUploadingAvatar: false));
    }
  }

  Future<void> _onSubmitted(
    ProfileSetupSubmitted event,
    Emitter<ProfileSetupState> emit,
  ) async {
    emit(state.copyWith(status: FormStatus.submitting, errorMessage: null));
    try {
      await _updateProfile(
        displayName: event.displayName,
        bio: event.bio,
        cyclingType: state.cyclingType,
      );
      emit(state.copyWith(status: FormStatus.success));
    } on ApiException catch (e) {
      emit(state.copyWith(status: FormStatus.failure, errorMessage: e.message));
    } on Object {
      emit(state.copyWith(status: FormStatus.failure));
    }
  }
}
