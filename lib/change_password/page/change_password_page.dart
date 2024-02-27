import "package:auto_route/auto_route.dart";
import "package:bank/change_password/components/confirm_new_password_input.dart";
import "package:bank/change_password/components/new_password_input.dart";
import "package:bank/change_password/components/old_password_input.dart";
import "package:bank/change_password/components/reset_password_button.dart";
import "package:bank/common/constant.dart";
import "package:bank/common/custom_back_button.dart";
import "package:bank/common/gradient_container.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";

@RoutePage()
class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const CustomBackButton(),
        backgroundColor: const Color(0xFF022E64),
        elevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.only(
              right: context.getMediumPaddingSize(),
            ),
            child: SvgPicture.asset(
              "assets/logo.svg",
              width: MediaQuery.sizeOf(context).height / 12,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          const GradientContainer(),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: context.getMediumPaddingSize(),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                //TODO(@Trinity6264): #107 The Center widget wrapped around the Text widget is working for the last text widget, refactor and fix this. Consider using the widget properties
                Center(
                  child: Text(
                    "Set New Password",
                    style: TextStyle(
                      color: const Color(0xffF5F5F5),
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.175,
                      fontSize: context.getHeaderFontSize(),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    "Enter the new passwords for your",
                    style: TextStyle(
                      color: const Color(0xffF5F5F5),
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.175,
                      fontSize: context.getNameTextFontSize(),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    "account. Don't forget it this time please",
                    style: TextStyle(
                      color: const Color(0xffF5F5F5),
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.175,
                      fontSize: context.getNameTextFontSize(),
                    ),
                  ),
                ),
                const Spacer(),
                //TODO(@Trinity6264): #108 The error validation triggers for both input fields, fix this
                const OldPasswordInput(),
                const NewPasswordInput(),
                const ConfirmNewPasswordInput(),
                const Spacer(),
                const ResetPasswordButton(),
                const Spacer(flex: 4),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
