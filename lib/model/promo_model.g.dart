// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PromoModel _$PromoModelFromJson(Map<String, dynamic> json) =>
    PromoModel(
        id: json['id'] as String?,
        name: json['name'] as String?,
        thumbnail: json['thumbnail'] as String?,
        code: json['code'] as String?,
        quota: (json['quota'] as num?)?.toInt(),
        remainingQuota: (json['remaining_quota'] as num?)?.toInt(),
        usedQuota: (json['used_quota'] as num?)?.toInt(),
      )
      ..description = json['description'] as String?
      ..startDate = json['start_date'] as String?
      ..expiryDate = json['expiry_date'] as String?
      ..startTime = json['start_time'] as String?
      ..expiryTime = json['expiry_time'] as String?
      ..minPurchase = (json['min_purchase'] as num?)?.toInt();

Map<String, dynamic> _$PromoModelToJson(PromoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'thumbnail': instance.thumbnail,
      'code': instance.code,
      'quota': instance.quota,
      'remaining_quota': instance.remainingQuota,
      'used_quota': instance.usedQuota,
      'description': instance.description,
      'start_date': instance.startDate,
      'expiry_date': instance.expiryDate,
      'start_time': instance.startTime,
      'expiry_time': instance.expiryTime,
      'min_purchase': instance.minPurchase,
    };
