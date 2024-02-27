import "package:auto_route/auto_route.dart";
import "package:bank/common/constant.dart";
import "package:bank/extension/translation_extentions.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.popRoute();
      },
      child: Row(
        children: [
          SvgPicture.asset("assets/arrow-left.svg"),
          Text(
            "back".translateLanguage,
            style: TextStyle(
              color: const Color(0xffffffff),
              fontWeight: FontWeight.w500,
              fontSize: context.getGreetingsTextFontSize(),
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
