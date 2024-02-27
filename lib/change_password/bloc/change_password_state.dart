part of "change_password_bloc.dart";

@freezed
class ChangePasswordState with _$ChangePasswordState {
  const factory ChangePasswordState.initial() = _Initial;

  const factory ChangePasswordState.stateChange({
    @PasswordConverter() @Default(Password.pure()) Password oldPassword,
    @PasswordConverter() @Default(Password.pure()) Password newPassword,
    @PasswordConverter()
    @Default(ConfirmedPassword.pure())
    ConfirmedPassword confirmedPassword,
    @Default(false) bool isPasswordChangeFormValidated,
  }) = _StateChanged;

  const ChangePasswordState._();

  bool get passwordResetFormValidated {
    if (this is _StateChanged) {
      return (this as _StateChanged).isPasswordChangeFormValidated;
    }
    return false;
  }

  Password get oldPasswordInputValue {
    if (this is _StateChanged) {
      return (this as _StateChanged).oldPassword;
    }
    return const Password.pure();
  }

  Password get newPasswordInputValue {
    if (this is _StateChanged) {
      return (this as _StateChanged).newPassword;
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
