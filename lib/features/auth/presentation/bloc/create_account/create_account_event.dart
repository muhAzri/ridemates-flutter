part of 'create_account_bloc.dart';

@freezed
sealed class CreateAccountEvent with _$CreateAccountEvent {
  const factory CreateAccountEvent.submitted({
    required String email,
    required String password,
  }) = CreateAccountSubmitted;

  const factory CreateAccountEvent.googleRequested() =
      CreateAccountGoogleRequested;
}
