// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_method_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentMethodResponse _$PaymentMethodResponseFromJson(
  Map<String, dynamic> json,
) => PaymentMethodResponse(
  payment_methods: (json['payment_methods'] as List<dynamic>?)
      ?.map((e) => PaymentMethodModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  offline_payment_methods: (json['offline_payment_methods'] as List<dynamic>?)
      ?.map(
        (e) => OfflinePaymentMethodModel.fromJson(e as Map<String, dynamic>),
      )
      .toList(),
);

Map<String, dynamic> _$PaymentMethodResponseToJson(
  PaymentMethodResponse instance,
) => <String, dynamic>{
  'payment_methods': instance.payment_methods,
  'offline_payment_methods': instance.offline_payment_methods,
};
