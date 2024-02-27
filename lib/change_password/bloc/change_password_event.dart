part of "change_password_bloc.dart";

@freezed
class ChangePasswordEvent with _$ChangePasswordEvent {
  const factory ChangePasswordEvent.onOldPasswordChanged({
    required String value,
  }) = _OldPasswordChanged;

  const factory ChangePasswordEvent.onNewPasswordChanged({
    required String value,
  }) = _NewPasswordChanged;

  const factory ChangePasswordEvent.onConfirmedPasswordChanged({
    required String value,
  }) = _ConfirmedPasswordChanged;

  const factory ChangePasswordEvent.onCredentialsSubmit({
    required void Function() onSuccess,
    required void Function(String message) onError,
  }) = _CredentialsSubmitted;

  const factory ChangePasswordEvent.onStateReset() = _OnStateReset;
}
