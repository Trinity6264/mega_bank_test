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

import "package:bank/common/utils.dart";
import "package:bank/local_user/local_user.dart";
import "package:bank/service/form_validation.dart";
import "package:get_it/get_it.dart";

final getIt = GetIt.I;

void setupServiceLocator() {
  getIt
    ..registerLazySingleton<Utils>(Utils.new)
    ..registerLazySingleton<LocalUser>(LocalUser.new)
    ..registerLazySingleton<FormValidation>(FormValidation.new);
}
