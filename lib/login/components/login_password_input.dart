import "package:bank/common/custom_text_field_input.dart";
import "package:bank/form_inputs/password.dart";
import "package:bank/login/bloc/login_bloc.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:flutter_svg/svg.dart";

class LoginPasswordInput extends HookWidget {
  const LoginPasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    final isSeen = useState<bool>(true);

    return BlocSelector<LoginBloc, LoginState, Password>(
      selector: (state) {
        return state.passwordInputValue;
      },
      builder: (context, passwordField) {
        return CustomTextFieldInput(
          hintText: "Enter Password",
          isObsecured: isSeen.value,
          suffixIcon: IconButton(
            onPressed: () {
              isSeen.value = !isSeen.value;
            },
            icon: isSeen.value
                ? SvgPicture.asset("assets/eye-slash.svg")
                : SvgPicture.asset("assets/visible_icon.svg"),
          ),
          textInputAction: TextInputAction.done,
          //TODO(@Trinity6264): #103 The error messages get trucated and does not display the whole message. Fix this
          errorText: passwordField.displayError?.message,
          textInputType: TextInputType.visiblePassword,
          onChnaged: (value) {
            context.read<LoginBloc>().add(
                  LoginEvent.onPasswordChanged(value: value),
                );
          },
        );
      },
    );
  }
}
