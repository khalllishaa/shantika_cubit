import 'package:json_annotation/json_annotation.dart';

part 'notifications_response.g.dart';

@JsonSerializable()
class NotificationsResponse {
  @JsonKey(name: "notifications")
  final List<NotificationItem> notifications;

  NotificationsResponse({
    required this.notifications,
  });

  factory NotificationsResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationsResponseToJson(this);
}

@JsonSerializable()
class NotificationItem {
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

  NotificationItem({
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

  factory NotificationItem.fromJson(Map<String, dynamic> json) =>
      _$NotificationItemFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationItemToJson(this);
}