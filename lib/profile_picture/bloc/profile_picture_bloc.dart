import "package:bank/profile_picture/repository/profile_picture_repository.dart";
import "package:bloc/bloc.dart";
import "package:freezed_annotation/freezed_annotation.dart";

part "profile_picture_bloc.freezed.dart";
part "profile_picture_event.dart";
part "profile_picture_state.dart";

class ProfilePictureBloc
    extends Bloc<ProfilePictureEvent, ProfilePictureState> {
  ProfilePictureBloc({required this.profilePictureRepository})
      : super(const _Initial()) {
    on<_Initialized>(_onInitialized);
    on<_LoadingStarted>(_onLoadingStated);
    on<_LoadingFailed>(_onFailed);
    on<_ImageUploaded>(_onImageUploaded);
  }
  final ProfilePictureRepository profilePictureRepository;

  Future<void> _onLoadingStated(
    _LoadingStarted event,
    Emitter<ProfilePictureState> emit,
  ) async {
    emit(ProfilePictureState.loading(progress: event.value));
  }

  Future<void> _onImageUploaded(
    _ImageUploaded event,
    Emitter<ProfilePictureState> emit,
  ) async {
    if (event.uid == "") {
      event.onError("Session expired,please login");
      return;
    }
    await profilePictureRepository.uploadProfilePicture(
      filePath: event.filePath,
      filename: event.fileName,
      uid: event.uid,
      onCancelled: event.onCanceled,
      onError: (message) {
        event.onError(message);
        add(ProfilePictureEvent.loadingFailed(value: message));
      },
      onLoading: (value) {
        add(ProfilePictureEvent.loadingStarted(value: value));
      },
      onPaused: event.onPaused,
      onSuccess: (value) {
        add(const _Initialized());
        event.onSucced(value);
      },
    );
  }

  Future<void> _onFailed(
    _LoadingFailed event,
    Emitter<ProfilePictureState> emit,
  ) async {
    emit(const ProfilePictureState.failed());
  }

  Future<void> _onInitialized(
    _Initialized event,
    Emitter<ProfilePictureState> emit,
  ) async {
    emit(const ProfilePictureState.initial());
  }
}
