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

import "dart:collection";

import "package:bank/profile/model/language_model.dart";

class ProfileRepository {
  const ProfileRepository();

  static final List<LanguageModel> _language = [
    LanguageModel(label: "English", code: "en"),
    LanguageModel(label: "Spanish", code: "es"),
    LanguageModel(label: "French", code: "fr"),
    LanguageModel(label: "Akan", code: "ak"),
  ];

  UnmodifiableListView<LanguageModel> get language =>
      UnmodifiableListView(_language);
}
