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
import "package:bank/routes/bank_auto_router.gr.dart";
import "package:bank/service/form_validation.dart";

class AuthGuard extends AutoRouteGuard {
  const AuthGuard();

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final forms = getIt.get<FormValidation>();
    final isVerifyFormValid = forms.verifyFormState;
    // final isLoginFormValid = forms.signUpFormState;
    final isRegisterFormValid = forms.signUpFormState;
    final pageName =
        router.stack.length > 1 ? router.stack[1].name : router.stack[0].name;
    if (pageName == "RegisterPage") {
      if (!isRegisterFormValid) {
        resolver.redirect(
          RegisterPage(
            onResults: ({validationResut}) {
              if (validationResut ?? false) {
                onNavigation(resolver, router);
              } else {
                resolver.next(false);
              }
            },
          ),
        );
      }
      if (!isVerifyFormValid) {
        resolver.redirect(
          VerifyPage(
            onResults: ({validationResult}) {
              if (validationResult ?? false) {
                onNavigation(resolver, router);
              } else {
                resolver.next(false);
              }
            },
          ),
        );
      }
    } else {
      resolver.next();
    }
  }
}
