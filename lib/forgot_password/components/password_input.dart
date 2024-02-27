import "package:bank/common/custom_text_field_input.dart";
import "package:bank/extension/translation_extentions.dart";
import "package:bank/forgot_password/bloc/forgot_password_bloc.dart";
import "package:bank/form_inputs/password.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class PasswordInput extends StatelessWidget {
  const PasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ForgotPasswordBloc, ForgotPasswordState, Password>(
      selector: (state) {
        return state.passwordInputValue;
      },
      builder: (context, password) {
        return CustomTextFieldInput(
          hintText: "new-password".translateLanguage,
          textInputType: TextInputType.visiblePassword,
          errorText: password.displayError?.message,
          onChnaged: (value) {
            context.read<ForgotPasswordBloc>().add(
                  ForgotPasswordEvent.onPasswordChanged(value: value),
                );
          },
        );
      },
    );
  }
}
