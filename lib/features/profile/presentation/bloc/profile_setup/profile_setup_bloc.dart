import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ridemates/core/forms/form_status.dart';
import 'package:ridemates/features/profile/domain/entities/cycling_type.dart';

part 'profile_setup_event.dart';
part 'profile_setup_state.dart';
part 'profile_setup_bloc.freezed.dart';

/// Owns profile-setup state: the selected riding type and the save lifecycle.
/// Text field validation lives in the form widget.
class ProfileSetupBloc extends Bloc<ProfileSetupEvent, ProfileSetupState> {
  ProfileSetupBloc() : super(const ProfileSetupState()) {
    on<ProfileSetupCyclingTypeSelected>(_onCyclingTypeSelected);
    on<ProfileSetupSubmitted>(_onSubmitted);
  }

  void _onCyclingTypeSelected(
    ProfileSetupCyclingTypeSelected event,
    Emitter<ProfileSetupState> emit,
  ) {
    emit(state.copyWith(cyclingType: event.cyclingType));
  }

  Future<void> _onSubmitted(
    ProfileSetupSubmitted event,
    Emitter<ProfileSetupState> emit,
  ) async {
    emit(state.copyWith(status: FormStatus.submitting));
    try {
      // TODO(profile): PATCH /users/me (+ avatar upload) via ProfileRepository
      // once the data layer lands.
      await Future<void>.delayed(const Duration(milliseconds: 700));
      emit(state.copyWith(status: FormStatus.success));
    } on Object {
      emit(state.copyWith(status: FormStatus.failure));
    }
  }
}
