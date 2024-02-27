import "package:bank/common/custom_text_field_input.dart";
import "package:bank/extension/translation_extentions.dart";
import "package:bank/forgot_password/bloc/forgot_password_bloc.dart";
import "package:bank/form_inputs/confirmed_password.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class ConfirmedPasswordInput extends StatelessWidget {
  const ConfirmedPasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ForgotPasswordBloc, ForgotPasswordState,
        ConfirmedPassword>(
      selector: (state) {
        return state.confirmedPasswordInputValue;
      },
      builder: (context, confirmPassword) {
        return CustomTextFieldInput(
          hintText: "confirm-new-password".translateLanguage,
          errorText: confirmPassword.displayError?.message,
          onChnaged: (value) {
            context.read<ForgotPasswordBloc>().add(
                  ForgotPasswordEvent.onConfirmedPasswordChanged(value: value),
                );
          },
        );
      },
    );
  }
}
