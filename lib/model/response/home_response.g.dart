// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeResponse _$HomeResponseFromJson(Map<String, dynamic> json) => HomeResponse()
  ..guard_types = (json['guard_types'] as List<dynamic>?)
      ?.map((e) => GuardTypeModel.fromJson(e as Map<String, dynamic>))
      .toList()
  ..apps = json['apps'] == null
      ? null
      : AppsModel.fromJson(json['apps'] as Map<String, dynamic>)
  ..sliders = (json['sliders'] as List<dynamic>?)
      ?.map((e) => SliderModel.fromJson(e as Map<String, dynamic>))
      .toList()
  ..articles = (json['articles'] as List<dynamic>?)
      ?.map((e) => ArticleModel.fromJson(e as Map<String, dynamic>))
      .toList()
  ..promos = (json['promos'] as List<dynamic>?)
      ?.map((e) => PromoModel.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$HomeResponseToJson(HomeResponse instance) =>
    <String, dynamic>{
      'guard_types': instance.guard_types,
      'apps': instance.apps,
      'sliders': instance.sliders,
      'articles': instance.articles,
      'promos': instance.promos,
    };
