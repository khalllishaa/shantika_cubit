// To parse this JSON data, do
//
//     final sliderModel = sliderModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'slider_model.g.dart';

SliderModel sliderModelFromJson(String str) => SliderModel.fromJson(json.decode(str));

String sliderModelToJson(SliderModel data) => json.encode(data.toJson());

@JsonSerializable()
class SliderModel {
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "slug")
  String? slug;
  @JsonKey(name: "thumbnail")
  String? thumbnail;
  @JsonKey(name: "short_description")
  String? shortDescription;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "created_at")
  DateTime? createdAt;

  SliderModel({
    this.title,
    this.slug,
    this.thumbnail,
    this.description,
    this.shortDescription,
    this.createdAt,
  });

  factory SliderModel.fromJson(Map<String, dynamic> json) => _$SliderModelFromJson(json);

  Map<String, dynamic> toJson() => _$SliderModelToJson(this);
}
