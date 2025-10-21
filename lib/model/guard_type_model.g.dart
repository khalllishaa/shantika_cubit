// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guard_type_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GuardTypeModel _$GuardTypeModelFromJson(Map<String, dynamic> json) =>
    GuardTypeModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      thumbnail: json['thumbnail'] as String?,
      description: json['description'] as String?,
      isActive: json['is_active'] as bool?,
      deletedAt: json['deleted_at'],
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      type: json['type'] as String?,
    );

Map<String, dynamic> _$GuardTypeModelToJson(GuardTypeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'thumbnail': instance.thumbnail,
      'description': instance.description,
      'is_active': instance.isActive,
      'deleted_at': instance.deletedAt,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'type': instance.type,
    };
