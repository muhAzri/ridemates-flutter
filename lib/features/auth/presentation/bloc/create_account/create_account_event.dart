part of 'create_account_bloc.dart';

@freezed
sealed class CreateAccountEvent with _$CreateAccountEvent {
  /// User submitted the sign-up form with validated credentials.
  const factory CreateAccountEvent.submitted({
    required String email,
    required String password,
  }) = CreateAccountSubmitted;
}
