import "package:bank/enums/user_gender.dart";
import "package:freezed_annotation/freezed_annotation.dart";

part "customer_model.freezed.dart";
part "customer_model.g.dart";

@freezed
class CustomerModel with _$CustomerModel {
  factory CustomerModel({
    required String title,
    @JsonKey(name: "customerID") required String id,
    @JsonKey(name: "customerName") required String name,
    @Default(UserGender.male) UserGender gender,
  }) = _CustomerModel;

  factory CustomerModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerModelFromJson(json);
}
