import "package:bank/common/constant.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";

class CustomRoundedButton extends StatelessWidget {
  const CustomRoundedButton({
    required this.text,
    required this.onPressed,
    this.icon,
    this.bgColor = const Color(0xffE6B014),
    this.textColor = const Color(0xff212121),
    super.key,
  });
  final String text;
  final String? icon;
  final Color textColor;
  final Color bgColor;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: EdgeInsets.all(
          context.getMediumPaddingSize(),
        ),
        backgroundColor: bgColor,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Color(0xffE6B014),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(
            8,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: SvgPicture.asset(icon!),
            )
          else
            const SizedBox.shrink(),
          Text(
            text,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.2,
              fontSize: context.getNameTextFontSize(),
            ),
          ),
        ],
      ),
    );
  }
}
