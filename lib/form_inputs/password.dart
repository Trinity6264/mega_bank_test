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

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure("");

  const Password.dirty({String value = ""}) : super.dirty(value);

  @override
  PasswordValidationError? validator(String? value) {
    if (value == null || value.isEmpty) {
      return PasswordValidationError.empty;
    }

    if (!value.contains(RegExp("[a-z]"))) {
      return PasswordValidationError.containsLower;
    }

    if (!value.contains(RegExp("[A-Z]"))) {
      return PasswordValidationError.containsUpper;
    }

    if (!value.contains(RegExp(r"\d"))) {
      return PasswordValidationError.containsDigit;
    }
    if (value.length <= 5) {
      return PasswordValidationError.greaterThanFive;
    }

    return null;
  }
}

enum PasswordValidationError {
  greaterThanFive("Password must be at least 8 characters long."),
  containsLower("Password must contain at least one lowercase letter."),
  containsUpper("Password must contain at least one uppercase letter."),
  containsDigit("Password must contain at least one digit."),
  empty("Password cannot be empty");

  const PasswordValidationError(this.message);

  final String message;
}

class PasswordConverter implements JsonConverter<Password, String> {
  const PasswordConverter();

  @override
  Password fromJson(String json) {
    return Password.dirty(value: json);
  }

  @override
  String toJson(Password object) {
    return object.value;
  }
}
