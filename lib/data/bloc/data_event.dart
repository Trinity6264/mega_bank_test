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

@freezed
class DataEvent with _$DataEvent {
  const factory DataEvent.onLoadedData() = _LoadedData;
  const factory DataEvent.onLoadedCloudData({required String id}) =
      _LoadedCloudData;
  const factory DataEvent.onCheckedBalancedata({
    required num amount,
    required TransactionType transactionType,
  }) = _CheckedBalance;
  const factory DataEvent.onLoadedAllData() = _LoadedAllData;
  const factory DataEvent.onLoadedDebitData() = _LoadedDebitData;
  const factory DataEvent.onLoadedCreditData() = _LoadedCreditData;
  const factory DataEvent.onCheckedTransactionBalance({
    required TransactionModel transactionModel,
  }) = _CheckedTransactionBalance;
}
