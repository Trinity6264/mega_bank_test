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

import "dart:io";

import "package:bank/bank_observer.dart";
import "package:firebase_storage/firebase_storage.dart";

class ProfilePictureRepository {
  const ProfilePictureRepository({
    required FirebaseStorage firebaseStorage,
  }) : _firebaseStorage = firebaseStorage;
  final FirebaseStorage _firebaseStorage;

  Future<void> uploadProfilePicture({
    required String uid,
    required String filePath,
    required String filename,
    required void Function() onPaused,
    required void Function() onCancelled,
    required void Function(String message) onError,
    required void Function(double value) onLoading,
    required void Function(String value) onSuccess,
  }) async {
    final ref = _firebaseStorage.ref("Users/$uid/profile_picture/$filename/");
    try {
      final file = File(filePath);
      final resp = ref.putFile(file);
      resp.snapshotEvents.listen(
        (TaskSnapshot snapshot) async {
          switch (snapshot.state) {
            case TaskState.paused:
              onPaused();
            case TaskState.running:
              final progress =
                  100 * (snapshot.bytesTransferred / snapshot.totalBytes);
              onLoading(progress);
            case TaskState.success:
              final url = await snapshot.ref.getDownloadURL();
              onSuccess(url);

            case TaskState.canceled:
              onCancelled();
            case TaskState.error:
              onError("Error While uploading profile picture");
          }
        },
      );
    } catch (e) {
      logger.e(e);
      onError(e.toString());
      return;
    }
  }
}
