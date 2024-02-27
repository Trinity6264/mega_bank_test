import "dart:async";

import "package:bank/authentication/repository/authentication_repository.dart";
import "package:bank/form_inputs/confirmed_password.dart";
import "package:bank/form_inputs/password.dart";
import "package:bloc/bloc.dart";
import "package:bloc_concurrency/bloc_concurrency.dart";
import "package:formz/formz.dart";
import "package:freezed_annotation/freezed_annotation.dart";

part "forgot_password_bloc.freezed.dart";
part "forgot_password_event.dart";
part "forgot_password_state.dart";

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc({
    required this.authenticationRepository,
  }) : super(const _Initial()) {
    on<_PasswordChanged>(_onPasswordChanged, transformer: restartable());
    on<_ConfirmedPasswordChanged>(
      _onConfirmedPasswordChanged,
      transformer: restartable(),
    );
    on<_CredentialsSubmitted>(_onFormSubmit, transformer: droppable());
  }

  final AuthenticationRepository authenticationRepository;

  FutureOr<void> _onPasswordChanged(
    _PasswordChanged event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    final password = Password.dirty(value: event.value);
    emit(
      _StateChanged(
        password: password,
        isForgotPasswordFormValid: Formz.validate(
          [
            password,
            state.confirmedPasswordInputValue,
          ],
        ),
      ),
    );
  }

  FutureOr<void> _onConfirmedPasswordChanged(
    _ConfirmedPasswordChanged event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    final confirmPassword = ConfirmedPassword.dirty(
      value: event.value,
      originalPassword: state.passwordInputValue.value,
    );
    emit(
      _StateChanged(
        confirmedPassword: confirmPassword,
        password: state.passwordInputValue,
        isForgotPasswordFormValid: Formz.validate(
          [
            confirmPassword,
            state.passwordInputValue,
          ],
        ),
      ),
    );
  }

  FutureOr<void> _onFormSubmit(
    _CredentialsSubmitted event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    try {
      // final resp = await authenticationRepository.forgotPassword();
      // resp.when(
      //   (success) => event.onSuccess(),
      //   (error) => event.onError("Failed to reset Password"),
      // );
    } catch (e) {
      event.onError("Failed to reset Password");
    }
  }
}
