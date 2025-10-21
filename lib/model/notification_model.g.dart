// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      id: json['id'] as String?,
      userParentableType: json['user_parentable_type'] as String?,
      userParentableId: json['user_parentable_id'] as String?,
      title: json['title'] as String?,
      body: json['body'] as String?,
      type: json['type'] as String?,
      referenceId: json['reference_id'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      payload: json['payload'] as String?,
      isSeen: json['is_seen'] as bool?,
    );

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_parentable_type': instance.userParentableType,
      'user_parentable_id': instance.userParentableId,
      'title': instance.title,
      'body': instance.body,
      'type': instance.type,
      'reference_id': instance.referenceId,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'payload': instance.payload,
      'is_seen': instance.isSeen,
    };
