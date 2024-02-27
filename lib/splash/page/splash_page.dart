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
import "package:bank/common/gradient_container.dart";
import "package:bank/routes/bank_auto_router.gr.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:flutter_svg/svg.dart";

@RoutePage()
class SplashPage extends HookWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    useEffect(
      () {
        Future<void>.delayed(
          const Duration(seconds: 3),
          () {
            context.replaceRoute(LoginPage());
          },
        );
        return () {};
      },
      [],
    );

    return Scaffold(
      backgroundColor: const Color(0xff022E64),
      body: Stack(
        children: [
          const GradientContainer(),
          Center(
            child: SvgPicture.asset(
              "assets/logo.svg",
            ),
          ),
        ],
      ),
    );
  }
}
