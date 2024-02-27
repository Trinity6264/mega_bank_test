import "package:auto_route/auto_route.dart";
import "package:bank/common/constant.dart";
import "package:bank/common/transaction_card.dart";
import "package:bank/data/bloc/data_bloc.dart";
import "package:bank/home/components/loading_widget.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

@RoutePage()
class SeeAllTransactionsPage extends StatelessWidget {
  const SeeAllTransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: context.primaryColor,
        title: const Text("All Transactions"),
      ),
      body: BlocBuilder<DataBloc, DataState>(
        builder: (context, state) {
          return state.when(
            initial: () {
              return Center(
                child: LoadingWidget(
                  onLoad: () {
                    context
                        .read<DataBloc>()
                        .add(const DataEvent.onLoadedData());
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
            dataLoad: (selectedType, user, transactionData, _, ___, homeData) {
              return CustomScrollView(
                slivers: [
                  SliverAnimatedList(
                    initialItemCount: homeData.length,
                    itemBuilder: (context, index, animation) {
                      final model = homeData[index];
                      return TransactionCard(transactionModel: model);
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
    );
  }
}
