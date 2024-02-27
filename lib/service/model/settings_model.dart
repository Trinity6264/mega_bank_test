import "package:freezed_annotation/freezed_annotation.dart";
import "package:hive_flutter/hive_flutter.dart";

part "settings_model.freezed.dart";
part "settings_model.g.dart";

@freezed
@HiveType(typeId: 0)
class SettingsModel extends HiveObject with _$SettingsModel {
  factory SettingsModel({
    @HiveField(0) required String language,
  }) = _SettingsModel;
  SettingsModel._();

  factory SettingsModel.fromJson(Map<String, dynamic> json) =>
      _$SettingsModelFromJson(json);
}
