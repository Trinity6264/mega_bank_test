import "package:bank/change_password/bloc/change_password_bloc.dart";
import "package:bank/common/custom_text_field_input.dart";
import "package:bank/extension/translation_extentions.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class ConfirmNewPasswordInput extends StatelessWidget {
  const ConfirmNewPasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
      buildWhen: (previous, current) {
        return previous.newPasswordInputValue !=
                current.newPasswordInputValue ||
            previous.confirmedPasswordInputValue !=
                current.confirmedPasswordInputValue;
      },
      builder: (context, value) {
        return CustomTextFieldInput(
          errorText: value.newPasswordInputValue.displayError?.message ??
              value.confirmedPasswordInputValue.displayError?.message,
          textInputType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.done,
          hintText: "confirm-new-password".translateLanguage,
          onChnaged: (value) {
            context.read<ChangePasswordBloc>().add(
                  ChangePasswordEvent.onConfirmedPasswordChanged(value: value),
                );
          },
        );
      },
    );
  }
}
