import "package:auto_route/auto_route.dart";
import "package:bank/common/constant.dart";
import "package:bank/common/transaction_card.dart";
import "package:bank/data/bloc/data_bloc.dart";
import "package:bank/enums/tab_type.dart";
import "package:bank/extension/translation_extentions.dart";
import "package:bank/transactions/components/custom_tab.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

final GlobalKey<SliverAnimatedListState> globalKey =
    GlobalKey<SliverAnimatedListState>();

@RoutePage()
class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<DataBloc, DataState>(
      listener: (context, state) {
        for (var i = 0; i < state.transactionData.length; i++) {
          globalKey.currentState!.insertItem(
            i,
            duration: const Duration(milliseconds: 400),
          );
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: context.transactionTopBarHeight(),
            color: const Color(0xFFE1E6F0).withOpacity(0.32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: context.getMediumPaddingSize(),
                    horizontal: context.getMediumPaddingSize(),
                  ),
                  child: Text(
                    "transactions".translateLanguage,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff001530),
                      fontSize: context.getTransactionTextFontSize(),
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTab(
                        customTabType: CustomTabType.all,
                        onTap: () {
                          context.read<DataBloc>().add(
                                const DataEvent.onLoadedAllData(),
                              );
                        },
                      ),
                      CustomTab(
                        customTabType: CustomTabType.debit,
                        onTap: () {
                          context
                              .read<DataBloc>()
                              .add(const DataEvent.onLoadedDebitData());
                        },
                      ),
                      CustomTab(
                        customTabType: CustomTabType.credit,
                        onTap: () {
                          context
                              .read<DataBloc>()
                              .add(const DataEvent.onLoadedCreditData());
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<DataBloc, DataState>(
              builder: (context, state) {
                return state.when(
                  initial: () {
                    return Center(
                      child: CircularProgressIndicator.adaptive(
                        backgroundColor: context.secondaryColor,
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
                  dataLoad: (_, __, transactionData, ____, _____, ___) {
                    return CustomScrollView(
                      slivers: [
                        SliverAnimatedList(
                          key: globalKey,
                          initialItemCount: transactionData.length,
                          itemBuilder: (context, index, animation) {
                            if (index >= transactionData.length) {
                              return const SizedBox.shrink();
                            }
                            final model = transactionData[index];
                            return SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(0, 1),
                                end: Offset.zero,
                              ).animate(
                                CurvedAnimation(
                                  parent: animation,
                                  curve: Curves.linear,
                                ),
                              ),
                              child: FadeTransition(
                                opacity: Tween<double>(begin: 0, end: 1)
                                    .animate(animation),
                                alwaysIncludeSemantics: true,
                                child: TransactionCard(transactionModel: model),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  },
                  error: () {
                    return const Center(
                      child: Text("Loading failed please try again"),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
