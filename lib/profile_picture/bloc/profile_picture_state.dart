part of "profile_picture_bloc.dart";

@freezed
class ProfilePictureState with _$ProfilePictureState {
  const factory ProfilePictureState.initial() = _Initial;

  const factory ProfilePictureState.loading({
    required double progress,
  }) = _Loading;
  const factory ProfilePictureState.failed() = _Failed;
  const ProfilePictureState._();

  bool get isLoading => this is _Loading;
  bool get isFailed => this is _Failed;

  double get progress {
    if (this is _Loading) {
      return (this as _Loading).progress;
    }
    return 0;
  }
}
