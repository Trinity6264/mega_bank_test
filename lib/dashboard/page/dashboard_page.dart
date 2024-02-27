import "package:auto_route/auto_route.dart";
import "package:bank/app/service_locator.dart";
import "package:bank/common/constant.dart";
import "package:bank/customer/model/customer_model.dart";
import "package:bank/dashboard/components/custom_bottom_navbar.dart";
import "package:bank/dashboard/components/dashboard_profile.dart";
import "package:bank/data/bloc/data_bloc.dart";
import "package:bank/extension/translation_extentions.dart";
import "package:bank/local_user/local_user.dart";
import "package:bank/local_user/model/local_user_model.dart";
import "package:bank/routes/bank_auto_router.gr.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_svg/svg.dart";

@RoutePage()
class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  bool _hasStarted = false;

  Future<void> start() async {
    setState(() {
      _hasStarted = true;
    });
  }

  final localUser = getIt.get<LocalUser>();

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color(0xff022E64),
        statusBarIconBrightness: Brightness.light,
      ),
    );
    super.initState();
    start();
  }

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      appBarBuilder: (context, tabsRouter) {
        return !_hasStarted
            ? AppBar(
                backgroundColor: context.primaryColor,
              )
            : PreferredSize(
                preferredSize: Size.fromHeight(
                  context.dashBoardAppBarHeight(),
                ),
                child: BlocSelector<DataBloc, DataState, bool>(
                  selector: (state) {
                    return state.transactionDataEmpty;
                  },
                  builder: (context, state) {
                    return AnimatedSwitcher(
                      duration: const Duration(seconds: 2),
                      child: state
                          ? AppBar(
                              centerTitle: true,
                              automaticallyImplyLeading: false,
                              backgroundColor: context.primaryColor,
                              title: Text(
                                TimeOfDay.now().greetingsTime,
                                style: TextStyle(
                                  color: const Color(0xffffffff),
                                  fontWeight: FontWeight.w600,
                                  fontSize:
                                      context.getTransactionTextFontSize(),
                                ),
                              ).translateLanguage,
                            )
                          : AppBar(
                              backgroundColor: context.primaryColor,
                              leadingWidth: 70,
                              leading: const DashBoardProfile(),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    TimeOfDay.now().greetingsTime,
                                    style: TextStyle(
                                      color: const Color(0xffffffff)
                                          .withOpacity(0.8),
                                      fontWeight: FontWeight.w600,
                                      fontSize:
                                          context.getGreetingsTextFontSize(),
                                    ),
                                  ).translateLanguage,
                                  BlocSelector<DataBloc, DataState,
                                      CustomerModel?>(
                                    selector: (state) {
                                      return state.user;
                                    },
                                    builder: (context, data) {
                                      if (data == null) {
                                        return const SizedBox.shrink();
                                      }
                                      return StreamBuilder<LocalUserModel?>(
                                        stream: localUser.localUser.stream,
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData &&
                                              snapshot.data != null) {
                                            return Text(
                                              "${snapshot.data?.username}",
                                              style: TextStyle(
                                                color: const Color(0xffffffff),
                                                fontWeight: FontWeight.w600,
                                                fontSize: context
                                                    .getNameTextFontSize(),
                                              ),
                                            );
                                          }
                                          return Text(
                                            "${data.title} ${data.name}",
                                            style: TextStyle(
                                              color: const Color(0xffffffff),
                                              fontWeight: FontWeight.w600,
                                              fontSize:
                                                  context.getNameTextFontSize(),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                              actions: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    right: context.getMediumPaddingSize(),
                                  ),
                                  child: SvgPicture.asset(
                                    "assets/logo.svg",
                                    width:
                                        MediaQuery.sizeOf(context).height / 10,
                                  ),
                                ),
                              ],
                            ),
                    );
                  },
                ),
              );
      },
      routes: const [
        HomePage(),
        TransactionPage(),
      ],
      animationCurve: Curves.easeInToLinear,
      bottomNavigationBuilder: (context, tabsRouter) {
        return CustomBottomNavbar(tabsRouter: tabsRouter);
      },
    );
  }
}

extension TimeOfDayExtension on TimeOfDay {
  String get greetingsTime {
    if (hour < 12) {
      return "good-morning";
    }
    if (hour > 11 && hour < 16) {
      return "good-afternoon";
    }
    return "good-evening";
  }
}
