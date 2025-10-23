// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleModel _$ArticleModelFromJson(Map<String, dynamic> json) => ArticleModel(
  title: json['title'] as String?,
  slug: json['slug'] as String?,
  thumbnail: json['thumbnail'] as String?,
  content: json['content'] as String?,
  createdAt: json['created_at'] as String?,
  articleCategoryId: json['article_category_id'] as String?,
  articleCategory: json['article_category'] == null
      ? null
      : ArticleCategoryModel.fromJson(
          json['article_category'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$ArticleModelToJson(ArticleModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'slug': instance.slug,
      'thumbnail': instance.thumbnail,
      'content': instance.content,
      'created_at': instance.createdAt,
      'article_category_id': instance.articleCategoryId,
      'article_category': instance.articleCategory,
    };

ArticleCategoryModel _$ArticleCategoryModelFromJson(
  Map<String, dynamic> json,
) => ArticleCategoryModel(
  id: json['id'] as String?,
  name: json['name'] as String?,
);

Map<String, dynamic> _$ArticleCategoryModelToJson(
  ArticleCategoryModel instance,
) => <String, dynamic>{'id': instance.id, 'name': instance.name};
