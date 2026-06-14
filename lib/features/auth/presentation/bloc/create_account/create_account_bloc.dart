import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ridemates/core/forms/form_status.dart';
import 'package:ridemates/core/network/api_exception.dart';
import 'package:ridemates/features/auth/domain/entities/auth_session.dart';
import 'package:ridemates/features/auth/domain/usecases/google_sign_in_usecase.dart';
import 'package:ridemates/features/auth/domain/usecases/register_usecase.dart';

part 'create_account_event.dart';
part 'create_account_state.dart';
part 'create_account_bloc.freezed.dart';

class CreateAccountBloc extends Bloc<CreateAccountEvent, CreateAccountState> {
  CreateAccountBloc(this._register, this._googleSignIn)
    : super(const CreateAccountState()) {
    on<CreateAccountSubmitted>(_onSubmitted);
    on<CreateAccountGoogleRequested>(_onGoogleRequested);
  }

  final RegisterUseCase _register;
  final GoogleSignInUseCase _googleSignIn;

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
      final session = await _register(
        email: event.email,
        password: event.password,
        displayName: displayName,
      );
      _emitSuccess(session, emit);
    } on ApiException catch (e) {
      emit(state.copyWith(status: FormStatus.failure, errorMessage: e.message));
    } on Object {
      emit(state.copyWith(status: FormStatus.failure));
    }
  }

  Future<void> _onGoogleRequested(
    CreateAccountGoogleRequested event,
    Emitter<CreateAccountState> emit,
  ) async {
    emit(state.copyWith(isGoogleInProgress: true, errorMessage: null));
    try {
      final session = await _googleSignIn();
      if (session == null) {
        emit(state.copyWith(isGoogleInProgress: false)); // user cancelled
        return;
      }
      _emitSuccess(session, emit);
    } on ApiException catch (e) {
      emit(
        state.copyWith(
          status: FormStatus.failure,
          isGoogleInProgress: false,
          errorMessage: e.message,
        ),
      );
    } on Object {
      emit(
        state.copyWith(status: FormStatus.failure, isGoogleInProgress: false),
      );
    }
  }

  void _emitSuccess(AuthSession session, Emitter<CreateAccountState> emit) {
    emit(
      state.copyWith(
        status: FormStatus.success,
        isGoogleInProgress: false,
        needsProfileSetup: session.needsProfileSetup,
        needsLocation: session.needsLocation,
      ),
    );
  }
}
