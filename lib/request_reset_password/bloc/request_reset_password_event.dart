part of "request_reset_password_bloc.dart";

@freezed
class RequestResetPasswordEvent with _$RequestResetPasswordEvent {
  const factory RequestResetPasswordEvent.onEmailChanged({
    required String value,
  }) = _EmailChanged;
  const factory RequestResetPasswordEvent.onFormSubmitted({
    required void Function() onSuccess,
    required void Function(String message) onError,
  }) = _FormSubmitted;
}
