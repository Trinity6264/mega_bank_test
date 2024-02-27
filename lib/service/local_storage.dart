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

import "package:bank/bank_observer.dart";
import "package:bank/service/model/settings_model.dart";
import "package:hive_flutter/hive_flutter.dart";
import "package:rxdart/rxdart.dart";

class LocalStorage {
  const LocalStorage();
  static final _settingsSubject = BehaviorSubject<SettingsModel>();
  Stream<SettingsModel> get settingsSubject => _settingsSubject.stream;

  static const String _settingsKey = "settings";
  static Box<SettingsModel> settingsBox = Hive.box<SettingsModel>(_settingsKey);

  static Future<void> openBoxes() async {
    await Hive.openBox<SettingsModel>(_settingsKey);
  }

  static SettingsModel? getSettings() {
    final resp = settingsBox.get("setting");
    if (resp != null) {
      _settingsSubject.add(resp);
      return resp;
    }
    return null;
  }

  static void saveLanguageSettings(String language) {
    try {
      final settings = getSettings();
      if (settings != null) {
        var settings = settingsBox.get("setting");
        settings = settings?.copyWith(language: language);
        _settingsSubject.add(settings!);
        settingsBox.put("setting", SettingsModel(language: language));
      }
    } catch (e) {
      logger.e(e);
    }
  }
}
