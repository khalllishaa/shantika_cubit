import 'package:json_annotation/json_annotation.dart';
import '../terms_conditions_model.dart';

part 'terms_and_condition_response.g.dart';

@JsonSerializable()
class TermsConditionsResponse {
  final int code;
  final bool success;
  final String message;

  @JsonKey(name: 'term_and_condition')
  final TermsConditionsModel termAndCondition;

  TermsConditionsResponse({
    required this.code,
    required this.success,
    required this.message,
    required this.termAndCondition,
  });

  factory TermsConditionsResponse.fromJson(Map<String, dynamic> json) =>
      _$TermsConditionsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TermsConditionsResponseToJson(this);
}