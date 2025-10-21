import 'package:json_annotation/json_annotation.dart';
import '../article_model.dart';

part 'article_detail_response.g.dart';

@JsonSerializable()
class ArticleDetailResponse {
  ArticleModel? article;
  bool? likes_article;

  ArticleDetailResponse();

  factory ArticleDetailResponse.fromJson(Map<String, dynamic> json) => _$ArticleDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleDetailResponseToJson(this);
}
