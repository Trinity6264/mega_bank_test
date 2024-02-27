part of "register_bloc.dart";

@freezed
class RegisterState with _$RegisterState {
  const factory RegisterState({
    @UsernameConverter() @Default(Username.pure()) Username username,
    @EmailConverter() @Default(Email.pure()) Email email,
    @PasswordConverter() @Default(Password.pure()) Password password,
    @Default(false) bool isRegisterFormValidated,
  }) = _RegisterState;
}
