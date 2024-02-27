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
import "package:bank/common/constant.dart";
import "package:bank/common/custom_back_button.dart";
import "package:bank/common/gradient_container.dart";
import "package:bank/personal_information/components/first_name_input.dart";
import "package:bank/personal_information/components/other_name_input.dart";
import "package:bank/personal_information/components/personal_information_button.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";

@RoutePage()
class PersonalInformationPage extends StatelessWidget {
  const PersonalInformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomBackButton(),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF022E64),
        elevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.getMediumPaddingSize(),
            ),
            child: SvgPicture.asset(
              "assets/logo.svg",
              height: 32,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          const GradientContainer(),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.getMediumPaddingSize(),
            ),
            child: CustomScrollView(
              slivers: [
                SliverList.list(
                  children: [
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height,
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Spacer(),
                          Center(
                            child: Text(
                              "Almost Done",
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
                              "Let us know more about you.",
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
                              "Who doesn't like to be recognized?",
                              style: TextStyle(
                                color: const Color(0xffF5F5F5),
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.175,
                                fontSize: context.getNameTextFontSize(),
                              ),
                            ),
                          ),
                          const Spacer(flex: 2),
                          //TODO(@Trinity6264): #115 Do not allow the user to continue navigation if the First name or Last name is empty
                          const FirstnameInput(),
                          const OthernameInput(),
                          const Spacer(),
                          const PersonalInformationButton(),
                          const Spacer(flex: 6),
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
