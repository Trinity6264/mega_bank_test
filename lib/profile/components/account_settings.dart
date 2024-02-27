import "package:bank/common/constant.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";

class AccountSettings extends StatelessWidget {
  const AccountSettings({
    required this.iconPath,
    required this.isHavingIcon,
    required this.isLast,
    required this.title,
    required this.onPressed,
    super.key,
  });

  final String iconPath;
  final String title;
  final bool isHavingIcon;
  final bool isLast;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GestureDetector(
          onTap: onPressed,
          child: Container(
            padding: EdgeInsets.all(
              context.getMediumPaddingSize(),
            ),
            child: Row(
              children: [
                if (isHavingIcon) ...[SvgPicture.asset(iconPath)],
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal:
                        !isHavingIcon ? 0 : context.getMediumPaddingSize(),
                  ),
                  child: Text(
                    title,
                    style: TextStyle(
                      color: const Color(0xff022E64),
                      fontWeight: FontWeight.w400,
                      fontSize: context.getBodyFontSize(),
                      letterSpacing: 0.175,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (isLast)
          const SizedBox.shrink()
        else
          Divider(
            color: const Color(0xFFE1E6F0).withOpacity(0.32),
            thickness: 1.5,
          ),
      ],
    );
  }
}
