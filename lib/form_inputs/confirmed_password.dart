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

class ConfirmedPassword
    extends FormzInput<String, ConfirmedPasswordValidationError> {
  const ConfirmedPassword.pure({this.originalPassword = ""}) : super.pure("");

  const ConfirmedPassword.dirty({
    required this.originalPassword,
    String value = "",
  }) : super.dirty(value);

  final String originalPassword;

  @override
  ConfirmedPasswordValidationError? validator(String? value) {
    if (value == null || value.isEmpty) {
      return ConfirmedPasswordValidationError.empty;
    }

    if (!value.contains(RegExp("[a-z]"))) {
      return ConfirmedPasswordValidationError.containsLower;
    }

    if (!value.contains(RegExp("[A-Z]"))) {
      return ConfirmedPasswordValidationError.containsUpper;
    }

    if (!value.contains(RegExp(r"\d"))) {
      return ConfirmedPasswordValidationError.containsDigit;
    }
    if (value != originalPassword) {
      return ConfirmedPasswordValidationError.doesNotMuch;
    }
    if (value.length <= 5) {
      return ConfirmedPasswordValidationError.greaterThanFive;
    }

    return null;
  }
}

enum ConfirmedPasswordValidationError {
  greaterThanFive("Password must be at least 8 characters long."),
  containsLower("Password must contain at least one lowercase letter."),
  containsUpper("Password must contain at least one uppercase letter."),
  containsDigit("Password must contain at least one digit."),
  doesNotMuch("Passwords don't match"),
  empty("Password cannot be empty");

  const ConfirmedPasswordValidationError(this.message);

  final String message;
}
