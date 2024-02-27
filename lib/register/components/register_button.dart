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
import "package:bank/bank_observer.dart";
import "package:bank/common/custom_rounded_button.dart";
import "package:bank/local_user/local_user.dart";
import "package:bank/routes/bank_auto_router.gr.dart";
import "package:bank/service/form_validation.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";

class RegisterButton extends HookWidget {
  const RegisterButton({super.key});
  static final localUser = getIt.get<LocalUser>();

  @override
  Widget build(BuildContext context) {
    final isBusy = useState<bool>(false);
    // final isRegisterFormValidated = context.select<RegisterBloc, bool>(
    //   (RegisterBloc bloc) => bloc.state.isRegisterFormValidated,
    // );

    return isBusy.value
        ? const Center(
            child: CircularProgressIndicator.adaptive(
              backgroundColor: Color.fromARGB(255, 209, 158, 5),
            ),
          )
        : CustomRoundedButton(
            text: "Register",
            onPressed: () {
              logger.i(getIt.get<FormValidation>().signUpFormState);
              context.pushRoute(VerifyPage());

              // if (!isRegisterFormValidated) {
              //   getIt.get<Utils>().showAlertDialog(
              //         context: context,
              //         title: "Alert",
              //         info: "Form is not valid",
              //       );
              //   return;
              // }
              // isBusy.value = true;
              // context.read<RegisterBloc>().add(
              //       RegisterEvent.onFormSubmitted(
              //         onSuccess: (user) async {
              //           localUser.setLocalUser(
              //             username: user.displayName ?? "",
              //             email: user.email ?? "",
              //             uid: user.uid,
              //           );
              //           await FirebaseAnalytics.instance.logEvent(
              //             name: "Registered user",
              //             parameters: {
              //               "email":
              //                   context.read<RegisterBloc>().state.email.value,
              //               "username": context
              //                   .read<RegisterBloc>()
              //                   .state
              //                   .username
              //                   .value,
              //             },
              //           );
              //           isBusy.value = false;
              //           if (context.mounted) {
              //             await context.pushRoute(const LoadingPage());
              //           }
              //         },
              //         onError: (message) {
              //           getIt.get<Utils>().showAlertDialog(
              //                 context: context,
              //                 title: "Alert",
              //                 info: message,
              //               );

              //           isBusy.value = false;
              //         },
              //       ),
              //     );
            },
          );
  }
}
