// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionDetailModel _$TransactionDetailModelFromJson(
  Map<String, dynamic> json,
) => TransactionDetailModel(
  id: json['id'] as String?,
  userId: json['user_id'] as String?,
  paymentMethodId: json['payment_method_id'] as String?,
  offlinePaymentMethodId: json['offline_payment_method_id'] as String?,
  promoClaimId: json['promo_claim_id'] as String?,
  paymentCode: json['payment_code'] as String?,
  note: json['note'] as String?,
  paymentReceipt: json['payment_receipt'],
  discountPromo: (json['discount_promo'] as num?)?.toInt(),
  adminFee: (json['admin_fee'] as num?)?.toInt(),
  xenditFee: (json['xendit_fee'] as num?)?.toInt(),
  payAmount: (json['pay_amount'] as num?)?.toInt(),
  status: transactionStatusFromString(json['status'] as String?),
  expiryTime: json['expiry_time'] == null
      ? null
      : DateTime.parse(json['expiry_time'] as String),
  xenditId: json['xendit_id'] as String?,
  paymentLink: json['payment_link'] as String?,
  deletedAt: json['deleted_at'],
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
  translatedStatus: json['translated_status'] as String?,
  user: json['user'] == null
      ? null
      : UserModel.fromJson(json['user'] as Map<String, dynamic>),
  promoClaim: json['promo_claim'] == null
      ? null
      : PromoModel.fromJson(json['promo_claim'] as Map<String, dynamic>),
  paymentMethod: json['payment_method'] == null
      ? null
      : PaymentMethodModel.fromJson(
          json['payment_method'] as Map<String, dynamic>,
        ),
  offlinePaymentMethod: json['offline_payment_method'] == null
      ? null
      : OfflinePaymentMethodModel.fromJson(
          json['offline_payment_method'] as Map<String, dynamic>,
        ),
  guardHistory: json['guard_history'] == null
      ? null
      : GuardHistoryModel.fromJson(
          json['guard_history'] as Map<String, dynamic>,
        ),
)..subTotal = (json['sub_total'] as num?)?.toInt();

Map<String, dynamic> _$TransactionDetailModelToJson(
  TransactionDetailModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'user_id': instance.userId,
  'payment_method_id': instance.paymentMethodId,
  'offline_payment_method_id': instance.offlinePaymentMethodId,
  'promo_claim_id': instance.promoClaimId,
  'payment_code': instance.paymentCode,
  'note': instance.note,
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
  'translated_status': instance.translatedStatus,
  'user': instance.user,
  'promo_claim': instance.promoClaim,
  'sub_total': instance.subTotal,
  'payment_method': instance.paymentMethod,
  'offline_payment_method': instance.offlinePaymentMethod,
  'guard_history': instance.guardHistory,
};

const _$TransactionStatusEnumMap = {
  TransactionStatus.waiting: 'waiting',
  TransactionStatus.pending: 'pending',
  TransactionStatus.cancelled: 'cancelled',
  TransactionStatus.expired: 'expired',
  TransactionStatus.paid: 'paid',
};

GuardHistoryModel _$GuardHistoryModelFromJson(
  Map<String, dynamic> json,
) => GuardHistoryModel(
  id: json['id'] as String?,
  userId: json['user_id'] as String?,
  transactionId: json['transaction_id'] as String?,
  userAddressId: json['user_address_id'] as String?,
  guardTypeId: json['guard_type_id'] as String?,
  guardClassId: json['guard_class_id'] as String?,
  eventName: json['event_name'],
  picName: json['pic_name'],
  phone: json['phone'],
  startTime: json['start_time'] == null
      ? null
      : DateTime.parse(json['start_time'] as String),
  endTime: json['end_time'] == null
      ? null
      : DateTime.parse(json['end_time'] as String),
  isGuardRecommendation: json['is_guard_recommendation'] as bool?,
  numberOfGuard: (json['number_of_guard'] as num?)?.toInt(),
  isTechnicalMeeting: json['is_technical_meeting'] as bool?,
  isIncludesMeals: json['is_includes_meals'] as bool?,
  securityObjectives: json['security_objectives'] as String?,
  status: assignmentHistoryStatusFromString(json['status'] as String?),
  deletedAt: json['deleted_at'],
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
  translatedStatus: json['translated_status'] as String?,
  userAddress: json['user_address'] == null
      ? null
      : AddressModel.fromJson(json['user_address'] as Map<String, dynamic>),
  guardType: json['guard_type'] == null
      ? null
      : GuardTypeModel.fromJson(json['guard_type'] as Map<String, dynamic>),
  guardClass: json['guard_class'] == null
      ? null
      : GuardClassModel.fromJson(json['guard_class'] as Map<String, dynamic>),
  guardHistoryOfficers: (json['guard_history_officers'] as List<dynamic>?)
      ?.map((e) => GuardModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  guardHistoryEquipmentSupports:
      (json['guard_history_equipment_supports'] as List<dynamic>?)
          ?.map(
            (e) => GuardHistoryEquipmentSupportModel.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList(),
);

Map<String, dynamic> _$GuardHistoryModelToJson(
  GuardHistoryModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'user_id': instance.userId,
  'transaction_id': instance.transactionId,
  'user_address_id': instance.userAddressId,
  'guard_type_id': instance.guardTypeId,
  'guard_class_id': instance.guardClassId,
  'event_name': instance.eventName,
  'pic_name': instance.picName,
  'phone': instance.phone,
  'start_time': instance.startTime?.toIso8601String(),
  'end_time': instance.endTime?.toIso8601String(),
  'is_guard_recommendation': instance.isGuardRecommendation,
  'number_of_guard': instance.numberOfGuard,
  'is_technical_meeting': instance.isTechnicalMeeting,
  'is_includes_meals': instance.isIncludesMeals,
  'security_objectives': instance.securityObjectives,
  'status': _$AssignmentHistoryStatusEnumMap[instance.status],
  'deleted_at': instance.deletedAt,
  'created_at': instance.createdAt?.toIso8601String(),
  'updated_at': instance.updatedAt?.toIso8601String(),
  'translated_status': instance.translatedStatus,
  'user_address': instance.userAddress,
  'guard_type': instance.guardType,
  'guard_class': instance.guardClass,
  'guard_history_officers': instance.guardHistoryOfficers,
  'guard_history_equipment_supports': instance.guardHistoryEquipmentSupports,
};

const _$AssignmentHistoryStatusEnumMap = {
  AssignmentHistoryStatus.pending: 'pending',
  AssignmentHistoryStatus.upcoming: 'upcoming',
  AssignmentHistoryStatus.process: 'process',
  AssignmentHistoryStatus.finished: 'finished',
  AssignmentHistoryStatus.cancelled: 'cancelled',
};
