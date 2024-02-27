part of "forgot_password_bloc.dart";

@freezed
class ForgotPasswordEvent with _$ForgotPasswordEvent {
  const factory ForgotPasswordEvent.onPasswordChanged({
    required String value,
  }) = _PasswordChanged;

  const factory ForgotPasswordEvent.onConfirmedPasswordChanged({
    required String value,
  }) = _ConfirmedPasswordChanged;

  const factory ForgotPasswordEvent.onCredentialsSubmit({
    required void Function() onSuccess,
    required void Function(String message) onError,
  }) = _CredentialsSubmitted;
}
