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

import "package:auto_route/auto_route.dart";
import "package:bank/app/service_locator.dart";
import "package:bank/common/custom_rounded_button.dart";
import "package:bank/common/utils.dart";
import "package:bank/request_reset_password/bloc/request_reset_password_bloc.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_hooks/flutter_hooks.dart";

class RequestPasswordResetButton extends HookWidget {
  const RequestPasswordResetButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isBusy = useState<bool>(false);
    final isRquestResetPasswordFormValidated = context.select(
      (RequestResetPasswordBloc bloc) =>
          bloc.state.isRquestResetPasswordFormValidated,
    );

    return isBusy.value
        ? const Center(
            child: CircularProgressIndicator.adaptive(
              backgroundColor: Color.fromARGB(255, 209, 158, 5),
            ),
          )
        : Padding(
            padding: const EdgeInsets.only(top: 10),
            child: CustomRoundedButton(
              text: "Request Code",
              onPressed: () {
                if (!isRquestResetPasswordFormValidated) {
                  getIt.get<Utils>().showAlertDialog(
                        context: context,
                        title: "Alert",
                        info: "Form is not valid",
                      );
                  return;
                }
                isBusy.value = true;
                context.read<RequestResetPasswordBloc>().add(
                      RequestResetPasswordEvent.onFormSubmitted(
                        onSuccess: () async {
                          isBusy.value = false;
                          await getIt.get<Utils>().showAlertDialog(
                                context: context,
                                title: "Success",
                                info:
                                    "An otp code has been sent to ${context.read<RequestResetPasswordBloc>().state.email.value}",
                                icon: Icons.check_circle_outline_outlined,
                                iconColor: Colors.green,
                              );
                          if (context.mounted) {
                            await context.popRoute();
                          }
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
            ),
          );
  }
}
