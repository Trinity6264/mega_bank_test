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
import "package:bank/common/custom_back_button.dart";
import "package:bank/common/custom_rounded_button.dart";
import "package:bank/common/custom_text_field_input.dart";
import "package:bank/common/utils.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";

@RoutePage()
class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});
  static final utils = getIt.get<Utils>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.primaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: context.primaryColor,
        automaticallyImplyLeading: false,
        title: const CustomBackButton(),
        actions: [
          Padding(
            padding: EdgeInsets.only(
              right: context.getMediumPaddingSize(),
            ),
            child: const Center(
              child: Text(
                "User Profile",
                style: TextStyle(
                  color: Color(0xffF5F5F5),
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.getMediumPaddingSize(),
        ),
        child: CustomScrollView(
          slivers: [
            SliverList.list(
              children: [
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.99,
                  child: Column(
                    children: [
                      const Spacer(),
                      Align(
                        child: Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.skewY(0),
                          child: Stack(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                width: MediaQuery.sizeOf(context).width / 2,
                                height: MediaQuery.sizeOf(context).height / 4,
                                decoration: BoxDecoration(
                                  image: const DecorationImage(
                                    image: AssetImage("assets/Union.png"),
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                  color: const Color(0xffF5F5F5),
                                ),
                              ),
                              Positioned(
                                bottom: 10,
                                left: 30,
                                child: GestureDetector(
                                  onTap: () async {
                                    final resp = await utils
                                        .showImagePickerBottomSheet(context);
                                    logger.i(resp);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 10,
                                    ),
                                    height: 32,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: const Color(0xff333333)
                                          .withOpacity(0.6),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SvgPicture.asset("assets/edit.svg"),
                                        const SizedBox(width: 4),
                                        const Text(
                                          "Change Photo",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                      CustomTextFieldInput(
                        hintText: "",
                        onChnaged: (value) {},
                      ),
                      CustomTextFieldInput(
                        hintText: "",
                        onChnaged: (value) {},
                      ),
                      const Spacer(),
                      CustomRoundedButton(
                        text: "Save",
                        onPressed: () {},
                      ),
                      const Spacer(flex: 5),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
