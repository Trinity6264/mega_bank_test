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

import "package:animations/animations.dart";
import "package:auto_route/auto_route.dart";
import "package:bank/common/constant.dart";
import "package:bank/common/custom_rounded_button.dart";
import "package:flutter/material.dart";
import "package:package_info_plus/package_info_plus.dart";
import "package:rxdart/rxdart.dart";

class AppVersion extends StatefulWidget {
  const AppVersion({super.key});

  @override
  State<AppVersion> createState() => _AppVersionState();
}

class _AppVersionState extends State<AppVersion> {
  PackageInfo? packageInfo;

  static final _versionSubject = BehaviorSubject<String>.seeded("0.0.1");

  @override
  void initState() {
    super.initState();

    loadAppDetail();
  }

  Future<void> loadAppDetail() async {
    await PackageInfo.fromPlatform().then(
      (value) {
        return _versionSubject.add(value.version);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModal<void>(
          context: context,
          configuration: const FadeScaleTransitionConfiguration(
            transitionDuration: Duration(milliseconds: 500),
            reverseTransitionDuration: Duration(milliseconds: 300),
          ),
          builder: (context) {
            return AlertDialog.adaptive(
              contentPadding: EdgeInsets.all(context.getMediumPaddingSize()),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  context.getMediumRadiusSize(),
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Center(
                    child: Text(
                      "App Version",
                      style: TextStyle(
                        color: Color(0xff212121),
                        fontWeight: FontWeight.w800,
                        fontSize: 24,
                        letterSpacing: 0.175,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: StreamBuilder<String>(
                      stream: _versionSubject.stream,
                      builder: (context, snapshot) {
                        return Text(
                          "Version ${snapshot.data}",
                          style: TextStyle(
                            color: const Color(0xff212121),
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.175,
                            fontSize: context.getNameTextFontSize(),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                  CustomRoundedButton(
                    text: "Okay",
                    onPressed: () {
                      context.popRoute();
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(
          context.getSmallPaddingSize(),
        ),
        child: Align(
          child: Text(
            "App Version",
            style: TextStyle(
              color: const Color(0xff001530),
              fontWeight: FontWeight.w400,
              fontSize: context.getGreetingsTextFontSize(),
              letterSpacing: 0.175,
            ),
          ),
        ),
      ),
    );
  }
}
