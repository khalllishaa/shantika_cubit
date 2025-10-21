// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionRequest _$TransactionRequestFromJson(Map<String, dynamic> json) =>
    TransactionRequest(
      promoClaimId: json['promo_claim_id'] as String?,
      discountPromo: (json['discount_promo'] as num?)?.toInt(),
      adminFee: (json['admin_fee'] as num?)?.toInt(),
      xenditFee: (json['xendit_fee'] as num?)?.toInt(),
      payAmount: (json['pay_amount'] as num?)?.toInt(),
      paymentMethodId: json['payment_method_id'] as String?,
      offlinePaymentMethodId: json['offline_payment_method_id'],
      programs: (json['programs'] as List<dynamic>?)
          ?.map((e) => Program.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TransactionRequestToJson(TransactionRequest instance) =>
    <String, dynamic>{
      'promo_claim_id': instance.promoClaimId,
      'discount_promo': instance.discountPromo,
      'admin_fee': instance.adminFee,
      'xendit_fee': instance.xenditFee,
      'pay_amount': instance.payAmount,
      'payment_method_id': instance.paymentMethodId,
      'offline_payment_method_id': instance.offlinePaymentMethodId,
      'programs': instance.programs,
    };

Program _$ProgramFromJson(Map<String, dynamic> json) => Program(
      guardTypeId: json['guard_type_id'] as String?,
      type: json['type'] as String?,
      startTime: json['start_time'] as String?,
      endTime: json['end_time'] as String?,
      note: json['note'] as String?,
      user: json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
      guard: json['guard'] == null
          ? null
          : GuardModel.fromJson(json['guard'] as Map<String, dynamic>),
      equipmentSupports: (json['equipment_supports'] as List<dynamic>?)
          ?.map(
              (e) => EquipmentSupportModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProgramToJson(Program instance) => <String, dynamic>{
      'guard_type_id': instance.guardTypeId,
      'type': instance.type,
      'start_time': instance.startTime,
      'end_time': instance.endTime,
      'note': instance.note,
      'user': instance.user,
      'guard': instance.guard,
      'equipment_supports': instance.equipmentSupports,
    };
