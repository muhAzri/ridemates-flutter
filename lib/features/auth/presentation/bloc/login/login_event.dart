part of 'login_bloc.dart';

@freezed
sealed class LoginEvent with _$LoginEvent {
  /// User submitted the login form with validated credentials.
  const factory LoginEvent.submitted({
    required String email,
    required String password,
  }) = LoginSubmitted;
}
