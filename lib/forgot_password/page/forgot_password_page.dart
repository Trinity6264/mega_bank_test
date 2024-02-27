import "package:auto_route/auto_route.dart";
import "package:bank/common/constant.dart";
import "package:bank/common/custom_back_button.dart";
import "package:bank/forgot_password/components/confirmed_password_input.dart";
import "package:bank/forgot_password/components/forgot_password_button.dart";
import "package:bank/forgot_password/components/password_input.dart";
import "package:bank/internet_connectivity/bloc/internet_connectivity_bloc.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_svg/flutter_svg.dart";

@RoutePage()
class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 120,
        leading: Padding(
          padding: EdgeInsets.only(
            left: context.getMediumPaddingSize(),
          ),
          child: const CustomBackButton(),
        ),
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
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.0583, 1.0, 1.0],
                colors: [
                  Color(0xFF022E64),
                  Color(0xFF004395),
                  Color(0xFF00408F),
                ],
              ),
            ),
          ),
          BlocSelector<InternetConnectivityBloc, InternetConnectivityState,
              bool>(
            selector: (state) {
              return state.isConnected;
            },
            builder: (context, state) {
              return Container(
                padding: EdgeInsets.symmetric(
                  horizontal: context.getMediumPaddingSize(),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Spacer(flex: 3),
                    Hero(
                      tag: "play",
                      child: PasswordInput(),
                    ),
                    ConfirmedPasswordInput(),
                    Spacer(flex: 3),
                    ForgotPasswordButton(),
                    Spacer(flex: 2),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
