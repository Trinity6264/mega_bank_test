import "package:bank/app/service_locator.dart";
import "package:bank/bank_observer.dart";
import "package:bank/common/constant.dart";
import "package:bank/common/utils.dart";
import "package:bank/image/bloc/image_bloc.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:image_cropper/image_cropper.dart";
import "package:image_picker/image_picker.dart";

class PicturePlaceHolder extends StatelessWidget {
  const PicturePlaceHolder({super.key});

  static final utils = getIt.get<Utils>();

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.skewY(-0.18),
      child: GestureDetector(
        onTap: () async {
          final resp = await utils.showImagePickerBottomSheet(context);

          if (resp == ImageSource.camera && context.mounted) {
            context.read<ImageBloc>().add(
                  ImageEvent.cameraRequested(
                    onError: (message) {},
                    onSucceed: (filePath, filename) {
                      final cropperImage =
                          ImageCropper().cropImage(sourcePath: filePath);
                      logger.d(cropperImage);
                    },
                  ),
                );
          }
          if (resp == ImageSource.gallery && context.mounted) {
            context.read<ImageBloc>().add(
                  ImageEvent.galleryRequested(
                    onError: (message) {},
                    onSucceed: (filePath, filename) {},
                  ),
                );
          }
        },
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.sizeOf(context).width / 2,
          height: MediaQuery.sizeOf(context).height / 4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color(0xffF5F5F5),
          ),
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.skewY(0.18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/camera.svg",
                  colorFilter: const ColorFilter.mode(
                    Color(0xff212121),
                    BlendMode.srcIn,
                  ),
                ),
                Text(
                  "Upload",
                  style: TextStyle(
                    color: const Color(0xff212121),
                    letterSpacing: 0.2,
                    fontWeight: FontWeight.w600,
                    fontSize: context.getBodyFontSize(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
