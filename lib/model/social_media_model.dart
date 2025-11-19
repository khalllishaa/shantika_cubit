// To parse this JSON data, do
//
//     final socialMediaModel = socialMediaModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'social_media_model.g.dart';

SocialMediaModel socialMediaModelFromJson(String str) => SocialMediaModel.fromJson(json.decode(str));

String socialMediaModelToJson(SocialMediaModel data) => json.encode(data.toJson());

@JsonSerializable()
class SocialMediaModel {
  @JsonKey(name: "code")
  int code;
  @JsonKey(name: "success")
  bool success;
  @JsonKey(name: "message")
  String message;
  @JsonKey(name: "social_medias")
  List<SocialMedia> socialMedias;

  SocialMediaModel({
    required this.code,
    required this.success,
    required this.message,
    required this.socialMedias,
  });

  factory SocialMediaModel.fromJson(Map<String, dynamic> json) => _$SocialMediaModelFromJson(json);

  Map<String, dynamic> toJson() => _$SocialMediaModelToJson(this);
}

@JsonSerializable()
class SocialMedia {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "name")
  String name;
  @JsonKey(name: "icon")
  String icon;
  @JsonKey(name: "value")
  String value;
  @JsonKey(name: "created_at")
  DateTime createdAt;
  @JsonKey(name: "updated_at")
  DateTime updatedAt;

  SocialMedia({
    required this.id,
    required this.name,
    required this.icon,
    required this.value,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SocialMedia.fromJson(Map<String, dynamic> json) => _$SocialMediaFromJson(json);

  Map<String, dynamic> toJson() => _$SocialMediaToJson(this);
}
