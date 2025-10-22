// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_method_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentMethodModel _$PaymentMethodModelFromJson(Map<String, dynamic> json) =>
    PaymentMethodModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      subName: json['sub_name'] as String?,
      type: json['type'] as String?,
      isActive: json['is_active'] as bool?,
      deletedAt: json['deleted_at'],
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$PaymentMethodModelToJson(PaymentMethodModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'sub_name': instance.subName,
      'type': instance.type,
      'is_active': instance.isActive,
      'deleted_at': instance.deletedAt,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

OfflinePaymentMethodModel _$OfflinePaymentMethodModelFromJson(
  Map<String, dynamic> json,
) => OfflinePaymentMethodModel(
  id: json['id'] as String?,
  owner: json['owner'] as String?,
  bankAccount: json['bank_account'] as String?,
  bankAccountNumber: json['bank_account_number'] as String?,
  deletedAt: json['deleted_at'],
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
  translatedBankAccount: json['translated_bank_account'] as String?,
  thumbnail: json['thumbnail'] as String?,
);

Map<String, dynamic> _$OfflinePaymentMethodModelToJson(
  OfflinePaymentMethodModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'owner': instance.owner,
  'bank_account': instance.bankAccount,
  'bank_account_number': instance.bankAccountNumber,
  'deleted_at': instance.deletedAt,
  'created_at': instance.createdAt?.toIso8601String(),
  'updated_at': instance.updatedAt?.toIso8601String(),
  'translated_bank_account': instance.translatedBankAccount,
  'thumbnail': instance.thumbnail,
};
