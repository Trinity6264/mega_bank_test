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
import "package:bank/common/constant.dart";
import "package:bank/local_user/local_user.dart";
import "package:bank/local_user/model/local_user_model.dart";
import "package:bank/routes/bank_auto_router.gr.dart";
import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";

class DashBoardProfile extends StatelessWidget {
  const DashBoardProfile({super.key});
  static final localUser = getIt.get<LocalUser>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushRoute(const ProfilePage());
      },
      child: Padding(
        padding: EdgeInsets.only(
          left: context.getMediumPaddingSize(),
          top: 5,
          bottom: 5,
        ),
        child: StreamBuilder<LocalUserModel?>(
          stream: localUser.localUser.stream,
          builder: (context, snapshot) {
            final data = snapshot.data;
            if (snapshot.hasData && data != null) {
              return CachedNetworkImage(
                imageUrl: data.profilePictureUrl,
                errorWidget: (context, url, error) {
                  return Image.asset(
                    "assets/Union.png",
                    fit: BoxFit.cover,
                  );
                },
                placeholder: (context, url) {
                  return Image.asset(
                    "assets/Union.png",
                    fit: BoxFit.cover,
                  );
                },
                imageBuilder: (context, imageProvider) {
                  return Image(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  );
                },
                useOldImageOnUrlChange: true,
              );
            }
            return Image.asset(
              "assets/Union.png",
              fit: BoxFit.cover,
            );
          },
        ),
      ),
    );
  }
}
