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

import "package:bank/local_user/model/local_user_model.dart";
import "package:rxdart/rxdart.dart";

class LocalUser {
  LocalUser();
  final localUser = BehaviorSubject<LocalUserModel?>.seeded(null);

  void setLocalUser({
    required String username,
    required String email,
    required String uid,
  }) {
    final user = LocalUserModel(email: email, username: username, uid: uid);
    localUser.add(user);
  }

  void setLocalUserProfileUrl({required String url}) {
    final user = localUser.value;
    if (user != null) {
      localUser.add(user.copyWith(profilePictureUrl: url));
    }
  }

  void resetLocalUser() {
    localUser.add(null);
  }
}
