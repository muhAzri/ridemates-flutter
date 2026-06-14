part of 'create_account_bloc.dart';

@freezed
abstract class CreateAccountState with _$CreateAccountState {
  const factory CreateAccountState({
    @Default(FormStatus.initial) FormStatus status,
    @Default(false) bool isGoogleInProgress,
    @Default(false) bool needsProfileSetup,
    @Default(false) bool needsLocation,
    String? errorMessage,
  }) = _CreateAccountState;
}
