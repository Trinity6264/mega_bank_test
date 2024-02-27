part of "request_reset_password_bloc.dart";

@freezed
class RequestResetPasswordState with _$RequestResetPasswordState {
  const factory RequestResetPasswordState({
    @EmailConverter() @Default(Email.pure()) Email email,
    @Default(false) bool isRquestResetPasswordFormValidated,
  }) = _RequestResetPasswordState;
}
