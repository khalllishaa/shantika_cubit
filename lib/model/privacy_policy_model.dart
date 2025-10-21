import 'package:json_annotation/json_annotation.dart';

part 'privacy_policy_model.g.dart';

@JsonSerializable()
class PrivacyPolicyModel {
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

  PrivacyPolicyModel({
    this.id,
    this.type,
    this.content,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory PrivacyPolicyModel.fromJson(Map<String, dynamic> json) =>
      _$PrivacyPolicyModelFromJson(json);

  Map<String, dynamic> toJson() => _$PrivacyPolicyModelToJson(this);
}
