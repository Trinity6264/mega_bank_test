import "package:animations/animations.dart";
import "package:auto_route/auto_route.dart";
import "package:bank/common/constant.dart";
import "package:bank/common/custom_back_button.dart";
import "package:bank/common/custom_rounded_button.dart";
import "package:bank/customer/model/customer_model.dart";
import "package:bank/data/bloc/data_bloc.dart";
import "package:bank/extension/translation_extentions.dart";
import "package:bank/profile/components/account_settings.dart";
import "package:bank/profile/components/app_version.dart";
import "package:bank/profile/components/profile_info.dart";
import "package:bank/profile/components/profile_picture.dart";
import "package:bank/routes/bank_auto_router.gr.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_svg/flutter_svg.dart";

@RoutePage()
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(
        backgroundColor: context.primaryColor,
        automaticallyImplyLeading: false,
        title: const CustomBackButton(),
        actions: [
          Padding(
            padding: EdgeInsets.only(
              right: context.getMediumPaddingSize(),
            ),
            child: SvgPicture.asset(
              "assets/logo.svg",
              height: 38,
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Stack(
                        children: [
                          Container(
                            height: context.profilePageBottomAppbar(),
                            color: const Color(0xffFDF8EC),
                            child: Row(
                              children: [
                                const Expanded(
                                  child: ProfilePicture(),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: context.getSmallPaddingSize(),
                                      horizontal: context.getSmallPaddingSize(),
                                    ),
                                    child: BlocSelector<DataBloc, DataState,
                                        CustomerModel?>(
                                      selector: (state) {
                                        return state.user;
                                      },
                                      builder: (context, state) {
                                        if (state == null) {
                                          return const SizedBox();
                                        }
                                        final CustomerModel(
                                          :name,
                                          // :gender,
                                          // :id,
                                          // :title
                                        ) = state;
                                        return Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            AccountInfo(
                                              accountInfoParams: (
                                                title: "first-name"
                                                    .translateLanguage,
                                                name: name.split(" ")[0],
                                              ),
                                            ),
                                            AccountInfo(
                                              accountInfoParams: (
                                                title: "other-name"
                                                    .translateLanguage,
                                                name: name.split(" ")[1],
                                              ),
                                            ),
                                            const AccountInfo(
                                              accountInfoParams: (
                                                title: "Phone",
                                                name: "054 123 3465",
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            child: Container(
                              height: 5,
                              width: MediaQuery.sizeOf(context).width / 1,
                              decoration: BoxDecoration(
                                color: const Color(0xff022E64).withOpacity(0.6),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        color: const Color(0xFFE1E6F0).withOpacity(0.32),
                        padding: EdgeInsets.symmetric(
                          horizontal: context.getMediumPaddingSize(),
                          vertical: context.getSmallPaddingSize(),
                        ),
                        child: Text(
                          "account-settings".translateLanguage,
                          style: TextStyle(
                            color: const Color(0xff001530),
                            fontWeight: FontWeight.w600,
                            fontSize: context.getBodyFontSize(),
                          ),
                        ),
                      ),
                      AccountSettings(
                        iconPath: "assets/sms.svg",
                        title: "Change Account Phone Number",
                        isHavingIcon: true,
                        isLast: false,
                        onPressed: () {
                          context.pushRoute(const ChangePasswordPage());
                        },
                      ),
                      AccountSettings(
                        iconPath: "assets/lock.svg",
                        title: "change-account-password".translateLanguage,
                        isHavingIcon: true,
                        isLast: false,
                        onPressed: () {
                          context.pushRoute(const ChangePasswordPage());
                        },
                      ),
                      AccountSettings(
                        iconPath: "assets/logout.svg",
                        title: "logout".translateLanguage,
                        isLast: false,
                        isHavingIcon: true,
                        onPressed: () {
                          showModal<void>(
                            context: context,
                            configuration:
                                const FadeScaleTransitionConfiguration(
                              transitionDuration: Duration(milliseconds: 500),
                              reverseTransitionDuration:
                                  Duration(milliseconds: 300),
                            ),
                            builder: (context) {
                              return AlertDialog.adaptive(
                                contentPadding: EdgeInsets.all(
                                  context.getMediumPaddingSize(),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    context.getMediumRadiusSize(),
                                  ),
                                ),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    const Center(
                                      child: Text(
                                        "Sign Out?",
                                        style: TextStyle(
                                          color: Color(0xff212121),
                                          fontWeight: FontWeight.w800,
                                          fontSize: 24,
                                          letterSpacing: 0.175,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 24),
                                    Text(
                                      "Are you sure you want to sign out of the app?",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: const Color(0xff212121),
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.175,
                                        fontSize: context.getNameTextFontSize(),
                                      ),
                                    ),
                                    const SizedBox(height: 24),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: CustomRoundedButton(
                                            text: "Confirm",
                                            bgColor: Colors.white,
                                            textColor: context.secondaryColor,
                                            onPressed: () {
                                              context.router.replaceAll([
                                                LoginPage(),
                                              ]);
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: CustomRoundedButton(
                                            text: "Cancel",
                                            onPressed: () {
                                              context.popRoute();
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
                      Container(
                        color: const Color(0xFFE1E6F0).withOpacity(0.32),
                        padding: EdgeInsets.symmetric(
                          horizontal: context.getMediumPaddingSize(),
                          vertical: context.getSmallPaddingSize(),
                        ),
                        child: Text(
                          "about".translateLanguage,
                          style: TextStyle(
                            color: const Color(0xff001530),
                            fontWeight: FontWeight.w600,
                            fontSize: context.getBodyFontSize(),
                          ),
                        ),
                      ),
                      AccountSettings(
                        iconPath: "assets/logout.svg",
                        title: "terms-and-conditions".translateLanguage,
                        isHavingIcon: false,
                        isLast: false,
                        onPressed: () {},
                      ),
                      AccountSettings(
                        iconPath: "assets/logout.svg",
                        title: "privacy-policy".translateLanguage,
                        isLast: false,
                        isHavingIcon: false,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          //?!?! /
          Divider(
            color: const Color(0xFFE1E6F0).withOpacity(0.32),
            thickness: 1.5,
          ),
          const AppVersion(),
        ],
      ),
    );
  }
}
