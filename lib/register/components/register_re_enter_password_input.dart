// Copyright 2023 trinity
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import "package:bank/common/custom_text_field_input.dart";
import "package:bank/form_inputs/email.dart";
import "package:bank/register/bloc/register_bloc.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class RegisterReEnterPsswordInput extends StatelessWidget {
  const RegisterReEnterPsswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<RegisterBloc, RegisterState, Email>(
      selector: (state) {
        return state.email;
      },
      builder: (context, emailField) {
        //TODO(@Trinity6264): #113 Obscure the text input and add a toggle button to show the password
        //TODO(@Trinity6264): #114 This field remain invalid even with the password matches. Fix this
        return CustomTextFieldInput(
          hintText: "Re-enter password",
          errorText: emailField.displayError?.message,
          textInputType: TextInputType.emailAddress,
          onChnaged: (value) {
            context.read<RegisterBloc>().add(
                  RegisterEvent.onEmailChanged(value: value),
                );
          },
        );
      },
    );
  }
}
