// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UsersModel _$UsersModelFromJson(Map<String, dynamic> json) => UsersModel(
  id: (json['id'] as num?)?.toInt(),
  uuid: json['uuid'] as String?,
  name: json['name'] as String?,
  email: json['email'] as String?,
  phone: json['phone'] as String?,
  birth: json['birth'] == null ? null : DateTime.parse(json['birth'] as String),
  birthPlace: json['birth_place'] as String?,
  gender: json['gender'] as String?,
  avatar: json['avatar'],
  avatarUrl: json['avatar_url'] as String?,
  nameAgent: json['name_agent'] as String?,
  agencies: json['agencies'],
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$UsersModelToJson(UsersModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uuid': instance.uuid,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'birth': instance.birth?.toIso8601String(),
      'birth_place': instance.birthPlace,
      'gender': instance.gender,
      'avatar': instance.avatar,
      'avatar_url': instance.avatarUrl,
      'name_agent': instance.nameAgent,
      'agencies': instance.agencies,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
