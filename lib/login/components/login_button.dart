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
import "package:bank/local_user/local_user.dart";
import "package:bank/login/bloc/login_bloc.dart";
import "package:bank/routes/bank_auto_router.gr.dart";
import "package:firebase_analytics/firebase_analytics.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_hooks/flutter_hooks.dart";

class LoginButton extends HookWidget {
  const LoginButton({super.key});
  static final localUser = getIt.get<LocalUser>();

  @override
  Widget build(BuildContext context) {
    //TODO(@Trinity6264): #105 Use the bloc states to handle the button state
    final isBusy = useState<bool>(false);
    final isLoginFormValidated = context.select<LoginBloc, bool>(
      (LoginBloc bloc) => bloc.state.isLoginFormValidated,
    );

    return isBusy.value
        ? const Center(
            child: CircularProgressIndicator.adaptive(
              backgroundColor: Color.fromARGB(255, 209, 158, 5),
            ),
          )
        : CustomRoundedButton(
            text: "Sign In",
            onPressed: () {
              if (!isLoginFormValidated) {
                //TODO(@Trinity6264): #98 Refactor this from an alert dialog to a toast as shown in the design
                getIt.get<Utils>().showAlertDialog(
                      context: context,
                      title: "Alert",
                      info: "Form is not valid",
                    );
                return;
              }
              isBusy.value = true;
              context.read<LoginBloc>().add(
                    LoginEvent.onCredentialsSubmit(
                      onSuccess: (user) async {
                        localUser.setLocalUser(
                          username: user.displayName ?? "",
                          email: user.email ?? "",
                          uid: user.uid,
                        );
                        //TODO(@Trinity6264): #99 Handle the repositoy logic in a repository and use the bloc events to handle events
                        await FirebaseAnalytics.instance.logLogin(
                          loginMethod:
                              "Login Method by ${context.read<LoginBloc>().state.emailInputValue.value}}",
                        );
                        isBusy.value = false;
                        if (context.mounted) {
                          await context.replaceRoute(const LoadingPage());
                        }
                      },
                      onError: (message) {
                        getIt.get<Utils>().showAlertDialog(
                              context: context,
                              title: "Alert",
                              //TODO(@Trinity6264): #104 Handle the error message and do not just display it. Handle it and write custom message to the user based on the error
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
