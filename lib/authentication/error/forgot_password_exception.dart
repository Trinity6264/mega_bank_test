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

class ForgotPasswordException extends AuthenticationException {
  const ForgotPasswordException([super.message]);

  ///
  ///

  /// [ForgotPasswordException.fromCode] is a factory constructor that returns a [ForgotPasswordException] object
  /// based on the [code] passed to it.
  /// The [code] is a string that is returned by the Firebase Authentication API
  /// when an error occurs.
  /// The [code] is used to determine the type of error that occurred.
  /// The [code] is passed to the [ForgotPasswordException.fromCode] factory constructor
  /// which returns a [ForgotPasswordException] object.
  /// The [ForgotPasswordException.fromCode] factory constructor uses a [switch] statement
  /// to determine the type of error that occurred and returns the appropriate [ForgotPasswordException] object.
  /// If the [code] is not recognized, the [ForgotPasswordException.fromCode] factory constructor
  /// returns a generic [ForgotPasswordException] object with no message.
  /// The [ForgotPasswordException.fromCode] factory constructor is marked as `const` so that
  factory ForgotPasswordException.fromCode(String code) {
    return switch (code) {
      "invalid-email" => const ForgotPasswordException(
          "Invalid Email address",
        ),
      "missing-android-pkg-name" => const ForgotPasswordException(
          "We are sorry, This is our fault and we are working on fixing it",
        ),
      "missing-continue-uri" => const ForgotPasswordException(
          "The continue url is missing, This is our fault and we are working on fixing it",
        ),
      "missing-ios-bundle-id" => const ForgotPasswordException(
          "The ios bundle is need, This is our fault and we are working on fixing it",
        ),
      "invalid-continue-uri" => const ForgotPasswordException(
          "The url provided is invalid, This is our fault and we are working on fixing it",
        ),
      "unauthorized-continue-uri" => const ForgotPasswordException(
          "Your domain url is unauthorized, This is our fault and we are working on fixing it",
        ),
      "user-not-found" => const ForgotPasswordException(
          "The email provided was not found in the system",
        ),
      "network-request-failed" => const ForgotPasswordException(
          "Network failed, please check your network connection",
        ),
      String() => const ForgotPasswordException(),
    };
  }
}
