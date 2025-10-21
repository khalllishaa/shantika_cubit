// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promo_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PromoResponse _$PromoResponseFromJson(Map<String, dynamic> json) =>
    PromoResponse()
      ..promos = (json['promos'] as List<dynamic>?)
          ?.map((e) => PromoModel.fromJson(e as Map<String, dynamic>))
          .toList()
      ..my_promos = (json['my_promos'] as List<dynamic>?)
          ?.map((e) => MyPromoModel.fromJson(e as Map<String, dynamic>))
          .toList()
      ..discount = (json['discount'] as num?)?.toInt();

Map<String, dynamic> _$PromoResponseToJson(PromoResponse instance) =>
    <String, dynamic>{
      'promos': instance.promos,
      'my_promos': instance.my_promos,
      'discount': instance.discount,
    };
