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

class RegisterException extends AuthenticationException {
  const RegisterException([super.message]);

  /// [RegisterException.fromCode] is a factory constructor that returns a [RegisterException] object
  /// based on the [code] passed to it.
  /// The [code] is a string that is returned by the Firebase Authentication API
  /// when an error occurs.
  /// The [code] is used to determine the type of error that occurred.
  /// The [code] is passed to the [RegisterException.fromCode] factory constructor
  /// which returns a [RegisterException] object.
  /// The [RegisterException.fromCode] factory constructor uses a [switch] statement
  /// to determine the type of error that occurred and returns the appropriate [RegisterException] object.
  /// If the [code] is not recognized, the [RegisterException.fromCode] factory constructor
  /// returns a generic [RegisterException] object with no message.
  /// The [RegisterException.fromCode] factory constructor is marked as `const` so that
  factory RegisterException.fromCode(String code) {
    return switch (code) {
      "email-already-in-use" => const RegisterException(
          "The email provided is in our database, please login or reset your password if needed",
        ),
      "invalid-email" => const RegisterException(
          "The email provided is invalid",
        ),
      "operation-not-allowed" => const RegisterException(
          "Operation failed, This is our fault and we are working on fixing it",
        ),
      "weak-password" => const RegisterException(
          "The password provided is weak, provide a strong password",
        ),
      "network-request-failed" => const RegisterException(
          "Network failed, please check your network connection",
        ),
      String() => const RegisterException(),
    };
  }
}
