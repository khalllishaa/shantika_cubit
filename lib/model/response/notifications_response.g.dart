// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationsResponse _$NotificationsResponseFromJson(
  Map<String, dynamic> json,
) => NotificationsResponse(
  notifications: (json['notifications'] as List<dynamic>)
      .map((e) => NotificationItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$NotificationsResponseToJson(
  NotificationsResponse instance,
) => <String, dynamic>{'notifications': instance.notifications};

NotificationItem _$NotificationItemFromJson(Map<String, dynamic> json) =>
    NotificationItem(
      id: (json['id'] as num).toInt(),
      userId: (json['user_id'] as num).toInt(),
      referenceId: (json['reference_id'] as num).toInt(),
      title: json['title'] as String,
      message: json['message'] as String,
      type: json['type'] as String,
      isSeen: json['is_seen'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      deletedAt: json['deleted_at'],
    );

Map<String, dynamic> _$NotificationItemToJson(NotificationItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'reference_id': instance.referenceId,
      'title': instance.title,
      'message': instance.message,
      'type': instance.type,
      'is_seen': instance.isSeen,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'deleted_at': instance.deletedAt,
    };
