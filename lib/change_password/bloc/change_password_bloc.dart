import "package:bank/authentication/repository/authentication_repository.dart";
import "package:bank/form_inputs/confirmed_password.dart";
import "package:bank/form_inputs/password.dart";
import "package:bloc/bloc.dart";
import "package:formz/formz.dart";
import "package:freezed_annotation/freezed_annotation.dart";

part "change_password_bloc.freezed.dart";
part "change_password_event.dart";
part "change_password_state.dart";

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  ChangePasswordBloc({required this.authenticationRepository})
      : super(const _Initial()) {
    on<_OldPasswordChanged>(_onOldPasswordChanged);
    on<_NewPasswordChanged>(_onNewPasswordChanged);
    on<_ConfirmedPasswordChanged>(_onConfirmedPasswordChanged);
    on<_CredentialsSubmitted>(_onFormSubmit);
    on<_OnStateReset>(_onStateChange);
  }

  final AuthenticationRepository authenticationRepository;

  Future<void> _onOldPasswordChanged(
    _OldPasswordChanged event,
    Emitter<ChangePasswordState> emit,
  ) async {
    final password = Password.dirty(value: event.value);
    emit(
      _StateChanged(
        oldPassword: password,
        confirmedPassword: state.confirmedPasswordInputValue,
        newPassword: state.newPasswordInputValue,
        isPasswordChangeFormValidated: Formz.validate(
          [
            password,
            state.confirmedPasswordInputValue,
            state.newPasswordInputValue,
          ],
        ),
      ),
    );
  }

  Future<void> _onNewPasswordChanged(
    _NewPasswordChanged event,
    Emitter<ChangePasswordState> emit,
  ) async {
    final newPassword = Password.dirty(value: event.value);
    emit(
      _StateChanged(
        newPassword: newPassword,
        confirmedPassword: state.confirmedPasswordInputValue,
        oldPassword: state.oldPasswordInputValue,
        isPasswordChangeFormValidated: Formz.validate(
          [
            newPassword,
            state.confirmedPasswordInputValue,
            state.oldPasswordInputValue,
          ],
        ),
      ),
    );
  }

  Future<void> _onConfirmedPasswordChanged(
    _ConfirmedPasswordChanged event,
    Emitter<ChangePasswordState> emit,
  ) async {
    final confirmPassword = ConfirmedPassword.dirty(
      value: event.value,
      originalPassword: state.newPasswordInputValue.value,
    );
    emit(
      _StateChanged(
        confirmedPassword: confirmPassword,
        newPassword: state.newPasswordInputValue,
        oldPassword: state.oldPasswordInputValue,
        isPasswordChangeFormValidated: Formz.validate(
          [
            confirmPassword,
            state.oldPasswordInputValue,
            state.newPasswordInputValue,
          ],
        ),
      ),
    );
  }

  Future<void> _onFormSubmit(
    _CredentialsSubmitted event,
    Emitter<ChangePasswordState> emit,
  ) async {
    try {
      // final resp = await authenticationRepository.changePassword();
      // resp.when(
      //   (success) => event.onSuccess(),
      //   (error) => event.onError("Failed to Change Password"),
      // );
    } catch (e) {
      event.onError("Failed to Change Password");
    }
  }

  Future<void> _onStateChange(
    _OnStateReset event,
    Emitter<ChangePasswordState> emit,
  ) async {
    emit(const _Initial());
  }
}
