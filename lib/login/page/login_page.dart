import "package:auto_route/auto_route.dart";
import "package:bank/app/service_locator.dart";
import "package:bank/common/constant.dart";
import "package:bank/common/gradient_container.dart";
import "package:bank/common/utils.dart";
import "package:bank/internet_connectivity/bloc/internet_connectivity_bloc.dart";
import "package:bank/login/components/login_button.dart";
import "package:bank/login/components/login_email_input.dart";
import "package:bank/login/components/login_password_input.dart";
import "package:bank/routes/bank_auto_router.gr.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_svg/flutter_svg.dart";

@RoutePage()
class LoginPage extends StatelessWidget {
  const LoginPage({
    this.onResults,
    super.key,
  });
  final void Function({bool? validationResut})? onResults;

  @override
  Widget build(BuildContext context) {
    return BlocListener<InternetConnectivityBloc, InternetConnectivityState>(
      listener: (context, state) {
        if (state.isConnected) {
          return getIt.get<Utils>().clearNoInternetBanner(context: context);
        }
        getIt.get<Utils>().showNoInternetBanner(context: context);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: context.primaryColor,
          elevation: 0,
          title: SvgPicture.asset(
            "assets/logo.svg",
            height: 32,
          ),
          centerTitle: true,
        ),
        body: Stack(
          key: const Key("Stack"),
          children: [
            const GradientContainer(),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.getMediumPaddingSize(),
              ),
              child: CustomScrollView(
                slivers: [
                  SliverList.list(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: MediaQuery.sizeOf(context).height * 0.8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Spacer(),
                            Center(
                              child: Text(
                                "Sign In",
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
                                "Welcome Back!",
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
                                "Sign In and let's get going",
                                style: TextStyle(
                                  color: const Color(0xffF5F5F5),
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.175,
                                  fontSize: context.getNameTextFontSize(),
                                ),
                              ),
                            ),
                            const Spacer(flex: 2),
                            const LoginEmailInput(),
                            // const Spacer(),
                            const Hero(
                              tag: "play",
                              child: LoginPasswordInput(),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  //TODO(@Trinity6264): #106 The next page after the page should be a page where you take the email/phone number to send the link to
                                  context.pushRoute(
                                    VerifyPage(),
                                  );
                                },
                                child: Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                    color: const Color(0xffF5F5F5),
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.175,
                                    fontSize: context.getNameTextFontSize(),
                                  ),
                                ),
                              ),
                            ),
                            const Spacer(),
                            const LoginButton(),

                            const Spacer(flex: 2),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account yet?",
                                  style: TextStyle(
                                    color: const Color(0xffF5F5F5),
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.175,
                                    fontSize: context.getNameTextFontSize(),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    // getIt
                                    //     .get<FormValidation>()
                                    //     .updateSignUpForm(true);
                                    // onResults(validationResut: true);
                                    context.pushRoute(RegisterPage());
                                  },
                                  child: Text(
                                    "Sign Up",
                                    style: TextStyle(
                                      color: context.secondaryColor,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.175,
                                      fontSize: context.getNameTextFontSize(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
