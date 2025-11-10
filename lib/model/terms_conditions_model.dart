import 'package:json_annotation/json_annotation.dart';

part 'terms_conditions_model.g.dart';

@JsonSerializable()
class TermsConditionsModel {
  final int id;
  final String name;
  final String content;

  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  TermsConditionsModel({
    required this.id,
    required this.name,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TermsConditionsModel.fromJson(Map<String, dynamic> json) =>
      _$TermsConditionsModelFromJson(json);

  Map<String, dynamic> toJson() => _$TermsConditionsModelToJson(this);
}
