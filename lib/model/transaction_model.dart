// To parse this JSON data, do
//
//     final transactionModel = transactionModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'package:shantika_cubit/model/payment_method_model.dart';
import 'package:shantika_cubit/model/promo_model.dart';
import 'package:shantika_cubit/model/user_model.dart';

import '../config/constant.dart';
import 'address_model.dart';
import 'guard_model.dart';

part 'transaction_model.g.dart';

@JsonSerializable()
class TransactionModel {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "guard_type")
  String? guardType;
  @JsonKey(name: "translated_status")
  String? translatedStatus;
  @JsonKey(name: "user_id")
  String? userId;
  @JsonKey(name: "payment_method_id")
  String? paymentMethodId;
  @JsonKey(name: "offline_payment_method_id")
  String? offlinePaymentMethodId;
  @JsonKey(name: "promo_claim_id")
  String? promoClaimId;
  @JsonKey(name: "payment_code")
  String? paymentCode;
  @JsonKey(name: "note")
  String? note;
  AddressModel? address;
  @JsonKey(name: "payment_receipt")
  String? paymentReceipt;
  @JsonKey(name: "discount_promo")
  int? discountPromo;
  @JsonKey(name: "admin_fee")
  int? adminFee;
  @JsonKey(name: "xendit_fee")
  int? xenditFee;
  @JsonKey(name: "pay_amount")
  int? payAmount;
  @JsonKey(name: "status", fromJson: transactionStatusFromString)
  TransactionStatus? status;
  @JsonKey(name: "expiry_time")
  DateTime? expiryTime;
  @JsonKey(name: "xendit_id")
  String? xenditId;
  @JsonKey(name: "payment_link")
  String? paymentLink;
  @JsonKey(name: "deleted_at")
  dynamic deletedAt;
  @JsonKey(name: "created_at")
  DateTime? createdAt;
  @JsonKey(name: "updated_at")
  DateTime? updatedAt;
  @JsonKey(name: "user")
  UserModel? user;
  @JsonKey(name: "promo_claim")
  PromoModel? promoClaim;

  PaymentMethodModel? paymentMethod;
  @JsonKey(name: "offline_payment_method")
  OfflinePaymentMethodModel? offlinePaymentMethod;
  @JsonKey(name: "guard_history")
  GuardModel? guardHistory;

  @JsonKey(name: "start_time")
  String? startTime;
  @JsonKey(name: "end_time")
  String? endTime;

  TransactionModel({
    this.id,
    this.guardType,
    this.createdAt,
    this.paymentCode,
    this.status,
    this.translatedStatus,
    this.address,
    this.startTime,
    this.endTime,
    this.payAmount,
    this.expiryTime,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) => _$TransactionModelFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionModelToJson(this);
}
