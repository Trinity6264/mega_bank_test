import "dart:async";

import "package:bank/authentication/repository/authentication_repository.dart";
import "package:bank/form_inputs/email.dart";
import "package:bank/form_inputs/password.dart";
import "package:bloc/bloc.dart";
import "package:bloc_concurrency/bloc_concurrency.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:formz/formz.dart";
import "package:freezed_annotation/freezed_annotation.dart";

part "login_bloc.freezed.dart";
part "login_event.dart";
part "login_state.dart";

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required this.authenticationRepository})
      : super(const _Initial()) {
    on<_EmailChanged>(_onEmailChanged, transformer: restartable());
    on<_PasswordChanged>(_onPasswordChanged, transformer: restartable());
    on<_CredentialsSubmitted>(_onFormSubmit, transformer: droppable());
  }
  final AuthenticationRepository authenticationRepository;

  FutureOr<void> _onEmailChanged(
    _EmailChanged event,
    Emitter<LoginState> emit,
  ) async {
    final email = Email.dirty(value: event.value);
    emit(
      _StateChanged(
        email: email,
        isLoginFormValidated: Formz.validate([email, state.passwordInputValue]),
        password: state.passwordInputValue,
      ),
    );
  }

  FutureOr<void> _onPasswordChanged(
    _PasswordChanged event,
    Emitter<LoginState> emit,
  ) async {
    final password = Password.dirty(value: event.value);
    emit(
      _StateChanged(
        password: password,
        email: state.emailInputValue,
        isLoginFormValidated: Formz.validate([password, state.emailInputValue]),
      ),
    );
  }

  FutureOr<void> _onFormSubmit(
    _CredentialsSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    final resp = await authenticationRepository.login(
      email: state.emailInputValue.value,
      password: state.passwordInputValue.value,
    );
    resp.when(
      (user) => event.onSuccess(user),
      (error) => event.onError(error),
    );
  }
}
