part of 'create_account_bloc.dart';

@freezed
abstract class CreateAccountState with _$CreateAccountState {
  const factory CreateAccountState({
    @Default(FormStatus.initial) FormStatus status,
    String? errorMessage,
  }) = _CreateAccountState;
}
