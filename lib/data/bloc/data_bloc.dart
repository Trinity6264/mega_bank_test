import "package:bank/bank_observer.dart";
import "package:bank/customer/model/customer_model.dart";
import "package:bank/data/repository/data_repository.dart";
import "package:bank/enums/tab_type.dart";
import "package:bank/enums/transaction_type.dart";
import "package:bank/transactions/model/transaction_model.dart";
import "package:bloc/bloc.dart";
import "package:bloc_concurrency/bloc_concurrency.dart";
import "package:freezed_annotation/freezed_annotation.dart";

part "data_bloc.freezed.dart";
part "data_event.dart";
part "data_state.dart";

class DataBloc extends Bloc<DataEvent, DataState> {
  DataBloc(this.repository) : super(const DataState.initial()) {
    on<_LoadedCloudData>(_onLoadedCloudData);
    on<_LoadedData>(_onDataLoad, transformer: droppable());
    on<_LoadedAllData>(_onLoadAllData, transformer: restartable());
    on<_LoadedDebitData>(_onLoadDebitData, transformer: restartable());
    on<_LoadedCreditData>(_onLoadCreditData, transformer: restartable());
    on<_CheckedBalance>(_onCheckBalanceData, transformer: sequential());
    on<_CheckedTransactionBalance>(
      _onCheckedTransactionBalance,
    );
  }
  final DataRepository repository;

  Future<void> _onLoadedCloudData(
    _LoadedCloudData event,
    Emitter<DataState> emit,
  ) async {
    await emit.forEach(
      repository.loadUserData(id: event.id),
      onData: (data) {
        final docs = data.data();
        if (docs == null) {
          return state;
        }
        for (final element in docs.transaction) {
          add(
            _CheckedBalance(
              amount: element.amount,
              transactionType: element.type,
            ),
          );
        }
        return DataState.dataLoad(
          homeData: docs.transaction,
          transactionData: docs.transaction,
          user: docs.user,
        );
      },
      onError: (error, stackTrace) {
        logger.e(error);
        return state;
      },
    );
  }

  Future<void> _onDataLoad(
    _LoadedData event,
    Emitter<DataState> emit,
  ) async {
    try {
      await Future.delayed(const Duration(seconds: 2), () {});
      final resp = await repository.loadJsonData();

      resp.when(
        (data) {
          for (final element in data.transaction) {
            add(
              _CheckedBalance(
                amount: element.amount,
                transactionType: element.type,
              ),
            );
          }
          emit(
            DataState.dataLoad(
              homeData: data.transaction,
              transactionData: data.transaction,
              user: data.user,
            ),
          );
        },
        (_) => logger.e("Something happend"),
      );
    } catch (e) {
      logger.e(e);
    }
  }

  Future<void> _onLoadDebitData(
    _LoadedDebitData event,
    Emitter<DataState> emit,
  ) async {
    if (state.isUserEmpty) return;

    Iterable<TransactionModel> filteredList = <TransactionModel>[];

    filteredList = state.homeData
        .where((element) => element.type == TransactionType.debit);

    emit(
      DataState.dataLoad(
        homeData: state.homeData,
        selectedType: CustomTabType.debit,
        transactionData: filteredList.toList(),
        user: state.user,
        balance: state.userBalance,
      ),
    );
  }

  Future<void> _onLoadCreditData(
    _LoadedCreditData event,
    Emitter<DataState> emit,
  ) async {
    if (state.isUserEmpty) return;
    Iterable<TransactionModel> filteredList = <TransactionModel>[];

    filteredList = state.homeData
        .where((element) => element.type == TransactionType.credit);
    emit(
      DataState.dataLoad(
        homeData: state.homeData,
        selectedType: CustomTabType.credit,
        transactionData: filteredList.toList(),
        user: state.user,
        balance: state.userBalance,
      ),
    );
  }

  Future<void> _onLoadAllData(
    _LoadedAllData event,
    Emitter<DataState> emit,
  ) async {
    if (state.isUserEmpty) return;
    final filteredList = List<TransactionModel>.of(state.homeData);

    emit(
      DataState.dataLoad(
        homeData: state.homeData,
        transactionData: filteredList,
        user: state.user,
        balance: state.userBalance,
      ),
    );
  }

  Future<void> _onCheckedTransactionBalance(
    _CheckedTransactionBalance event,
    Emitter<DataState> emit,
  ) async {
    if (state.isUserEmpty) return;
    final filteredList = List<TransactionModel>.of(state.homeData);

    var balanceBefore = 10000.00;
    var balanceAfter = 0.0;

    for (final transaction in filteredList) {
      if (transaction == event.transactionModel) {
        logger.i(transaction);
        balanceAfter = balanceBefore;
        if (transaction.type == TransactionType.credit) {
          balanceAfter -= transaction.amount;
          break;
        }
        balanceAfter += transaction.amount;

        break;
      }
      if (transaction.type == TransactionType.credit) {
        balanceBefore += transaction.amount;
      } else {
        balanceBefore -= transaction.amount;
      }
    }
    emit(
      DataState.dataLoad(
        homeData: state.homeData,
        transactionData: filteredList,
        user: state.user,
        balance: state.userBalance,
        selectedType: state.selectType,
        beforeAfterTransaction: (balanceBefore, balanceAfter),
      ),
    );
  }

  Future<void> _onCheckBalanceData(
    _CheckedBalance event,
    Emitter<DataState> emit,
  ) async {
    if (event.transactionType == TransactionType.credit) {
      emit(
        DataState.dataLoad(
          homeData: state.homeData,
          transactionData: state.transactionData,
          user: state.user,
          balance: state.userBalance + event.amount,
        ),
      );
      return;
    }

    emit(
      DataState.dataLoad(
        homeData: state.homeData,
        transactionData: state.transactionData,
        user: state.user,
        balance: state.userBalance - event.amount,
      ),
    );
  }
}
