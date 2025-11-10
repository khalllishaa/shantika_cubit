import 'package:json_annotation/json_annotation.dart';
import '../privacy_policy_model.dart';

part 'privacy_policy_response.g.dart';

@JsonSerializable()
class PrivacyPolicyResponse {
  final int code;
  final bool success;
  final String message;

  @JsonKey(name: 'privacy_policy')
  final PrivacyPolicyModel privacyPolicy;

  PrivacyPolicyResponse({
    required this.code,
    required this.success,
    required this.message,
    required this.privacyPolicy,
  });

  factory PrivacyPolicyResponse.fromJson(Map<String, dynamic> json) =>
      _$PrivacyPolicyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PrivacyPolicyResponseToJson(this);
}