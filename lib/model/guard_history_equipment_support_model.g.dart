// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guard_history_equipment_support_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GuardHistoryEquipmentSupportModel _$GuardHistoryEquipmentSupportModelFromJson(
  Map<String, dynamic> json,
) => GuardHistoryEquipmentSupportModel(
  id: json['id'] as String?,
  transactionId: json['transaction_id'] as String?,
  guardHistoryId: json['guard_history_id'] as String?,
  equipmentSupportId: json['equipment_support_id'] as String?,
  quantity: (json['quantity'] as num?)?.toInt(),
  isActive: json['is_active'] as bool?,
  deletedAt: json['deleted_at'],
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
  equipmentSupport: json['equipment_support'] == null
      ? null
      : EquipmentSupportModel.fromJson(
          json['equipment_support'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$GuardHistoryEquipmentSupportModelToJson(
  GuardHistoryEquipmentSupportModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'transaction_id': instance.transactionId,
  'guard_history_id': instance.guardHistoryId,
  'equipment_support_id': instance.equipmentSupportId,
  'quantity': instance.quantity,
  'is_active': instance.isActive,
  'deleted_at': instance.deletedAt,
  'created_at': instance.createdAt?.toIso8601String(),
  'updated_at': instance.updatedAt?.toIso8601String(),
  'equipment_support': instance.equipmentSupport,
};
