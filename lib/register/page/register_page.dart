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
import "package:bank/common/constant.dart";
import "package:bank/common/gradient_container.dart";
import "package:bank/register/bloc/register_bloc.dart";
import "package:bank/register/components/register_button.dart";
import "package:bank/register/components/register_email_input.dart";
import "package:bank/register/components/register_password_input.dart";
import "package:bank/register/components/register_re_enter_password_input.dart";
import "package:bank/service/form_validation.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:flutter_svg/flutter_svg.dart";

@RoutePage()
class RegisterPage extends HookWidget {
  const RegisterPage({
    this.onResults,
    super.key,
  });
  final void Function({bool? validationResut})? onResults;

  @override
  Widget build(BuildContext context) {
    final isRegisterFormValidated = context.select<RegisterBloc, bool>(
      (RegisterBloc bloc) => bloc.state.isRegisterFormValidated,
    );
    final formValidation = getIt.get<FormValidation>();
    useEffect(
      () {
        return () {
          logger.i("Oyek3");
          formValidation.updateSignUpForm(isRegisterFormValidated);
        };
      },
      [isRegisterFormValidated],
    );

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: SvgPicture.asset(
          "assets/logo.svg",
          height: 32,
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF022E64),
        elevation: 0,
      ),
      body: Stack(
        children: [
          const GradientContainer(),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.getMediumPaddingSize(),
            ),
            //TODO(@Trinity6264): #110 The whole page should scroll. Not just the content under the appbar. Use a SliverAppbar for this purpose
            child: CustomScrollView(
              slivers: [
                SliverList.list(
                  children: [
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.9,
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Spacer(),
                          Center(
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                color: const Color(0xffF5F5F5),
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.175,
                                fontSize: context.getHeaderFontSize(),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Center(
                            child: Text(
                              "New to FBN Mobile App?",
                              style: TextStyle(
                                color: const Color(0xffF5F5F5),
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.175,
                                fontSize: context.getNameTextFontSize(),
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              "Sign up and let's get started",
                              style: TextStyle(
                                color: const Color(0xffF5F5F5),
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.175,
                                fontSize: context.getNameTextFontSize(),
                              ),
                            ),
                          ),
                          const Spacer(),
                          const RegisterEmailInput(),
                          const RegisterPasswordInput(),
                          const Hero(
                            tag: "play",
                            child: RegisterReEnterPsswordInput(),
                          ),
                          const Spacer(),
                          const RegisterButton(),
                          const Spacer(flex: 2),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already have an account?",
                                style: TextStyle(
                                  color: const Color(0xffF5F5F5),
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.175,
                                  fontSize: context.getNameTextFontSize(),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  context.popRoute();
                                },
                                child: Text(
                                  "Sign In",
                                  style: TextStyle(
                                    color: context.secondaryColor,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.175,
                                    fontSize: context.getNameTextFontSize(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
