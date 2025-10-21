// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guard_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GuardResponse _$GuardResponseFromJson(Map<String, dynamic> json) =>
    GuardResponse()
      ..guards = (json['guards'] as List<dynamic>?)
          ?.map((e) => GuardModel.fromJson(e as Map<String, dynamic>))
          .toList()
      ..guard = json['guard'] == null
          ? null
          : GuardModel.fromJson(json['guard'] as Map<String, dynamic>)
      ..article = (json['article'] as List<dynamic>?)
          ?.map((e) => ArticleModel.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$GuardResponseToJson(GuardResponse instance) =>
    <String, dynamic>{
      'guards': instance.guards,
      'guard': instance.guard,
      'article': instance.article,
    };
