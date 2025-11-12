// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_artikel_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailArtikelModel _$DetailArtikelModelFromJson(Map<String, dynamic> json) =>
    DetailArtikelModel(
      code: (json['code'] as num).toInt(),
      success: json['success'] as bool,
      message: json['message'] as String,
      article: Article.fromJson(json['article'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DetailArtikelModelToJson(DetailArtikelModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'success': instance.success,
      'message': instance.message,
      'article': instance.article,
    };

Article _$ArticleFromJson(Map<String, dynamic> json) => Article(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  image: json['image'] as String,
  description: json['description'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'image': instance.image,
  'description': instance.description,
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
};
