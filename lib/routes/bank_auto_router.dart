import "package:auto_route/auto_route.dart";
import "package:bank/routes/bank_auto_router.gr.dart";
import "package:bank/routes/custom_fade_route.dart";

@AutoRouterConfig(replaceInRouteName: "Screen,Route")
class BankAutoRouter extends $BankAutoRouter {
  BankAutoRouter();

  @override
  final routes = <AutoRoute>[
    AutoRoute(page: SplashPage.page, initial: true),
    AutoRoute(page: LoginPage.page),
    CustomFadeRoute(page: RegisterPage.page),
    CustomFadeRoute(
      page: VerifyPage.page,
    ),
    CustomFadeRoute(page: ChangePasswordPage.page),
    AutoRoute(page: LogoutChangePasswordPage.page),
    CustomFadeRoute(page: PersonalInformationPage.page),
    CustomFadeRoute(page: ProfilePicturePage.page),
    CustomFadeRoute(page: ProfilePictureUploadPage.page),
    CustomFadeRoute(page: RequestPasswordResetPage.page),
    CustomFadeRoute(page: ProfilePage.page),
    CustomFadeRoute(page: LoadingPage.page),
    CustomFadeRoute(page: EditProfilePage.page),
    CustomFadeRoute(page: ForgotPasswordPage.page),
    CustomFadeRoute(page: SeeAllTransactionsPage.page),
    CustomFadeRoute(
      page: DashBoardPage.page,
      children: [
        AutoRoute(page: HomePage.page, initial: true),
        AutoRoute(page: TransactionPage.page),
      ],
    ),
  ];
}
