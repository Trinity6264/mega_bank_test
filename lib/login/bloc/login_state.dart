part of "login_bloc.dart";

@freezed
class LoginState with _$LoginState {
  const factory LoginState.initial() = _Initial;
  const factory LoginState.stateChanged({
    @EmailConverter() @Default(Email.pure()) Email email,
    @PasswordConverter() @Default(Password.pure()) Password password,
    @Default(false) bool isLoginFormValidated,
  }) = _StateChanged;

  const LoginState._();

  bool get isLoginFormValidated {
    if (this is _StateChanged) {
      return (this as _StateChanged).isLoginFormValidated;
    }
    return false;
  }

  Email get emailInputValue {
    if (this is _StateChanged) {
      return (this as _StateChanged).email;
    }
    return const Email.pure();
  }

  Password get passwordInputValue {
    if (this is _StateChanged) {
      return (this as _StateChanged).password;
    }
    return const Password.pure();
  }
}
