import 'package:json_annotation/json_annotation.dart';

import '../article_model.dart';
part 'article_response.g.dart';

@JsonSerializable()
class ArticleResponse {
  List<ArticleCategoryModel>? article_categories;
  List<ArticleModel>? articles;

  ArticleResponse();

  factory ArticleResponse.fromJson(Map<String, dynamic> json) => _$ArticleResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleResponseToJson(this);
}
