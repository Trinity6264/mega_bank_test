import "package:bank/common/bottom_card_info.dart";
import "package:bank/common/constant.dart";
import "package:bank/data/bloc/data_bloc.dart";
import "package:bank/extension/translation_extentions.dart";
import "package:bank/transactions/model/transaction_model.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class TransactionCardDetail extends StatelessWidget {
  const TransactionCardDetail({
    required this.controller,
    required this.transactionModel,
    super.key,
  });
  final ScrollController controller;
  final TransactionModel transactionModel;

  @override
  Widget build(BuildContext context) {
    final TransactionModel(
      :date,
      :narration,
      :type,
    ) = transactionModel;
    return Container(
      height: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xffffffff),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: MediaQuery.sizeOf(context).width / 10,
            height: 5,
            margin: EdgeInsets.only(
              top: context.getMediumPaddingSize(),
            ),
            decoration: BoxDecoration(
              color: const Color(0xffD9D9D9),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          Expanded(
            child: CustomScrollView(
              controller: controller,
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: context.getMediumPaddingSize(),
                        ),
                        child: Align(
                          child: Text(
                            "transaction-details".translateLanguage,
                            style: TextStyle(
                              color: const Color(0xff001530),
                              fontWeight: FontWeight.w400,
                              fontSize: context.getBodyFontSize(),
                            ),
                          ),
                        ),
                      ),
                      BlocSelector<DataBloc, DataState, BeforeAfterTransaction>(
                        selector: (state) {
                          return state.beforeAfterTransaction;
                        },
                        builder: (context, state) {
                          return Column(
                            children: [
                              BottomCardInfo(
                                cardInfoParam: (
                                  key: "balance-before-transaction"
                                      .translateLanguage,
                                  value: "GHC ${state.$1}",
                                ),
                              ),
                              BottomCardInfo(
                                cardInfoParam: (
                                  key: "balance-after-transaction"
                                      .translateLanguage,
                                  value: "GHC ${state.$2}",
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: context.getMediumPaddingSize(),
                        ),
                        child: const Divider(thickness: 1.0),
                      ),
                      BottomCardInfo(
                        cardInfoParam: (
                          key: "transaction-date".translateLanguage,
                          value: date,
                        ),
                      ),
                      BottomCardInfo(
                        cardInfoParam: (
                          key: "transaction-direction".translateLanguage,
                          value: type.title,
                        ),
                      ),
                      BottomCardInfo(
                        cardInfoParam: (
                          key: "transaction-narration".translateLanguage,
                          value: narration,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: context.getMediumPaddingSize(),
                        ),
                        child: const Divider(thickness: 1.0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
