import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ridemates/core/forms/form_status.dart';
import 'package:ridemates/core/network/api_exception.dart';
import 'package:ridemates/features/auth/domain/usecases/login_usecase.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

/// Owns the login submission lifecycle. Field-level validation lives in the
/// form widget; this bloc runs the [LogInUseCase] and tracks status.
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this._logIn) : super(const LoginState()) {
    on<LoginSubmitted>(_onSubmitted);
  }

  final LogInUseCase _logIn;

  Future<void> _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: FormStatus.submitting, errorMessage: null));
    try {
      await _logIn(email: event.email, password: event.password);
      emit(state.copyWith(status: FormStatus.success));
    } on ApiException catch (e) {
      emit(state.copyWith(status: FormStatus.failure, errorMessage: e.message));
    } on Object {
      emit(state.copyWith(status: FormStatus.failure));
    }
  }
}
