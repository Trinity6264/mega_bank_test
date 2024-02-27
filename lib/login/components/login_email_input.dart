import "package:bank/common/custom_text_field_input.dart";
import "package:bank/form_inputs/email.dart";
import "package:bank/login/bloc/login_bloc.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class LoginEmailInput extends StatelessWidget {
  const LoginEmailInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<LoginBloc, LoginState, Email>(
      selector: (state) {
        return state.emailInputValue;
      },
      builder: (context, emailField) {
        return CustomTextFieldInput(
          hintText: "Enter email or phone number",
          errorText: emailField.displayError?.message,
          textInputType: TextInputType.emailAddress,
          onChnaged: (value) {
            context.read<LoginBloc>().add(
                  LoginEvent.onEmailChanged(value: value),
                );
          },
        );
      },
    );
  }
}
