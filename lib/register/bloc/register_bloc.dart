import "dart:async";

import "package:bank/authentication/repository/authentication_repository.dart";
import "package:bank/form_inputs/email.dart";
import "package:bank/form_inputs/password.dart";
import "package:bank/form_inputs/username.dart";
import "package:bloc/bloc.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:formz/formz.dart";
import "package:freezed_annotation/freezed_annotation.dart";

part "register_bloc.freezed.dart";
part "register_event.dart";
part "register_state.dart";

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc(this.authenticationRepository) : super(const _RegisterState()) {
    on<_UsernameChanged>(_onUsernameChanged);
    on<_EmailChanged>(_onEmailChanged);
    on<_PasswordChanged>(_onPasswordChanged);
    on<_FormSubmitted>(_onFormSubmitted);
    on<_FormReset>(_onFormReset);
  }
  final AuthenticationRepository authenticationRepository;

  FutureOr<void> _onUsernameChanged(
    _UsernameChanged event,
    Emitter<RegisterState> emit,
  ) async {
    final username = Username.dirty(value: event.value);
    emit(
      state.copyWith(
        username: username,
        isRegisterFormValidated: Formz.validate(
          [
            username,
            state.email,
            state.password,
          ],
        ),
      ),
    );
  }

  FutureOr<void> _onEmailChanged(
    _EmailChanged event,
    Emitter<RegisterState> emit,
  ) async {
    final email = Email.dirty(value: event.value);
    emit(
      state.copyWith(
        email: email,
        isRegisterFormValidated: Formz.validate(
          [
            email,
            state.username,
            state.password,
          ],
        ),
      ),
    );
  }

  FutureOr<void> _onPasswordChanged(
    _PasswordChanged event,
    Emitter<RegisterState> emit,
  ) async {
    final password = Password.dirty(value: event.value);
    emit(
      state.copyWith(
        password: password,
        isRegisterFormValidated: Formz.validate(
          [
            password,
            state.username,
            state.email,
          ],
        ),
      ),
    );
  }

  FutureOr<void> _onFormSubmitted(
    _FormSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    final resp = await authenticationRepository.createAccount(
      name: state.username.value,
      email: state.email.value,
      password: state.password.value,
    );
    resp.when(
      (user) => event.onSuccess(user),
      (error) => event.onError(error),
    );
  }

  FutureOr<void> _onFormReset(
    _FormReset event,
    Emitter<RegisterState> emit,
  ) async {
    emit(const _RegisterState());
  }
}
