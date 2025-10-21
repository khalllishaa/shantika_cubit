// To parse this JSON data, do
//
//     final guardTypeModel = guardTypeModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';

part 'guard_type_model.g.dart';

@JsonSerializable()
class GuardTypeModel {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "thumbnail")
  String? thumbnail;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "is_active")
  bool? isActive;
  @JsonKey(name: "deleted_at")
  dynamic deletedAt;
  @JsonKey(name: "created_at")
  DateTime? createdAt;
  @JsonKey(name: "updated_at")
  DateTime? updatedAt;
  @JsonKey(name: "type")
  String? type;

  GuardTypeModel({
    this.id,
    this.name,
    this.thumbnail,
    this.description,
    this.isActive,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.type,
  });

  factory GuardTypeModel.fromJson(Map<String, dynamic> json) => _$GuardTypeModelFromJson(json);

  Map<String, dynamic> toJson() => _$GuardTypeModelToJson(this);
}
