import "package:bank/change_password/bloc/change_password_bloc.dart";
import "package:bank/common/custom_text_field_input.dart";
import "package:bank/extension/translation_extentions.dart";
import "package:bank/form_inputs/password.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class NewPasswordInput extends StatelessWidget {
  const NewPasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ChangePasswordBloc, ChangePasswordState, Password>(
      selector: (state) {
        return state.newPasswordInputValue;
      },
      builder: (context, newPassword) {
        return CustomTextFieldInput(
          errorText: newPassword.displayError?.message,
          textInputType: TextInputType.visiblePassword,
          hintText: "new-password".translateLanguage,
          onChnaged: (value) {
            context.read<ChangePasswordBloc>().add(
                  ChangePasswordEvent.onNewPasswordChanged(value: value),
                );
          },
        );
      },
    );
  }
}
