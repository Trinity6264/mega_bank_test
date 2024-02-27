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

import "package:formz/formz.dart";
import "package:freezed_annotation/freezed_annotation.dart";

class Username extends FormzInput<String, UsernameValidationError> {
  const Username.pure() : super.pure("");

  const Username.dirty({String value = ""}) : super.dirty(value);

  @override
  UsernameValidationError? validator(String? value) {
    if (value == null || value.isEmpty) {
      return UsernameValidationError.empty;
    }
    if (value.length < 2) {
      return UsernameValidationError.greaterThanTwo;
    }
    return null;
  }
}

class UsernameConverter implements JsonConverter<Username, String> {
  const UsernameConverter();

  @override
  Username fromJson(String json) {
    return Username.dirty(value: json);
  }

  @override
  String toJson(Username object) {
    return object.value;
  }
}

enum UsernameValidationError {
  /// Generic invalid error.
  greaterThanTwo("Username must be greater than two"),
  empty("Username cannot be empty");

  const UsernameValidationError(this.message);

  final String message;
}
