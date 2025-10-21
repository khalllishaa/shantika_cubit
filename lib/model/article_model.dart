// To parse this JSON data, do
//
//     final articleModel = articleModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'article_model.g.dart';

ArticleModel articleModelFromJson(String str) => ArticleModel.fromJson(json.decode(str));

String articleModelToJson(ArticleModel data) => json.encode(data.toJson());

@JsonSerializable()
class ArticleModel {
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "slug")
  String? slug;
  @JsonKey(name: "thumbnail")
  String? thumbnail;
  @JsonKey(name: "content")
  String? content;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "article_category_id")
  String? articleCategoryId;
  @JsonKey(name: "article_category")
  ArticleCategoryModel? articleCategory;

  ArticleModel({
    this.title,
    this.slug,
    this.thumbnail,
    this.content,
    this.createdAt,
    this.articleCategoryId,
    this.articleCategory,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) => _$ArticleModelFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleModelToJson(this);
}

@JsonSerializable()
class ArticleCategoryModel {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;

  ArticleCategoryModel({
    this.id,
    this.name,
  });

  factory ArticleCategoryModel.fromJson(Map<String, dynamic> json) => _$ArticleCategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleCategoryModelToJson(this);
}
