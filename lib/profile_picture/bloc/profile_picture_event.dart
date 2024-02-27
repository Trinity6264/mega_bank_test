part of "profile_picture_bloc.dart";

@freezed
class ProfilePictureEvent with _$ProfilePictureEvent {
  const factory ProfilePictureEvent.loadingStarted({
    required double value,
  }) = _LoadingStarted;

  const factory ProfilePictureEvent.imageUploaded({
    required void Function(String errorMessage) onError,
    required void Function() onPaused,
    required void Function() onFailed,
    required void Function() onCanceled,
    required void Function(String url) onSucced,
    required String filePath,
    required String fileName,
    required String uid,
  }) = _ImageUploaded;

  const factory ProfilePictureEvent.loadingFailed({
    required String value,
  }) = _LoadingFailed;

  const factory ProfilePictureEvent.initialized() = _Initialized;
}
