// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) =>
    TransactionModel(
      id: json['id'] as String?,
      guardType: json['guard_type'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      paymentCode: json['payment_code'] as String?,
      status: transactionStatusFromString(json['status'] as String?),
      translatedStatus: json['translated_status'] as String?,
      address: json['address'] == null
          ? null
          : AddressModel.fromJson(json['address'] as Map<String, dynamic>),
      startTime: json['start_time'] as String?,
      endTime: json['end_time'] as String?,
      payAmount: (json['pay_amount'] as num?)?.toInt(),
      expiryTime: json['expiry_time'] == null
          ? null
          : DateTime.parse(json['expiry_time'] as String),
    )
      ..userId = json['user_id'] as String?
      ..paymentMethodId = json['payment_method_id'] as String?
      ..offlinePaymentMethodId = json['offline_payment_method_id'] as String?
      ..promoClaimId = json['promo_claim_id'] as String?
      ..note = json['note'] as String?
      ..paymentReceipt = json['payment_receipt'] as String?
      ..discountPromo = (json['discount_promo'] as num?)?.toInt()
      ..adminFee = (json['admin_fee'] as num?)?.toInt()
      ..xenditFee = (json['xendit_fee'] as num?)?.toInt()
      ..xenditId = json['xendit_id'] as String?
      ..paymentLink = json['payment_link'] as String?
      ..deletedAt = json['deleted_at']
      ..updatedAt = json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String)
      ..user = json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>)
      ..promoClaim = json['promo_claim'] == null
          ? null
          : PromoModel.fromJson(json['promo_claim'] as Map<String, dynamic>)
      ..paymentMethod = json['paymentMethod'] == null
          ? null
          : PaymentMethodModel.fromJson(
              json['paymentMethod'] as Map<String, dynamic>)
      ..offlinePaymentMethod = json['offline_payment_method'] == null
          ? null
          : OfflinePaymentMethodModel.fromJson(
              json['offline_payment_method'] as Map<String, dynamic>)
      ..guardHistory = json['guard_history'] == null
          ? null
          : GuardModel.fromJson(json['guard_history'] as Map<String, dynamic>);

Map<String, dynamic> _$TransactionModelToJson(TransactionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'guard_type': instance.guardType,
      'translated_status': instance.translatedStatus,
      'user_id': instance.userId,
      'payment_method_id': instance.paymentMethodId,
      'offline_payment_method_id': instance.offlinePaymentMethodId,
      'promo_claim_id': instance.promoClaimId,
      'payment_code': instance.paymentCode,
      'note': instance.note,
      'address': instance.address,
      'payment_receipt': instance.paymentReceipt,
      'discount_promo': instance.discountPromo,
      'admin_fee': instance.adminFee,
      'xendit_fee': instance.xenditFee,
      'pay_amount': instance.payAmount,
      'status': _$TransactionStatusEnumMap[instance.status],
      'expiry_time': instance.expiryTime?.toIso8601String(),
      'xendit_id': instance.xenditId,
      'payment_link': instance.paymentLink,
      'deleted_at': instance.deletedAt,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'user': instance.user,
      'promo_claim': instance.promoClaim,
      'paymentMethod': instance.paymentMethod,
      'offline_payment_method': instance.offlinePaymentMethod,
      'guard_history': instance.guardHistory,
      'start_time': instance.startTime,
      'end_time': instance.endTime,
    };

const _$TransactionStatusEnumMap = {
  TransactionStatus.waiting: 'waiting',
  TransactionStatus.pending: 'pending',
  TransactionStatus.cancelled: 'cancelled',
  TransactionStatus.expired: 'expired',
  TransactionStatus.paid: 'paid',
};
