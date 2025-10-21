// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';

part 'notification_model.g.dart';

@JsonSerializable()
class NotificationModel {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "user_parentable_type")
  String? userParentableType;
  @JsonKey(name: "user_parentable_id")
  String? userParentableId;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "body")
  String? body;
  @JsonKey(name: "type")
  String? type;
  @JsonKey(name: "reference_id")
  String? referenceId;
  @JsonKey(name: "created_at")
  DateTime? createdAt;
  @JsonKey(name: "updated_at")
  DateTime? updatedAt;
  @JsonKey(name: "payload")
  String? payload;
  @JsonKey(name: "is_seen")
  bool? isSeen;

  NotificationModel({
    this.id,
    this.userParentableType,
    this.userParentableId,
    this.title,
    this.body,
    this.type,
    this.referenceId,
    this.createdAt,
    this.updatedAt,
    this.payload,
    this.isSeen,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}
