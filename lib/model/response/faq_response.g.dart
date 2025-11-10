// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'faq_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FAQResponse _$FAQResponseFromJson(Map<String, dynamic> json) => FAQResponse(
  code: (json['code'] as num).toInt(),
  success: json['success'] as bool,
  message: json['message'] as String,
  faqs: (json['faqs'] as List<dynamic>)
      .map((e) => FaqModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$FAQResponseToJson(FAQResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'success': instance.success,
      'message': instance.message,
      'faqs': instance.faqs,
    };
