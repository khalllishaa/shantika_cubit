// To parse this JSON data, do
//
//     final appsModel = appsModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';

part 'apps_model.g.dart';

@JsonSerializable()
class AppsModel {
  @JsonKey(name: "phone")
  String? phone;
  @JsonKey(name: "whatsapp")
  String? whatsapp;
  @JsonKey(name: "email")
  String? email;

  AppsModel({
    this.phone,
    this.whatsapp,
    this.email,
  });

  factory AppsModel.fromJson(Map<String, dynamic> json) => _$AppsModelFromJson(json);

  Map<String, dynamic> toJson() => _$AppsModelToJson(this);
}
