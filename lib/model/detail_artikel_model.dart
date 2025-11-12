// To parse this JSON data, do
//
//     final detailArtikelModel = detailArtikelModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'detail_artikel_model.g.dart';

DetailArtikelModel detailArtikelModelFromJson(String str) => DetailArtikelModel.fromJson(json.decode(str));

String detailArtikelModelToJson(DetailArtikelModel data) => json.encode(data.toJson());

@JsonSerializable()
class DetailArtikelModel {
  @JsonKey(name: "code")
  int code;
  @JsonKey(name: "success")
  bool success;
  @JsonKey(name: "message")
  String message;
  @JsonKey(name: "article")
  Article article;

  DetailArtikelModel({
    required this.code,
    required this.success,
    required this.message,
    required this.article,
  });

  factory DetailArtikelModel.fromJson(Map<String, dynamic> json) => _$DetailArtikelModelFromJson(json);

  Map<String, dynamic> toJson() => _$DetailArtikelModelToJson(this);
}

@JsonSerializable()
class Article {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "name")
  String name;
  @JsonKey(name: "image")
  String image;
  @JsonKey(name: "description")
  String description;
  @JsonKey(name: "created_at")
  DateTime createdAt;
  @JsonKey(name: "updated_at")
  DateTime updatedAt;

  Article({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Article.fromJson(Map<String, dynamic> json) => _$ArticleFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleToJson(this);
}
