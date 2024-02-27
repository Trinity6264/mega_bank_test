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
import "package:bank/local_user/local_user.dart";
import "package:bank/local_user/model/local_user_model.dart";
import "package:bank/routes/bank_auto_router.gr.dart";
import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({super.key});
  static final localUser = getIt.get<LocalUser>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        StreamBuilder<LocalUserModel?>(
          stream: localUser.localUser.stream,
          builder: (context, snapshot) {
            final data = snapshot.data;
            if (snapshot.hasData && data != null) {
              return CachedNetworkImage(
                imageUrl: data.profilePictureUrl,
                errorWidget: (context, url, error) {
                  return Hero(
                    tag: "profile-placeholder",
                    child: Image.asset(
                      "assets/Union.png",
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  );
                },
                imageBuilder: (context, imageProvider) {
                  return Hero(
                    tag: "profile-placeholder",
                    child: Image(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  );
                },
                placeholder: (context, url) {
                  return Hero(
                    tag: "profile-placeholder",
                    child: Image.asset(
                      "assets/Union.png",
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  );
                },
                useOldImageOnUrlChange: true,
              );
            }
            return Hero(
              tag: "profile-placeholder",
              child: Image.asset(
                "assets/Union.png",
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            );
          },
        ),
        Positioned(
          bottom: 10,
          child: GestureDetector(
            onTap: () {
              context.pushRoute(const EditProfilePage());
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              height: 32,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xff333333).withOpacity(0.6),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset("assets/edit.svg"),
                  const SizedBox(width: 4),
                  const Text(
                    "Edit Profile",
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
    );
  }
}
