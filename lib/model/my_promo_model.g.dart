// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_promo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyPromoModel _$MyPromoModelFromJson(Map<String, dynamic> json) => MyPromoModel(
      id: json['id'] as String?,
      userId: json['user_id'] as String?,
      promoId: json['promo_id'] as String?,
      isUsed: json['is_used'] as bool?,
      deletedAt: json['deleted_at'],
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      promo: json['promo'] == null
          ? null
          : PromoModel.fromJson(json['promo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MyPromoModelToJson(MyPromoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'promo_id': instance.promoId,
      'is_used': instance.isUsed,
      'deleted_at': instance.deletedAt,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'promo': instance.promo,
    };
