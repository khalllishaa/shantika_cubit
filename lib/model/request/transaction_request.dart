// To parse this JSON data, do
//
//     final transactionRequest = transactionRequestFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

import '../equipment_support_model.dart';
import '../guard_model.dart';
import '../user_model.dart';

part 'transaction_request.g.dart';

TransactionRequest transactionRequestFromJson(String str) => TransactionRequest.fromJson(json.decode(str));

String transactionRequestToJson(TransactionRequest data) => json.encode(data.toJson());

@JsonSerializable()
class TransactionRequest {
  @JsonKey(name: "promo_claim_id")
  String? promoClaimId;
  @JsonKey(name: "discount_promo")
  int? discountPromo;
  @JsonKey(name: "admin_fee")
  int? adminFee;
  @JsonKey(name: "xendit_fee")
  int? xenditFee;
  @JsonKey(name: "pay_amount")
  int? payAmount;
  @JsonKey(name: "payment_method_id")
  String? paymentMethodId;
  @JsonKey(name: "offline_payment_method_id")
  dynamic offlinePaymentMethodId;
  @JsonKey(name: "programs")
  List<Program>? programs;

  TransactionRequest({
    this.promoClaimId,
    this.discountPromo,
    this.adminFee,
    this.xenditFee,
    this.payAmount,
    this.paymentMethodId,
    this.offlinePaymentMethodId,
    this.programs,
  });

  factory TransactionRequest.fromJson(Map<String, dynamic> json) => _$TransactionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionRequestToJson(this);
}

@JsonSerializable()
class Program {
  @JsonKey(name: "guard_type_id")
  String? guardTypeId;
  @JsonKey(name: "type")
  String? type;
  @JsonKey(name: "start_time")
  String? startTime;
  @JsonKey(name: "end_time")
  String? endTime;
  @JsonKey(name: "note")
  String? note;
  @JsonKey(name: "user")
  UserModel? user;
  @JsonKey(name: "guard")
  GuardModel? guard;
  @JsonKey(name: "equipment_supports")
  List<EquipmentSupportModel>? equipmentSupports;

  Program({
    this.guardTypeId,
    this.type,
    this.startTime,
    this.endTime,
    this.note,
    this.user,
    this.guard,
    this.equipmentSupports,
  });

  factory Program.fromJson(Map<String, dynamic> json) => _$ProgramFromJson(json);

  Map<String, dynamic> toJson() => _$ProgramToJson(this);
}
