// To parse this JSON data, do
//
//     final TransactionDetailModel = TransactionDetailModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'package:shantika_cubit/model/payment_method_model.dart';
import 'package:shantika_cubit/model/promo_model.dart';
import 'package:shantika_cubit/model/user_model.dart';

import '../config/constant.dart';
import 'address_model.dart';
import 'guard_history_equipment_support_model.dart';
import 'guard_model.dart';
import 'guard_type_model.dart';

part 'transaction_detail_model.g.dart';

@JsonSerializable()
class TransactionDetailModel {
  @JsonKey(name: "id")
  String? id;
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
  @JsonKey(name: "payment_receipt")
  dynamic paymentReceipt;
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
  @JsonKey(name: "translated_status")
  String? translatedStatus;
  @JsonKey(name: "user")
  UserModel? user;
  @JsonKey(name: "promo_claim")
  PromoModel? promoClaim;
  @JsonKey(name: "sub_total")
  int? subTotal;
  @JsonKey(name: "payment_method")
  PaymentMethodModel? paymentMethod;
  @JsonKey(name: "offline_payment_method")
  OfflinePaymentMethodModel? offlinePaymentMethod;
  @JsonKey(name: "guard_history")
  GuardHistoryModel? guardHistory;

  TransactionDetailModel({
    this.id,
    this.userId,
    this.paymentMethodId,
    this.offlinePaymentMethodId,
    this.promoClaimId,
    this.paymentCode,
    this.note,
    this.paymentReceipt,
    this.discountPromo,
    this.adminFee,
    this.xenditFee,
    this.payAmount,
    this.status,
    this.expiryTime,
    this.xenditId,
    this.paymentLink,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.translatedStatus,
    this.user,
    this.promoClaim,
    this.paymentMethod,
    this.offlinePaymentMethod,
    this.guardHistory,
  });

  factory TransactionDetailModel.fromJson(Map<String, dynamic> json) => _$TransactionDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionDetailModelToJson(this);
}

@JsonSerializable()
class GuardHistoryModel {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "user_id")
  String? userId;
  @JsonKey(name: "transaction_id")
  String? transactionId;
  @JsonKey(name: "user_address_id")
  String? userAddressId;
  @JsonKey(name: "guard_type_id")
  String? guardTypeId;
  @JsonKey(name: "guard_class_id")
  String? guardClassId;
  @JsonKey(name: "event_name")
  dynamic eventName;
  @JsonKey(name: "pic_name")
  dynamic picName;
  @JsonKey(name: "phone")
  dynamic phone;
  @JsonKey(name: "start_time")
  DateTime? startTime;
  @JsonKey(name: "end_time")
  DateTime? endTime;
  @JsonKey(name: "is_guard_recommendation")
  bool? isGuardRecommendation;
  @JsonKey(name: "number_of_guard")
  int? numberOfGuard;
  @JsonKey(name: "is_technical_meeting")
  bool? isTechnicalMeeting;
  @JsonKey(name: "is_includes_meals")
  bool? isIncludesMeals;
  @JsonKey(name: "security_objectives")
  String? securityObjectives;
  @JsonKey(name: "status", fromJson: assignmentHistoryStatusFromString)
  AssignmentHistoryStatus? status;
  @JsonKey(name: "deleted_at")
  dynamic deletedAt;
  @JsonKey(name: "created_at")
  DateTime? createdAt;
  @JsonKey(name: "updated_at")
  DateTime? updatedAt;
  @JsonKey(name: "translated_status")
  String? translatedStatus;
  @JsonKey(name: "user_address")
  AddressModel? userAddress;
  @JsonKey(name: "guard_type")
  GuardTypeModel? guardType;
  @JsonKey(name: "guard_class")
  GuardClassModel? guardClass;
  @JsonKey(name: "guard_history_officers")
  List<GuardModel>? guardHistoryOfficers;
  @JsonKey(name: "guard_history_equipment_supports")
  List<GuardHistoryEquipmentSupportModel>? guardHistoryEquipmentSupports;

  GuardHistoryModel({
    this.id,
    this.userId,
    this.transactionId,
    this.userAddressId,
    this.guardTypeId,
    this.guardClassId,
    this.eventName,
    this.picName,
    this.phone,
    this.startTime,
    this.endTime,
    this.isGuardRecommendation,
    this.numberOfGuard,
    this.isTechnicalMeeting,
    this.isIncludesMeals,
    this.securityObjectives,
    this.status,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.translatedStatus,
    this.userAddress,
    this.guardType,
    this.guardClass,
    this.guardHistoryOfficers,
    this.guardHistoryEquipmentSupports,
  });

  factory GuardHistoryModel.fromJson(Map<String, dynamic> json) => _$GuardHistoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$GuardHistoryModelToJson(this);
}
