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
import "package:bank/app/service_locator.dart";
import "package:bank/bank_observer.dart";
import "package:bank/common/constant.dart";
import "package:bank/common/custom_back_button.dart";
import "package:bank/common/custom_rounded_button.dart";
import "package:bank/common/utils.dart";
import "package:bank/image/bloc/image_bloc.dart";
import "package:bank/local_user/local_user.dart";
import "package:bank/profile_picture/bloc/profile_picture_bloc.dart";
import "package:bank/profile_picture/components/picture_loading.dart";
import "package:bank/profile_picture/components/picture_placeholder.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_svg/svg.dart";

@RoutePage()
class ProfilePicturePage extends StatelessWidget {
  const ProfilePicturePage({super.key});

  static final localUser = getIt.get<LocalUser>();
  static final utils = getIt.get<Utils>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(
        backgroundColor: context.primaryColor,
        leadingWidth: 100,
        leading: Padding(
          padding: EdgeInsets.only(
            left: context.getMediumPaddingSize(),
          ),
          child: const CustomBackButton(),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(
              right: context.getMediumPaddingSize(),
            ),
            child: SvgPicture.asset(
              "assets/logo.svg",
              width: MediaQuery.sizeOf(context).height / 10,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.getMediumPaddingSize(),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 2),
            Hero(
              tag: "profile-placeholder",
              child: BlocBuilder<ProfilePictureBloc, ProfilePictureState>(
                builder: (context, state) {
                  return state.when(
                    failed: () {
                      return const PicturePlaceholder();
                    },
                    initial: () {
                      return const PicturePlaceholder();
                    },
                    loading: (progress) {
                      return PictureLoading(progress: progress);
                    },
                  );
                },
              ),
            ),
            const Spacer(),
            CustomRoundedButton(
              text: "Changed Picture",
              onPressed: () async {
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
                    return SimpleDialog(
                      children: ["Gallery", "Camera"]
                          .map(
                            (element) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                onTap: () {
                                  // context.popRoute();
                                  if (element == "Gallery") {
                                    context.read<ImageBloc>().add(
                                          ImageEvent.galleryRequested(
                                            onError: (message) {},
                                            onSucceed: (filePath, filename) {
                                              context
                                                  .read<ProfilePictureBloc>()
                                                  .add(
                                                    ProfilePictureEvent
                                                        .imageUploaded(
                                                      onError: (message) {
                                                        utils.showSnackbar(
                                                          context: context,
                                                          data: message,
                                                        );
                                                      },
                                                      onPaused: () {
                                                        utils.showSnackbar(
                                                          context: context,
                                                          bgColor: Colors.blue,
                                                          data:
                                                              "Operation Paused",
                                                        );
                                                      },
                                                      onFailed: () {
                                                        utils.showSnackbar(
                                                          context: context,
                                                          bgColor: Colors.red,
                                                          data:
                                                              "Operation Failed",
                                                        );
                                                      },
                                                      onCanceled: () {},
                                                      onSucced: (url) {
                                                        utils.showSnackbar(
                                                          context: context,
                                                          bgColor: Colors.green,
                                                          data:
                                                              "Profile picture uploaded",
                                                        );
                                                        localUser
                                                            .setLocalUserProfileUrl(
                                                          url: url,
                                                        );
                                                      },
                                                      filePath: filePath,
                                                      fileName: filename,
                                                      uid: FirebaseAuth
                                                              .instance
                                                              .currentUser
                                                              ?.uid ??
                                                          "",
                                                    ),
                                                  );
                                            },
                                          ),
                                        );
                                    return;
                                  }
                                  context.read<ImageBloc>().add(
                                        ImageEvent.cameraRequested(
                                          onError: (message) {},
                                          onSucceed: (filePath, filename) {
                                            if (context.mounted) {
                                              context
                                                  .read<ProfilePictureBloc>()
                                                  .add(
                                                    ProfilePictureEvent
                                                        .imageUploaded(
                                                      onError: (message) {
                                                        utils.showSnackbar(
                                                          context: context,
                                                          data: message,
                                                        );
                                                      },
                                                      onPaused: () {
                                                        utils.showSnackbar(
                                                          context: context,
                                                          bgColor: Colors.blue,
                                                          data:
                                                              "Operation Paused",
                                                        );
                                                      },
                                                      onFailed: () {
                                                        utils.showSnackbar(
                                                          context: context,
                                                          bgColor: Colors.red,
                                                          data:
                                                              "Operation Failed",
                                                        );
                                                      },
                                                      onCanceled: () {},
                                                      onSucced: (url) {
                                                        utils.showSnackbar(
                                                          context: context,
                                                          bgColor: Colors.green,
                                                          data:
                                                              "Profile picture uploaded",
                                                        );
                                                        localUser
                                                            .setLocalUserProfileUrl(
                                                          url: url,
                                                        );
                                                      },
                                                      filePath: filePath,
                                                      fileName: filename,
                                                      uid: FirebaseAuth
                                                              .instance
                                                              .currentUser
                                                              ?.uid ??
                                                          "",
                                                    ),
                                                  );
                                            }
                                            logger.e("nout mounted");
                                          },
                                        ),
                                      );
                                },
                                title: Text(
                                  element,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    );
                  },
                );
              },
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
