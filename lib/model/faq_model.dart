import 'package:json_annotation/json_annotation.dart';

part 'faq_model.g.dart';

@JsonSerializable()
class FaqModel {
  final int id;
  final String question;
  final String answer;

  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  @JsonKey(name: 'deleted_at')
  final DateTime? deletedAt;

  FaqModel({
    required this.id,
    required this.question,
    required this.answer,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory FaqModel.fromJson(Map<String, dynamic> json) => _$FaqModelFromJson(json);
  Map<String, dynamic> toJson() => _$FaqModelToJson(this);
}
