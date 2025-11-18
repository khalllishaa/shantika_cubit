// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_cities_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllCitiesModel _$AllCitiesModelFromJson(Map<String, dynamic> json) =>
    AllCitiesModel(
      code: (json['code'] as num).toInt(),
      success: json['success'] as bool,
      message: json['message'] as String,
      cities: (json['cities'] as List<dynamic>)
          .map((e) => City.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllCitiesModelToJson(AllCitiesModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'success': instance.success,
      'message': instance.message,
      'cities': instance.cities,
    };

City _$CityFromJson(Map<String, dynamic> json) => City(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  provinceId: (json['province_id'] as num?)?.toInt(),
  areaId: (json['area_id'] as num).toInt(),
  pgId: json['pg_id'] as String?,
  duration: (json['duration'] as num?)?.toInt(),
  agentCount: (json['agent_count'] as num?)?.toInt(),
);

Map<String, dynamic> _$CityToJson(City instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'province_id': instance.provinceId,
  'area_id': instance.areaId,
  'pg_id': instance.pgId,
  'duration': instance.duration,
  'agent_count': instance.agentCount,
};
