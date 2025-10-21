// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleResponse _$ArticleResponseFromJson(Map<String, dynamic> json) =>
    ArticleResponse()
      ..article_categories = (json['article_categories'] as List<dynamic>?)
          ?.map((e) => ArticleCategoryModel.fromJson(e as Map<String, dynamic>))
          .toList()
      ..articles = (json['articles'] as List<dynamic>?)
          ?.map((e) => ArticleModel.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$ArticleResponseToJson(ArticleResponse instance) =>
    <String, dynamic>{
      'article_categories': instance.article_categories,
      'articles': instance.articles,
    };
