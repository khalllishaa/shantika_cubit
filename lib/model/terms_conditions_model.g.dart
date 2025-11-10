// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'terms_conditions_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TermsConditionsModel _$TermsConditionsModelFromJson(
  Map<String, dynamic> json,
) => TermsConditionsModel(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  content: json['content'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$TermsConditionsModelToJson(
  TermsConditionsModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'content': instance.content,
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
};
