part of "login_bloc.dart";

@freezed
class LoginEvent with _$LoginEvent {
  const factory LoginEvent.onEmailChanged({
    required String value,
  }) = _EmailChanged;
  const factory LoginEvent.onPasswordChanged({
    required String value,
  }) = _PasswordChanged;
  const factory LoginEvent.onCredentialsSubmit({
    required void Function(User user) onSuccess,
    required void Function(String message) onError,
  }) = _CredentialsSubmitted;
}
