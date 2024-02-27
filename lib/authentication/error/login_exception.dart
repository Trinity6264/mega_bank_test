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

class LoginException extends AuthenticationException {
  const LoginException([super.message]);

  factory LoginException.fromCode(String code) {
    return switch (code) {
      "account-exists-with-different-credential" => const LoginException(
          "There already exists an account with the same email address",
        ),
      "invalid-email" => const LoginException(
          "Invalid Email address",
        ),
      "invalid-credential" => const LoginException(
          "Credential is malformed or has expired",
        ),
      "operation-not-allowed" => const LoginException(
          "Account not enabled",
        ),
      "INVALID_LOGIN_CREDENTIALS" => const LoginException(
          "The login credentials is invalid",
        ),
      "user-disabled" => const LoginException(
          "User account disabled",
        ),
      "user-not-found" => const LoginException(
          "There is no user corresponding to the given email",
        ),
      "wrong-password" => const LoginException(
          "Password is invalid for the given email or no password set",
        ),
      "weak-password" => const LoginException(
          "The password provided is too weak",
        ),
      "invalid-verification-code" => const LoginException(
          "Invalid verification code",
        ),
      "invalid-verification-id" => const LoginException(
          "Invalid verification ID",
        ),
      "email-already-in-use" => const LoginException(
          "An account already exists for that email",
        ),
      "network-request-failed" => const LoginException(
          "Network failed, please check your network connection",
        ),
      String() => const LoginException(),
    };
  }
}
