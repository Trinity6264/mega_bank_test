import "package:auto_route/auto_route.dart";
import "package:auto_size_text/auto_size_text.dart";
import "package:bank/common/constant.dart";
import "package:bank/common/transaction_card.dart";
import "package:bank/data/bloc/data_bloc.dart";
import "package:bank/extension/translation_extentions.dart";
import "package:bank/home/components/loading_widget.dart";
import "package:bank/routes/bank_auto_router.gr.dart";
import "package:easy_localization/easy_localization.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_svg/flutter_svg.dart";

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // final id = context.select((DataBloc bloc) => bloc.state.user[0].id);
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: MediaQuery.sizeOf(context).height / 5,
          child: Stack(
            children: [
              Image.asset(
                "assets/frame.png",
                width: double.infinity,
                fit: BoxFit.cover,
                height: double.infinity,
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
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.getMediumPaddingSize(),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "account-balance".translateLanguage,
                      style: TextStyle(
                        color: const Color(0xffffffff).withOpacity(0.8),
                        fontSize: context.getBodyFontSize(),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    BlocSelector<DataBloc, DataState, double>(
                      selector: (state) {
                        return state.userBalance;
                      },
                      builder: (context, state) {
                        return Text(
                          "GHC ${state.formatCurrency}.00",
                          style: TextStyle(
                            color: const Color(0xffffffff),
                            fontSize: context.getTextBalanceFontSize(),
                            fontWeight: FontWeight.w700,
                          ),
                        );
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "checking-account".translateLanguage,
                          style: TextStyle(
                            color: const Color(0xffffffff),
                            fontSize: context.getBodySmallFontSize(),
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.5,
                          ),
                        ),
                        Text(
                          "875431143137098707",
                          style: TextStyle(
                            color: const Color(0xffffffff).withOpacity(0.8),
                            fontSize: context.getBodySmallFontSize(),
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.5,
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
        Container(
          width: double.infinity,
          color: const Color(0xffffffff).withOpacity(0.32),
          padding: EdgeInsets.symmetric(
            horizontal: context.getMediumPaddingSize(),
            vertical: context.getSmallPaddingSize(),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AutoSizeText(
                "recent-transaction".translateLanguage,
                maxFontSize: 16,
                stepGranularity: 2.0,
                style: const TextStyle(
                  color: Color(0xff001530),
                  fontWeight: FontWeight.w600,
                ),
              ),
              GestureDetector(
                onTap: () {
                  context.pushRoute(const SeeAllTransactionsPage());
                },
                child: AutoSizeText(
                  "see-all".translateLanguage,
                  maxFontSize: 12,
                  minFontSize: 8,
                  stepGranularity: 2.0,
                  style: const TextStyle(
                    color: Color(0xff001530),
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.174,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: AnimatedSwitcher(
            duration: const Duration(seconds: 1),
            child: BlocBuilder<DataBloc, DataState>(
              builder: (context, state) {
                return state.when(
                  initial: () {
                    return Center(
                      child: LoadingWidget(
                        onLoad: () {
                          context.read<DataBloc>().add(
                                const DataEvent.onLoadedCloudData(
                                  id: "23399922",
                                ),
                              );
                        },
                      ),
                    );
                  },
                  loading: () {
                    return Center(
                      child: CircularProgressIndicator.adaptive(
                        backgroundColor: context.secondaryColor,
                      ),
                    );
                  },
                  dataLoad: (
                    selectedType,
                    user,
                    transactionData,
                    balance,
                    beforeAfterTransaction,
                    homeData,
                  ) {
                    return Scrollbar(
                      child: CustomScrollView(
                        slivers: [
                          SliverAnimatedList(
                            initialItemCount: homeData.length,
                            itemBuilder: (context, index, animation) {
                              final model = homeData[index];
                              return TransactionCard(transactionModel: model);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                  error: () {
                    return Center(
                      child: SvgPicture.asset("assets/image_empty.svg"),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

extension DoubleX on double {
  String get formatCurrency {
    final currencyFormat = NumberFormat.decimalPattern("en_US");
    return currencyFormat.format(this);
  }
}
