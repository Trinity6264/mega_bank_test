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

import "package:rxdart/rxdart.dart";

class FormValidation {
  FormValidation();

  final _signUpForm = BehaviorSubject<bool>.seeded(false);
  bool get signUpFormState => _signUpForm.hasValue && _signUpForm.value;

  void updateSignUpForm(bool value) {
    _signUpForm.add(value);
  }

  final _loginForm = BehaviorSubject<bool>.seeded(false);
  bool get loginFormState => _loginForm.hasValue && _loginForm.value;

  void updateLoginForm(bool value) {
    _loginForm.add(value);
  }

  final _verifyForm = BehaviorSubject<bool>.seeded(false);
  bool get verifyFormState => _verifyForm.hasValue && _verifyForm.value;

  void verifyForm(bool value) {
    _verifyForm.add(value);
  }
}
