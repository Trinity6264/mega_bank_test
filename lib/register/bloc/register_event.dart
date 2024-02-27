part of "register_bloc.dart";

@freezed
class RegisterEvent with _$RegisterEvent {
  const factory RegisterEvent.onUsernameChanged({
    required String value,
  }) = _UsernameChanged;

  const factory RegisterEvent.onEmailChanged({
    required String value,
  }) = _EmailChanged;

  const factory RegisterEvent.onPasswordChanged({
    required String value,
  }) = _PasswordChanged;

  const factory RegisterEvent.onFormSubmitted({
    required void Function(User user) onSuccess,
    required void Function(String message) onError,
  }) = _FormSubmitted;

  const factory RegisterEvent.onFormReset() = _FormReset;
}
