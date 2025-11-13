// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agency_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AgencyCityResponse _$AgencyCityResponseFromJson(Map<String, dynamic> json) =>
    AgencyCityResponse(
      code: (json['code'] as num).toInt(),
      success: json['success'] as bool,
      message: json['message'] as String,
      agenciesCity: (json['agencies_city'] as List<dynamic>)
          .map((e) => AgencyCity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AgencyCityResponseToJson(AgencyCityResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'success': instance.success,
      'message': instance.message,
      'agencies_city': instance.agenciesCity,
    };

AgencyCity _$AgencyCityFromJson(Map<String, dynamic> json) =>
    AgencyCity(id: (json['id'] as num).toInt(), name: json['name'] as String);

Map<String, dynamic> _$AgencyCityToJson(AgencyCity instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};
