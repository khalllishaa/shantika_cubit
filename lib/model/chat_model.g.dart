// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatModel _$ChatModelFromJson(Map<String, dynamic> json) => ChatModel(
  code: (json['code'] as num).toInt(),
  success: json['success'] as bool,
  message: json['message'] as String,
  data: (json['data'] as List<dynamic>)
      .map((e) => Datum.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ChatModelToJson(ChatModel instance) => <String, dynamic>{
  'code': instance.code,
  'success': instance.success,
  'message': instance.message,
  'data': instance.data,
};

Datum _$DatumFromJson(Map<String, dynamic> json) => Datum(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  value: json['value'] as String,
  type: json['type'] as String,
  icon: json['icon'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
  link: json['link'] as String,
);

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'value': instance.value,
  'type': instance.type,
  'icon': instance.icon,
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
  'link': instance.link,
};
