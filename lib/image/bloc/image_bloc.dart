import "package:bank/image/repository/image_repository.dart";
import "package:bloc/bloc.dart";
import "package:freezed_annotation/freezed_annotation.dart";

part "image_bloc.freezed.dart";
part "image_event.dart";
part "image_state.dart";

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  ImageBloc({required this.imageRepository}) : super(const _ImageState()) {
    on<_CameraRequested>(_onCameraRequested);
    on<_GalleryRequested>(_onGalleryRequested);
  }
  final ImageRepository imageRepository;

  Future<void> _onCameraRequested(
    _CameraRequested event,
    Emitter<ImageState> emit,
  ) async {
    final result = await imageRepository.openCamera();

    result.when(
      (success) {
        event.onSucceed(success.$1, success.$2);
      },
      (error) {
        event.onError(error);
      },
    );
  }

  Future<void> _onGalleryRequested(
    _GalleryRequested event,
    Emitter<ImageState> emit,
  ) async {
    final result = await imageRepository.openGallery();

    result.when(
      (success) {
        event.onSucceed(success.$1, success.$2);
      },
      (error) {
        event.onError(error);
      },
    );
  }
}
