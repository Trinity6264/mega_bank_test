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
import "package:flutter/services.dart";
import "package:image_picker/image_picker.dart";
import "package:multiple_result/multiple_result.dart";

class ImageRepository {
  const ImageRepository({required ImagePicker imagePicker})
      : _imagePicker = imagePicker;

  final ImagePicker _imagePicker;

  Future<Result<(String, String), String>> openGallery() async {
    try {
      final image = await _imagePicker.pickImage(source: ImageSource.gallery);

      if (image == null) {
        final lostImageFile = await _retrivelostData();

        return lostImageFile.when(
          (success) {
            final selectedImage = File(success.path);

            return Result.success((selectedImage.path, success.name));
          },
          (error) {
            return const Result.error("Failed to get image from gallery");
          },
        );
      }

      final selectedImage = File(image.path);

      return Result.success((selectedImage.path, image.name));
    } on PlatformException catch (e) {
      logger.e("Failed to get image from gallery: ${e.message}");

      return const Result.error("Failed to get image from gallery");
    } catch (_) {
      return const Result.error("Failed to get image from gallery");
    }
  }

  Future<Result<(String, String), String>> openCamera() async {
    try {
      final image = await _imagePicker.pickImage(source: ImageSource.camera);

      if (image == null) {
        final lostImageFile = await _retrivelostData();

        return lostImageFile.when(
          (success) {
            final selectedImage = File(success.path);

            return Result.success((selectedImage.path, success.name));
          },
          (error) {
            return const Result.error("Failed to get image from camera");
          },
        );
      }

      final selectedImage = File(image.path);

      return Result.success((selectedImage.path, image.name));
    } on PlatformException catch (e) {
      logger.e("Failed to get image from  camera: ${e.message}");

      return const Result.error("Failed to get image from camera");
    } catch (_) {
      return const Result.error("Failed to get image from camera");
    }
  }

// This method only works on android
  Future<Result<XFile, void>> _retrivelostData() async {
    if (!Platform.isAndroid) {
      return const Result.error(null);
    }
    final picker = ImagePicker();

    final resp = await picker.retrieveLostData();
    if (resp.isEmpty) {
      return const Result.error(null);
    }

    final file = resp.file;
    if (file == null) {
      return const Result.error(null);
    }
    return Result.success(file);
  }
}
