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

import "package:bank/authentication/repository/authentication_repository.dart";
import "package:bank/form_inputs/email.dart";
import "package:bank/login/bloc/login_bloc.dart";
import "package:bloc_test/bloc_test.dart";
import "package:flutter_test/flutter_test.dart";
import "package:mockito/annotations.dart";

import "login_bloc_test.mocks.dart";

@GenerateNiceMocks([MockSpec<AuthenticationRepository>()])
void main() {
  // test("test name", () {});
  late MockAuthenticationRepository authenticationRepository;

  setUp(() {
    authenticationRepository = MockAuthenticationRepository();
  });

  group("Login Bloc Test", () {
    blocTest<LoginBloc, LoginState>(
      "Checking the initial state of the login when login bloc is created",
      build: () => LoginBloc(
        authenticationRepository: authenticationRepository,
      ),
      expect: () => const <LoginState>[],
    );

    blocTest<LoginBloc, LoginState>(
      "Checking the state of the login bloc when email field changes",
      build: () => LoginBloc(
        authenticationRepository: authenticationRepository,
      ),
      act: (bloc) {
        bloc.add(const LoginEvent.onEmailChanged(value: "value"));
      },
      expect: () => const <LoginState>[
        LoginState.stateChanged(email: Email.dirty(value: "value")),
      ],
    );
  });
}
