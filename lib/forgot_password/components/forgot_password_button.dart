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

import "package:bank/app/service_locator.dart";
import "package:bank/common/custom_rounded_button.dart";
import "package:bank/common/utils.dart";
import "package:bank/extension/translation_extentions.dart";
import "package:bank/forgot_password/bloc/forgot_password_bloc.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_hooks/flutter_hooks.dart";

class ForgotPasswordButton extends HookWidget {
  const ForgotPasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isBusy = useState<bool>(false);
    final isLoginFormValidated = context.select(
      (ForgotPasswordBloc bloc) => bloc.state.forgotPasswordFormValidated,
    );

    return isBusy.value
        ? const Center(
            child: CircularProgressIndicator.adaptive(
              backgroundColor: Color.fromARGB(255, 209, 158, 5),
            ),
          )
        : CustomRoundedButton(
            text: "reset-password".translateLanguage,
            onPressed: () {
              if (!isLoginFormValidated) {
                getIt.get<Utils>().showAlertDialog(
                      context: context,
                      title: "Alert",
                      info: "Form is not valid",
                    );
                return;
              }
              isBusy.value = true;
              context.read<ForgotPasswordBloc>().add(
                    ForgotPasswordEvent.onCredentialsSubmit(
                      onSuccess: () {
                        isBusy.value = false;
                        getIt.get<Utils>().showAlertDialog(
                              context: context,
                              title: "Success",
                              info: "Password reset successfully done ",
                              icon: Icons.check_circle_outline_outlined,
                              iconColor: Colors.green,
                            );
                      },
                      onError: (message) {
                        getIt.get<Utils>().showAlertDialog(
                              context: context,
                              title: "Alert",
                              info: message,
                            );

                        isBusy.value = false;
                      },
                    ),
                  );
            },
          );
  }
}
