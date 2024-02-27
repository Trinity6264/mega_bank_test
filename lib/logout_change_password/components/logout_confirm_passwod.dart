import "package:bank/change_password/bloc/change_password_bloc.dart";
import "package:bank/common/custom_text_field_input.dart";
import "package:bank/form_inputs/password.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class LogoutConfirmPasswordInput extends StatelessWidget {
  const LogoutConfirmPasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ChangePasswordBloc, ChangePasswordState, Password>(
      selector: (state) {
        return state.oldPasswordInputValue;
      },
      builder: (context, oldPassword) {
        return CustomTextFieldInput(
          errorText: oldPassword.displayError?.message,
          textInputType: TextInputType.visiblePassword,
          hintText: "Re-enter new password",
          onChnaged: (value) {
            context.read<ChangePasswordBloc>().add(
                  ChangePasswordEvent.onOldPasswordChanged(value: value),
                );
          },
        );
      },
    );
  }
}
