// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthResponse _$AuthResponseFromJson(Map<String, dynamic> json) => AuthResponse(
  code: (json['code'] as num?)?.toInt(),
  success: json['success'] as bool?,
  message: json['message'] as String?,
  user: json['user'] == null
      ? null
      : UsersModel.fromJson(json['user'] as Map<String, dynamic>),
  token: json['token'] as String?,
);

Map<String, dynamic> _$AuthResponseToJson(AuthResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'success': instance.success,
      'message': instance.message,
      'user': instance.user,
      'token': instance.token,
    };
