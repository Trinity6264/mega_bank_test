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

import "package:bank/authentication/error/login_exception.dart";
import "package:bank/authentication/error/password_reset_exception.dart";
import "package:bank/authentication/error/register_exception.dart";
import "package:bank/bank_observer.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:multiple_result/multiple_result.dart";

class AuthenticationRepository {
  const AuthenticationRepository({
    required FirebaseAuth firebaseAuth,
  }) : _firebaseAuth = firebaseAuth;

  final FirebaseAuth _firebaseAuth;

  //? Login

  Future<Result<User, String>> login({
    required String email,
    required String password,
  }) async {
    try {
      final resp = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = resp.user;
      if (user != null) {
        return Result.success(user);
      }
      return Result.error(const LoginException().message);
    } on FirebaseAuthException catch (e) {
      logger.e(e, stackTrace: e.stackTrace);
      return Result.error(LoginException.fromCode(e.code).message);
    } catch (e) {
      logger.e(e);
      return const Result.error("Internal server error");
    }
  }

  Future<Result<User, String>> createAccount({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final resp = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = resp.user;
      if (user != null) {
        await resp.user?.updateDisplayName(name);

        return Result.success(user);
      }
      return Result.error(const RegisterException().message);
    } on FirebaseAuthException catch (e) {
      logger.e(e, stackTrace: e.stackTrace);
      return Result.error(RegisterException.fromCode(e.code).message);
    } catch (e) {
      return const Result.error("Internal server error");
    }
  }

  //? Reset apassword

  Future<Result<void, String>> changePassword({
    required String code,
    required String newPassword,
  }) async {
    try {
      await _firebaseAuth.confirmPasswordReset(
        code: code,
        newPassword: newPassword,
      );

      return const Result.success(null);
    } on FirebaseAuthException catch (e) {
      logger.e(e, stackTrace: e.stackTrace);
      return Result.error(PasswordResetException.fromCode(e.code).message);
    } catch (e) {
      return const Result.error("Internal server error");
    }
  }

  //? Reset apassword
  Future<Result<void, String>> forgotPassword({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return const Result.success(null);
    } on FirebaseAuthException catch (e) {
      logger.e(e, stackTrace: e.stackTrace);
      return Result.error(PasswordResetException.fromCode(e.code).message);
    } catch (e) {
      return const Result.error("Internal server error");
    }
  }

  Stream<User?> get getUser => _firebaseAuth.authStateChanges();
}
