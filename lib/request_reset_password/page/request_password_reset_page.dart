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
import "package:bank/request_reset_password/components/email_input.dart";
import "package:bank/request_reset_password/components/request_password_reset_button.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";

@RoutePage()
class RequestPasswordResetPage extends StatelessWidget {
  const RequestPasswordResetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        leading: Padding(
          padding: EdgeInsets.only(
            left: context.getMediumPaddingSize(),
          ),
          child: const CustomBackButton(),
        ),
        backgroundColor: const Color(0xFF022E64),
        elevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.only(
              right: context.getMediumPaddingSize(),
            ),
            child: SvgPicture.asset(
              "assets/logo.svg",
              width: MediaQuery.sizeOf(context).height / 12,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.0583, 1.0, 1.0],
                colors: [
                  Color(0xFF022E64),
                  Color(0xFF004395),
                  Color(0xFF00408F),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: context.getMediumPaddingSize(),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(flex: 2),
                EmailInput(),
                Spacer(),
                RequestPasswordResetButton(),
                Spacer(flex: 2),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
