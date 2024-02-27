// Copyright 2023 trinity
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

part of "data_bloc.dart";

typedef BeforeAfterTransaction = (double before, double after);

@freezed
sealed class DataState with _$DataState {
  const factory DataState.initial() = _Initial;
  const factory DataState.loading() = _Loading;

  const factory DataState.dataLoad({
    @Default(CustomTabType.all) CustomTabType selectedType,
    @Default(null) CustomerModel? user,
    @Default([]) List<TransactionModel> transactionData,
    @Default(10000) double balance,
    @Default((0, 0)) BeforeAfterTransaction beforeAfterTransaction,
    @Default([]) List<TransactionModel> homeData,
  }) = _DataLoaded;
  const factory DataState.error() = _Error;

  const DataState._();

  bool get isUserEmpty {
    if (this is _DataLoaded) {
      return (this as _DataLoaded).user == null;
    }
    return true;
  }

  double get userBalance {
    if (this is _DataLoaded) {
      return (this as _DataLoaded).balance;
    }
    return 0;
  }

  BeforeAfterTransaction get beforeAfterTransaction {
    if (this is _DataLoaded) {
      return (this as _DataLoaded).beforeAfterTransaction;
    }
    return (0, 0);
  }

  CustomTabType get selectType {
    if (this is _DataLoaded) {
      return (this as _DataLoaded).selectedType;
    }
    return CustomTabType.all;
  }

  CustomerModel? get user {
    if (this is _DataLoaded) {
      return (this as _DataLoaded).user;
    }
    return null;
  }

  List<TransactionModel> get transactionData {
    if (this is _DataLoaded) {
      return (this as _DataLoaded).transactionData;
    }
    return [];
  }

  bool get transactionDataEmpty {
    if (this is _DataLoaded) {
      return (this as _DataLoaded).transactionData.isEmpty;
    }
    return true;
  }

  List<TransactionModel> get homeData {
    if (this is _DataLoaded) {
      return (this as _DataLoaded).homeData;
    }
    return [];
  }
}
