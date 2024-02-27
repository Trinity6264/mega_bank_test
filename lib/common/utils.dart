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

import "dart:ui";

import "package:animations/animations.dart";
import "package:auto_route/auto_route.dart";
import "package:bank/common/constant.dart";
import "package:bank/common/custom_rounded_button.dart";
import "package:flutter/material.dart";
import "package:image_picker/image_picker.dart";

class Utils {
  // Information dialog

  Future<void> showAlertDialog({
    required BuildContext context,
    required String title,
    required String info,
    IconData icon = Icons.warning_rounded,
    Color iconColor = Colors.red,
  }) async {
    await showModal<void>(
      configuration: const FadeScaleTransitionConfiguration(
        transitionDuration: Duration(milliseconds: 500),
        barrierColor: Colors.black26,
        reverseTransitionDuration: Duration(milliseconds: 300),
      ),
      filter: ImageFilter.blur(
        sigmaX: 8,
        sigmaY: 8,
        tileMode: TileMode.repeated,
      ),
      context: context,
      builder: (context) {
        return AlertDialog.adaptive(
          title: Row(
            children: [
              Icon(icon, color: iconColor),
              const SizedBox(width: 5),
              Text(title),
            ],
          ),
          content: Text(info),
          actions: [
            TextButton(
              onPressed: () {
                context.popRoute();
              },
              child: const Text("Ok"),
            ),
          ],
        );
      },
    );
  }

  void showNoInternetBanner({
    required BuildContext context,
  }) {
    ScaffoldMessenger.of(context)
      ..clearMaterialBanners()
      ..showMaterialBanner(
        const MaterialBanner(
          backgroundColor: Color.fromARGB(255, 170, 24, 24),
          elevation: 0,
          content: Text(
            "No internet detected on this phone",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [
            Icon(
              Icons.wifi_off_rounded,
              color: Colors.white,
            ),
          ],
        ),
      );
  }

  void showSnackbar({
    required BuildContext context,
    required String data,
    Color color = Colors.white,
    Color bgColor = Colors.black,
  }) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          backgroundColor: bgColor,
          content: Text(
            data,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
  }

  void clearNoInternetBanner({
    required BuildContext context,
  }) {
    ScaffoldMessenger.of(context).clearMaterialBanners();
  }

  Future<ImageSource?> showImagePickerBottomSheet(BuildContext context) async {
    return showModalBottomSheet<ImageSource?>(
      context: context,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(26),
        ),
      ),
      builder: (context) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
          ),
          height: MediaQuery.sizeOf(context).height / 3.5,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(26),
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Select Upload Method",
                    style: TextStyle(
                      color: const Color(0xff001530),
                      fontWeight: FontWeight.w600,
                      fontSize: context.getBodyFontSize(),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      context.popRoute(null);
                    },
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        color: const Color(0xff001530),
                        fontWeight: FontWeight.w400,
                        fontSize: context.getBodyFontSize(),
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(flex: 2),
              CustomRoundedButton(
                text: "Camera",
                icon: "assets/camera_outlined.svg",
                bgColor: const Color(0xffffffff),
                textColor: context.secondaryColor,
                onPressed: () {
                  context.popRoute(ImageSource.camera);
                },
              ),
              const SizedBox(height: 10),
              CustomRoundedButton(
                text: "Gallery",
                textColor: context.secondaryColor,
                icon: "assets/gallery_outlined.svg",
                bgColor: const Color(0xffffffff),
                onPressed: () {
                  context.popRoute(ImageSource.gallery);
                },
              ),
              const Spacer(),
            ],
          ),
        );
      },
    );
  }
}
