// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slider_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SliderModel _$SliderModelFromJson(Map<String, dynamic> json) => SliderModel(
  title: json['title'] as String?,
  slug: json['slug'] as String?,
  thumbnail: json['thumbnail'] as String?,
  description: json['description'] as String?,
  shortDescription: json['short_description'] as String?,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$SliderModelToJson(SliderModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'slug': instance.slug,
      'thumbnail': instance.thumbnail,
      'short_description': instance.shortDescription,
      'description': instance.description,
      'created_at': instance.createdAt?.toIso8601String(),
    };
