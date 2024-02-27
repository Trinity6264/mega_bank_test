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

import "package:bank/authentication/error/authentication_exception.dart";

class PasswordResetException extends AuthenticationException {
  const PasswordResetException([super.message]);

  /// [PasswordResetException.fromCode] is a factory constructor that returns a [PasswordResetException] object
  /// based on the [code] passed to it.
  /// The [code] is a string that is returned by the Firebase Authentication API
  /// when an error occurs.
  /// The [code] is used to determine the type of error that occurred.
  /// The [code] is passed to the [PasswordResetException.fromCode] factory constructor
  /// which returns a [PasswordResetException] object.
  /// The [PasswordResetException.fromCode] factory constructor uses a [switch] statement
  /// to determine the type of error that occurred and returns the appropriate [PasswordResetException] object.
  /// If the [code] is not recognized, the [PasswordResetException.fromCode] factory constructor
  /// returns a generic [PasswordResetException] object with no message.
  /// The [PasswordResetException.fromCode] factory constructor is marked as `const`
  factory PasswordResetException.fromCode(String code) {
    return switch (code) {
      "expired-action-code" => const PasswordResetException(
          "The code provided has expired, request a new one",
        ),
      "invalid-action-code" => const PasswordResetException(
          "The code provided is invalid, please enter the valid code sent to you",
        ),
      "user-disabled" => const PasswordResetException(
          "You have been ban from using for performing this action, contact the customer care",
        ),
      "user-not-found" => const PasswordResetException(
          "The user has been deleted from our system, please contact our customer care",
        ),
      "weak-password" => const PasswordResetException(
          "The password provided is weak, provide a strong password",
        ),
      "network-request-failed" => const PasswordResetException(
          "Network failed, please check your network connection",
        ),
      String() => const PasswordResetException(),
    };
  }
}
