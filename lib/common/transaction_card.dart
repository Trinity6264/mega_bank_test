import "package:bank/common/constant.dart";
import "package:bank/common/currency_symbol_cycle.dart";
import "package:bank/common/transaction_card_detail.dart";
import "package:bank/data/bloc/data_bloc.dart";
import "package:bank/extension/translation_extentions.dart";
import "package:bank/transactions/model/transaction_model.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class TransactionCard extends StatelessWidget {
  const TransactionCard({
    required this.transactionModel,
    super.key,
  });
  final TransactionModel transactionModel;

  void _showDraggableBottomSheet(
    BuildContext context,
    TransactionModel transactionModel,
  ) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          minChildSize: 0.3,
          maxChildSize: 0.9,
          expand: false,
          builder: (BuildContext context, ScrollController scrollController) {
            return TransactionCardDetail(
              controller: scrollController,
              transactionModel: transactionModel,
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final TransactionModel(:amount, :date, :narration, :type) =
        transactionModel;
    return GestureDetector(
      onTap: () {
        context.read<DataBloc>().add(
              DataEvent.onCheckedTransactionBalance(
                transactionModel: transactionModel,
              ),
            );
        _showDraggableBottomSheet(context, transactionModel);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: const Color(0xFFE1E6F0).withOpacity(0.6),
              width: 1.5,
            ),
          ),
        ),
        padding: EdgeInsets.all(context.getMediumPaddingSize()),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CurrencyCircleSymbol(transactionType: type),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "GHC $amount",
                        style: TextStyle(
                          color: const Color(0xff212121),
                          fontWeight: FontWeight.w700,
                          fontSize: context.getNameTextFontSize(),
                        ),
                      ),
                      SizedBox(width: context.getSmallPaddingSize()),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 9,
                          vertical: 6,
                        ),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.26),
                          color: type.bgColor,
                        ),
                        child: Text(
                          type.title == "Credit"
                              ? "credit".translateLanguage
                              : "debit".translateLanguage,
                          style: TextStyle(
                            color: type.color,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: context.getSmallPaddingSize(),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "#",
                          style: TextStyle(
                            color: type.color,
                            letterSpacing: 0.175,
                            fontWeight: FontWeight.w700,
                            fontSize: context.getBodySmallFontSize(),
                          ),
                        ),
                        Text(
                          narration == "Deposit"
                              ? "deposit".translateLanguage
                              : narration == "Withdrawal"
                                  ? "withdrawal".translateLanguage
                                  : narration == "Inflow"
                                      ? "inflow".translateLanguage
                                      : "gift".translateLanguage,
                          style: TextStyle(
                            color: const Color(0xff616161),
                            letterSpacing: 0.175,
                            fontWeight: FontWeight.w400,
                            fontSize: context.getBodySmallFontSize(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Text(
                  date,
                  style: TextStyle(
                    fontSize: context.getBodySmallFontSize(),
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff616161),
                    letterSpacing: 0.175,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
