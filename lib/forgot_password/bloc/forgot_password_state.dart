part of "forgot_password_bloc.dart";

@freezed
class ForgotPasswordState with _$ForgotPasswordState {
  const factory ForgotPasswordState.initial() = _Initial;

  const factory ForgotPasswordState.stateChanged({
    @PasswordConverter() @Default(Password.pure()) Password password,
    @PasswordConverter()
    @Default(ConfirmedPassword.pure())
    ConfirmedPassword confirmedPassword,
    @Default(false) bool isForgotPasswordFormValid,
  }) = _StateChanged;

  const ForgotPasswordState._();

  bool get forgotPasswordFormValidated {
    if (this is _StateChanged) {
      return (this as _StateChanged).isForgotPasswordFormValid;
    }
    return false;
  }

  Password get passwordInputValue {
    if (this is _StateChanged) {
      return (this as _StateChanged).password;
    }
    return const Password.pure();
  }

  ConfirmedPassword get confirmedPasswordInputValue {
    if (this is _StateChanged) {
      return (this as _StateChanged).confirmedPassword;
    }
    return const ConfirmedPassword.pure();
  }
}
