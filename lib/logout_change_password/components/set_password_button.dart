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

import "package:bank/common/custom_rounded_button.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";

class SetPasswordButton extends HookWidget {
  const SetPasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isBusy = useState<bool>(false);
    // final isLoginFormValidated = context.select(
    //   (ChangePasswordBloc bloc) => bloc.state.passwordResetFormValidated,
    // );

    return isBusy.value
        ? const Center(
            child: CircularProgressIndicator.adaptive(
              backgroundColor: Color.fromARGB(255, 209, 158, 5),
            ),
          )
        : Padding(
            padding: const EdgeInsets.only(top: 10),
            child: CustomRoundedButton(
              text: "Set Password",
              onPressed: () {},
            ),
          );
  }
}
