// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleDetailResponse _$ArticleDetailResponseFromJson(
  Map<String, dynamic> json,
) => ArticleDetailResponse()
  ..article = json['article'] == null
      ? null
      : ArticleModel.fromJson(json['article'] as Map<String, dynamic>)
  ..likes_article = json['likes_article'] as bool?;

Map<String, dynamic> _$ArticleDetailResponseToJson(
  ArticleDetailResponse instance,
) => <String, dynamic>{
  'article': instance.article,
  'likes_article': instance.likes_article,
};
