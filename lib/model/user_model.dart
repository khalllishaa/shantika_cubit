// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "first_name")
  String? firstName;
  @JsonKey(name: "last_name")
  String? lastName;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "email_verified_at")
  dynamic emailVerifiedAt;
  @JsonKey(name: "gender")
  String? gender;
  @JsonKey(name: "phone")
  String? phone;
  @JsonKey(name: "avatar")
  String? avatar;
  @JsonKey(name: "latitude")
  String? latitude;
  @JsonKey(name: "longitude")
  String? longitude;
  @JsonKey(name: "firebase_uid")
  dynamic firebaseUid;
  @JsonKey(name: "apple_id")
  dynamic appleId;
  @JsonKey(name: "fcm_token")
  dynamic fcmToken;
  @JsonKey(name: "is_active")
  bool? isActive;
  @JsonKey(name: "created_at")
  DateTime? createdAt;
  @JsonKey(name: "updated_at")
  DateTime? updatedAt;
  @JsonKey(name: "deleted_at")
  dynamic deletedAt;
  @JsonKey(name: "birth_date")
  String? birthDate;
  @JsonKey(name: "name")
  String? name;

  /// FOR TRANSACTION
  @JsonKey(name: "event_name")
  String? eventName;
  @JsonKey(name: "pic_name")
  String? picName;
  @JsonKey(name: "user_address_id")
  String? userAddressId;

  UserModel({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.emailVerifiedAt,
    this.gender,
    this.phone,
    this.avatar,
    this.latitude,
    this.longitude,
    this.firebaseUid,
    this.appleId,
    this.fcmToken,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.birthDate,
    this.name,
    this.userAddressId,
    this.eventName,
    this.picName,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
