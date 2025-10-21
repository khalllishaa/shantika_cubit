import 'package:json_annotation/json_annotation.dart';

part 'terms_conditions_model.g.dart';

@JsonSerializable()
class TermsConditionsModel {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "type")
  String? type;
  @JsonKey(name: "content")
  String? content;
  @JsonKey(name: "created_at")
  DateTime? createdAt;
  @JsonKey(name: "updated_at")
  DateTime? updatedAt;
  @JsonKey(name: "deleted_at")
  dynamic deletedAt;

  TermsConditionsModel({
    this.id,
    this.type,
    this.content,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory TermsConditionsModel.fromJson(Map<String, dynamic> json) =>
      _$TermsConditionsModelFromJson(json);

  Map<String, dynamic> toJson() => _$TermsConditionsModelToJson(this);
}
