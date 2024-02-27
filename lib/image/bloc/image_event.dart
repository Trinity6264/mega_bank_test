part of "image_bloc.dart";

@freezed
class ImageEvent with _$ImageEvent {
  const factory ImageEvent.cameraRequested({
    required void Function(String message) onError,
    required void Function(
      String filePath,
      String filename,
    ) onSucceed,
  }) = _CameraRequested;

  const factory ImageEvent.galleryRequested({
    required void Function(String message) onError,
    required void Function(
      String filePath,
      String filename,
    ) onSucceed,
  }) = _GalleryRequested;
}
