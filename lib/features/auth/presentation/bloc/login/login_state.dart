part of 'login_bloc.dart';

@freezed
abstract class LoginState with _$LoginState {
  const factory LoginState({
    @Default(FormStatus.initial) FormStatus status,
    @Default(false) bool isGoogleInProgress,
    @Default(false) bool needsProfileSetup,
    @Default(false) bool needsLocation,
    String? errorMessage,
  }) = _LoginState;
}
