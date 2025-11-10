// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'privacy_policy_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrivacyPolicyResponse _$PrivacyPolicyResponseFromJson(
  Map<String, dynamic> json,
) => PrivacyPolicyResponse(
  code: (json['code'] as num).toInt(),
  success: json['success'] as bool,
  message: json['message'] as String,
  privacyPolicy: PrivacyPolicyModel.fromJson(
    json['privacy_policy'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$PrivacyPolicyResponseToJson(
  PrivacyPolicyResponse instance,
) => <String, dynamic>{
  'code': instance.code,
  'success': instance.success,
  'message': instance.message,
  'privacy_policy': instance.privacyPolicy,
};
