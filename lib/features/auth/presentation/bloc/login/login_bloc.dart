import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ridemates/core/forms/form_status.dart';
import 'package:ridemates/core/network/api_exception.dart';
import 'package:ridemates/features/auth/domain/entities/auth_session.dart';
import 'package:ridemates/features/auth/domain/usecases/google_sign_in_usecase.dart';
import 'package:ridemates/features/auth/domain/usecases/login_usecase.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this._logIn, this._googleSignIn) : super(const LoginState()) {
    on<LoginSubmitted>(_onSubmitted);
    on<LoginGoogleRequested>(_onGoogleRequested);
  }

  final LogInUseCase _logIn;
  final GoogleSignInUseCase _googleSignIn;

  Future<void> _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: FormStatus.submitting, errorMessage: null));
    try {
      final session = await _logIn(
        email: event.email,
        password: event.password,
      );
      _emitSuccess(session, emit);
    } on ApiException catch (e) {
      emit(state.copyWith(status: FormStatus.failure, errorMessage: e.message));
    } on Object {
      emit(state.copyWith(status: FormStatus.failure));
    }
  }

  Future<void> _onGoogleRequested(
    LoginGoogleRequested event,
    Emitter<LoginState> emit,
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

  void _emitSuccess(AuthSession session, Emitter<LoginState> emit) {
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
