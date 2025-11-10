// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'about_us_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AboutUsModel _$AboutUsModelFromJson(Map<String, dynamic> json) => AboutUsModel(
  code: (json['code'] as num).toInt(),
  success: json['success'] as bool,
  message: json['message'] as String,
  about: About.fromJson(json['about'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AboutUsModelToJson(AboutUsModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'success': instance.success,
      'message': instance.message,
      'about': instance.about,
    };

About _$AboutFromJson(Map<String, dynamic> json) => About(
  id: (json['id'] as num).toInt(),
  image: json['image'] as String,
  description: json['description'] as String,
  address: json['address'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$AboutToJson(About instance) => <String, dynamic>{
  'id': instance.id,
  'image': instance.image,
  'description': instance.description,
  'address': instance.address,
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
};
