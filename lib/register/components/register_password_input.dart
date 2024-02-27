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
import "package:bank/extension/translation_extentions.dart";
import "package:bank/form_inputs/password.dart";
import "package:bank/register/bloc/register_bloc.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class RegisterPasswordInput extends StatelessWidget {
  const RegisterPasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<RegisterBloc, RegisterState, Password>(
      selector: (state) {
        return state.password;
      },
      builder: (context, password) {
        //TODO(@Trinity6264): #112 Obscure the text input and add a toggle button to show the password
        return CustomTextFieldInput(
          hintText: "password".translateLanguage,
          errorText: password.displayError?.message,
          textInputType: TextInputType.visiblePassword,
          onChnaged: (value) {
            context.read<RegisterBloc>().add(
                  RegisterEvent.onPasswordChanged(value: value),
                );
          },
        );
      },
    );
  }
}
