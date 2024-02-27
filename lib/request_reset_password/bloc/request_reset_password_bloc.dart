import "dart:async";

import "package:bank/authentication/repository/authentication_repository.dart";
import "package:bank/form_inputs/email.dart";
import "package:bloc/bloc.dart";
import "package:formz/formz.dart";
import "package:freezed_annotation/freezed_annotation.dart";

part "request_reset_password_bloc.freezed.dart";
part "request_reset_password_event.dart";
part "request_reset_password_state.dart";

class RequestResetPasswordBloc
    extends Bloc<RequestResetPasswordEvent, RequestResetPasswordState> {
  RequestResetPasswordBloc(this.authenticationRepository)
      : super(const _RequestResetPasswordState()) {
    on<_EmailChanged>(_onEmailChanged);
    on<_FormSubmitted>(_onFormSubmitted);
  }
  final AuthenticationRepository authenticationRepository;

  FutureOr<void> _onEmailChanged(
    _EmailChanged event,
    Emitter<RequestResetPasswordState> emit,
  ) async {
    final email = Email.dirty(value: event.value);
    emit(
      state.copyWith(
        email: email,
        isRquestResetPasswordFormValidated: Formz.validate([email]),
      ),
    );
  }

  FutureOr<void> _onFormSubmitted(
    _FormSubmitted event,
    Emitter<RequestResetPasswordState> emit,
  ) async {
    final resp = await authenticationRepository.forgotPassword(
      email: state.email.value,
    );
    resp.when(
      (success) => event.onSuccess(),
      (error) => event.onError(error),
    );
  }
}
