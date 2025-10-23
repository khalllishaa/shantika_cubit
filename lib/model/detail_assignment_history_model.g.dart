// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_assignment_history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailAssignmentHistoryModel _$DetailAssignmentHistoryModelFromJson(
  Map<String, dynamic> json,
) => DetailAssignmentHistoryModel(
  id: json['id'] as String?,
  userId: json['user_id'] as String?,
  transactionId: json['transaction_id'] as String?,
  userAddressId: json['user_address_id'] as String?,
  guardTypeId: json['guard_type_id'] as String?,
  guardClassId: json['guard_class_id'] as String?,
  eventName: json['event_name'],
  picName: json['pic_name'],
  phone: json['phone'] as String?,
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
  transaction: json['transaction'] == null
      ? null
      : TransactionModel.fromJson(json['transaction'] as Map<String, dynamic>),
  user: json['user'] == null
      ? null
      : UserModel.fromJson(json['user'] as Map<String, dynamic>),
  userAddress: json['user_address'] == null
      ? null
      : AddressModel.fromJson(json['user_address'] as Map<String, dynamic>),
  guardType: json['guard_type'] == null
      ? null
      : GuardModel.fromJson(json['guard_type'] as Map<String, dynamic>),
  guardClass: json['guard_class'] == null
      ? null
      : GuardClassModel.fromJson(json['guard_class'] as Map<String, dynamic>),
  guardHistoryOfficers: (json['guard_history_officers'] as List<dynamic>?)
      ?.map((e) => GuardHistoryOfficer.fromJson(e as Map<String, dynamic>))
      .toList(),
  guardHistoryEquipmentSupports:
      json['guard_history_equipment_supports'] as List<dynamic>?,
  review: json['review'] == null
      ? null
      : ReviewModel.fromJson(json['review'] as Map<String, dynamic>),
);

Map<String, dynamic> _$DetailAssignmentHistoryModelToJson(
  DetailAssignmentHistoryModel instance,
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
  'transaction': instance.transaction,
  'user': instance.user,
  'user_address': instance.userAddress,
  'guard_type': instance.guardType,
  'guard_class': instance.guardClass,
  'guard_history_officers': instance.guardHistoryOfficers,
  'guard_history_equipment_supports': instance.guardHistoryEquipmentSupports,
  'review': instance.review,
};

const _$AssignmentHistoryStatusEnumMap = {
  AssignmentHistoryStatus.pending: 'pending',
  AssignmentHistoryStatus.upcoming: 'upcoming',
  AssignmentHistoryStatus.process: 'process',
  AssignmentHistoryStatus.finished: 'finished',
  AssignmentHistoryStatus.cancelled: 'cancelled',
};

GuardHistoryOfficer _$GuardHistoryOfficerFromJson(Map<String, dynamic> json) =>
    GuardHistoryOfficer(
      id: json['id'] as String?,
      guardHistoryId: json['guard_history_id'] as String?,
      guardId: json['guard_id'] as String?,
      deletedAt: json['deleted_at'],
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      status: json['status'] as String?,
      guardRelation: json['guard_relation'] == null
          ? null
          : GuardRelation.fromJson(
              json['guard_relation'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$GuardHistoryOfficerToJson(
  GuardHistoryOfficer instance,
) => <String, dynamic>{
  'id': instance.id,
  'guard_history_id': instance.guardHistoryId,
  'guard_id': instance.guardId,
  'deleted_at': instance.deletedAt,
  'created_at': instance.createdAt?.toIso8601String(),
  'updated_at': instance.updatedAt?.toIso8601String(),
  'status': instance.status,
  'guard_relation': instance.guardRelation,
};

GuardRelation _$GuardRelationFromJson(Map<String, dynamic> json) =>
    GuardRelation(
      id: json['id'] as String?,
      vendorId: json['vendor_id'] as String?,
      guardClassId: json['guard_class_id'] as String?,
      name: json['name'] as String?,
      avatar: json['avatar'] as String?,
      phone: json['phone'] as String?,
      whatsapp: json['whatsapp'] as String?,
      email: json['email'] as String?,
      address: json['address'] as String?,
      description: json['description'] as String?,
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
      isActive: json['is_active'] as bool?,
      deletedAt: json['deleted_at'],
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      gender: json['gender'] as String?,
      isFavoriteGuard: json['is_favorite_guard'] as bool?,
    );

Map<String, dynamic> _$GuardRelationToJson(GuardRelation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'vendor_id': instance.vendorId,
      'guard_class_id': instance.guardClassId,
      'name': instance.name,
      'avatar': instance.avatar,
      'phone': instance.phone,
      'whatsapp': instance.whatsapp,
      'email': instance.email,
      'address': instance.address,
      'description': instance.description,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'is_active': instance.isActive,
      'deleted_at': instance.deletedAt,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'gender': instance.gender,
      'is_favorite_guard': instance.isFavoriteGuard,
    };

ReviewModel _$ReviewModelFromJson(Map<String, dynamic> json) => ReviewModel(
  id: json['id'] as String?,
  userId: json['user_id'] as String?,
  guardHistoryId: json['guard_history_id'] as String?,
  attachment: json['attachment'],
  star: (json['star'] as num?)?.toInt(),
  review: json['review'] as String?,
  isActive: json['is_active'] as bool?,
  deletedAt: json['deleted_at'],
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$ReviewModelToJson(ReviewModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'guard_history_id': instance.guardHistoryId,
      'attachment': instance.attachment,
      'star': instance.star,
      'review': instance.review,
      'is_active': instance.isActive,
      'deleted_at': instance.deletedAt,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

TransactionComplainModel _$TransactionComplainModelFromJson(
  Map<String, dynamic> json,
) => TransactionComplainModel(
  id: json['id'] as String?,
  transactionId: json['transaction_id'] as String?,
  complain: json['complain'] as String?,
  isSeen: json['is_seen'] as bool?,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$TransactionComplainModelToJson(
  TransactionComplainModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'transaction_id': instance.transactionId,
  'complain': instance.complain,
  'is_seen': instance.isSeen,
  'created_at': instance.createdAt?.toIso8601String(),
  'updated_at': instance.updatedAt?.toIso8601String(),
};
