// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  id: json['id'] as String?,
  firstName: json['first_name'] as String?,
  lastName: json['last_name'] as String?,
  email: json['email'] as String?,
  emailVerifiedAt: json['email_verified_at'],
  gender: json['gender'] as String?,
  phone: json['phone'] as String?,
  avatar: json['avatar'] as String?,
  latitude: json['latitude'] as String?,
  longitude: json['longitude'] as String?,
  firebaseUid: json['firebase_uid'],
  appleId: json['apple_id'],
  fcmToken: json['fcm_token'],
  isActive: json['is_active'] as bool?,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
  deletedAt: json['deleted_at'],
  birthDate: json['birth_date'] as String?,
  name: json['name'] as String?,
  userAddressId: json['user_address_id'] as String?,
  eventName: json['event_name'] as String?,
  picName: json['pic_name'] as String?,
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'id': instance.id,
  'first_name': instance.firstName,
  'last_name': instance.lastName,
  'email': instance.email,
  'email_verified_at': instance.emailVerifiedAt,
  'gender': instance.gender,
  'phone': instance.phone,
  'avatar': instance.avatar,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'firebase_uid': instance.firebaseUid,
  'apple_id': instance.appleId,
  'fcm_token': instance.fcmToken,
  'is_active': instance.isActive,
  'created_at': instance.createdAt?.toIso8601String(),
  'updated_at': instance.updatedAt?.toIso8601String(),
  'deleted_at': instance.deletedAt,
  'birth_date': instance.birthDate,
  'name': instance.name,
  'event_name': instance.eventName,
  'pic_name': instance.picName,
  'user_address_id': instance.userAddressId,
};
