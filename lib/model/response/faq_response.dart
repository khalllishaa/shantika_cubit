import 'package:json_annotation/json_annotation.dart';
import '../faq_model.dart';

part 'faq_response.g.dart';

@JsonSerializable()
class FAQResponse {
  final int code;
  final bool success;
  final String message;
  final List<FaqModel> faqs;

  FAQResponse({
    required this.code,
    required this.success,
    required this.message,
    required this.faqs,
  });

  factory FAQResponse.fromJson(Map<String, dynamic> json) =>
      _$FAQResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FAQResponseToJson(this);
}
