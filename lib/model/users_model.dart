import 'package:json_annotation/json_annotation.dart';

part 'users_model.g.dart';

@JsonSerializable()
class UsersModel {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "uuid")
  String? uuid;

  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "email")
  String? email;

  @JsonKey(name: "phone")
  String? phone;

  @JsonKey(name: "birth")
  DateTime? birth;

  @JsonKey(name: "birth_place")
  String? birthPlace;

  @JsonKey(name: "gender")
  String? gender;

  @JsonKey(name: "address")
  String? address;

  @JsonKey(name: "avatar")
  dynamic avatar;

  @JsonKey(name: "avatar_url")
  String? avatarUrl;

  @JsonKey(name: "name_agent")
  String? nameAgent;

  @JsonKey(name: "agencies")
  dynamic agencies;

  @JsonKey(name: "created_at")
  DateTime? createdAt;

  @JsonKey(name: "updated_at")
  DateTime? updatedAt;

  UsersModel({
    this.id,
    this.uuid,
    this.name,
    this.email,
    this.phone,
    this.birth,
    this.birthPlace,
    this.gender,
    this.address,
    this.avatar,
    this.avatarUrl,
    this.nameAgent,
    this.agencies,
    this.createdAt,
    this.updatedAt,
  });

  factory UsersModel.fromJson(Map<String, dynamic> json) =>
      _$UsersModelFromJson(json);

  Map<String, dynamic> toJson() => _$UsersModelToJson(this);
}