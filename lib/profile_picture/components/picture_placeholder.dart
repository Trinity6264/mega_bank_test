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

import "package:bank/app/service_locator.dart";
import "package:bank/common/constant.dart";
import "package:bank/local_user/local_user.dart";
import "package:bank/local_user/model/local_user_model.dart";
import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";

class PicturePlaceholder extends StatelessWidget {
  const PicturePlaceholder({super.key});
  static final localUser = getIt.get<LocalUser>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<LocalUserModel?>(
      stream: localUser.localUser.stream,
      builder: (context, snapshot) {
        final data = snapshot.data;
        if (data == null) {
          return CircleAvatar(
            backgroundColor: context.secondaryColor,
            radius: MediaQuery.sizeOf(context).width / 5,
            child: CircleAvatar(
              backgroundImage: const AssetImage("assets/Union.png"),
              radius: MediaQuery.sizeOf(context).width / 5.2,
            ),
          );
        }
        return CachedNetworkImage(
          imageUrl: data.profilePictureUrl,
          imageBuilder: (context, imageProvider) {
            return CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              radius: MediaQuery.sizeOf(context).width / 5,
              child: CircleAvatar(
                backgroundImage: imageProvider,
                radius: MediaQuery.sizeOf(context).width / 5.2,
              ),
            );
          },
          placeholder: (context, url) {
            return CircleAvatar(
              backgroundColor: context.secondaryColor,
              radius: MediaQuery.sizeOf(context).width / 5,
              child: CircleAvatar(
                backgroundImage: const AssetImage("assets/Union.png"),
                radius: MediaQuery.sizeOf(context).width / 5.2,
              ),
            );
          },
          errorWidget: (context, url, error) {
            return CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              radius: MediaQuery.sizeOf(context).width / 5,
              child: CircleAvatar(
                radius: MediaQuery.sizeOf(context).width / 5.2,
                child: const Center(
                  child: Icon(Icons.broken_image_outlined),
                ),
              ),
            );
          },
          useOldImageOnUrlChange: true,
        );
      },
    );
  }
}
