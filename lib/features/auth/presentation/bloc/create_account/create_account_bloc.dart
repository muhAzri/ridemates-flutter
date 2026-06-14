import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ridemates/core/forms/form_status.dart';
import 'package:ridemates/core/network/api_exception.dart';
import 'package:ridemates/features/auth/domain/usecases/register_usecase.dart';

part 'create_account_event.dart';
part 'create_account_state.dart';
part 'create_account_bloc.freezed.dart';

/// Owns the sign-up submission lifecycle. Field validation lives in the form;
/// this bloc runs the [RegisterUseCase] and tracks status.
class CreateAccountBloc extends Bloc<CreateAccountEvent, CreateAccountState> {
  CreateAccountBloc(this._register) : super(const CreateAccountState()) {
    on<CreateAccountSubmitted>(_onSubmitted);
  }

  final RegisterUseCase _register;

  Future<void> _onSubmitted(
    CreateAccountSubmitted event,
    Emitter<CreateAccountState> emit,
  ) async {
    emit(state.copyWith(status: FormStatus.submitting, errorMessage: null));
    try {
      // The sign-up screen collects only email + password; a provisional
      // display name is derived from the email and the real one is set during
      // profile setup (needsProfileSetup → PATCH /users/me).
      final displayName = event.email.split('@').first;
      await _register(
        email: event.email,
        password: event.password,
        displayName: displayName,
      );
      emit(state.copyWith(status: FormStatus.success));
    } on ApiException catch (e) {
      emit(state.copyWith(status: FormStatus.failure, errorMessage: e.message));
    } on Object {
      emit(state.copyWith(status: FormStatus.failure));
    }
  }
}
