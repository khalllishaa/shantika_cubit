// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'terms_conditions_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TermsConditionsModel _$TermsConditionsModelFromJson(
        Map<String, dynamic> json) =>
    TermsConditionsModel(
      id: json['id'] as String?,
      type: json['type'] as String?,
      content: json['content'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      deletedAt: json['deleted_at'],
    );

Map<String, dynamic> _$TermsConditionsModelToJson(
        TermsConditionsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'content': instance.content,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'deleted_at': instance.deletedAt,
    };
