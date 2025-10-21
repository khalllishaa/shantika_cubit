import 'package:json_annotation/json_annotation.dart';
part 'payment_method_model.g.dart';

@JsonSerializable()
class PaymentMethodModel {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "sub_name")
  String? subName;
  @JsonKey(name: "type")
  String? type;
  @JsonKey(name: "is_active")
  bool? isActive;
  @JsonKey(name: "deleted_at")
  dynamic deletedAt;
  @JsonKey(name: "created_at")
  DateTime? createdAt;
  @JsonKey(name: "updated_at")
  DateTime? updatedAt;

  PaymentMethodModel({
    this.id,
    this.name,
    this.subName,
    this.type,
    this.isActive,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) => _$PaymentMethodModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentMethodModelToJson(this);
}

@JsonSerializable()
class OfflinePaymentMethodModel {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "owner")
  String? owner;
  @JsonKey(name: "bank_account")
  String? bankAccount;
  @JsonKey(name: "bank_account_number")
  String? bankAccountNumber;
  @JsonKey(name: "deleted_at")
  dynamic deletedAt;
  @JsonKey(name: "created_at")
  DateTime? createdAt;
  @JsonKey(name: "updated_at")
  DateTime? updatedAt;
  @JsonKey(name: "translated_bank_account")
  String? translatedBankAccount;
  @JsonKey(name: "thumbnail")
  String? thumbnail;

  OfflinePaymentMethodModel({
    this.id,
    this.owner,
    this.bankAccount,
    this.bankAccountNumber,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.translatedBankAccount,
    this.thumbnail,
  });

  factory OfflinePaymentMethodModel.fromJson(Map<String, dynamic> json) => _$OfflinePaymentMethodModelFromJson(json);

  Map<String, dynamic> toJson() => _$OfflinePaymentMethodModelToJson(this);
}
