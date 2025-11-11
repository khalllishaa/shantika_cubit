// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'notification_model.g.dart';

NotificationModel notificationModelFromJson(String str) =>
    NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) =>
    json.encode(data.toJson());

@JsonSerializable(explicitToJson: true)
class NotificationModel {
  @JsonKey(name: "code")
  final int code;

  @JsonKey(name: "success")
  final bool success;

  @JsonKey(name: "message")
  final String message;

  @JsonKey(name: "notifications")
  final List<Notification> notifications;

  NotificationModel({
    required this.code,
    required this.success,
    required this.message,
    required this.notifications,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Notification {
  @JsonKey(name: "id")
  final int id;

  @JsonKey(name: "user_id")
  final int userId;

  @JsonKey(name: "reference_id")
  final int referenceId;

  @JsonKey(name: "title")
  final String title;

  @JsonKey(name: "message")
  final String message;

  @JsonKey(name: "type")
  final String type;

  @JsonKey(name: "is_seen")
  final bool isSeen;

  @JsonKey(name: "created_at")
  final DateTime createdAt;

  @JsonKey(name: "updated_at")
  final DateTime updatedAt;

  @JsonKey(name: "deleted_at")
  final dynamic deletedAt;

  Notification({
    required this.id,
    required this.userId,
    required this.referenceId,
    required this.title,
    required this.message,
    required this.type,
    required this.isSeen,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory Notification.fromJson(Map<String, dynamic> json) =>
      _$NotificationFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationToJson(this);
}