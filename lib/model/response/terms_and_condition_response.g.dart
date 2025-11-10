// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'terms_and_condition_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TermsConditionsResponse _$TermsConditionsResponseFromJson(
  Map<String, dynamic> json,
) => TermsConditionsResponse(
  code: (json['code'] as num).toInt(),
  success: json['success'] as bool,
  message: json['message'] as String,
  termAndCondition: TermsConditionsModel.fromJson(
    json['term_and_condition'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$TermsConditionsResponseToJson(
  TermsConditionsResponse instance,
) => <String, dynamic>{
  'code': instance.code,
  'success': instance.success,
  'message': instance.message,
  'term_and_condition': instance.termAndCondition,
};
