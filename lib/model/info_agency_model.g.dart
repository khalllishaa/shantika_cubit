// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info_agency_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InfoAgencyModel _$InfoAgencyModelFromJson(Map<String, dynamic> json) =>
    InfoAgencyModel(
      code: (json['code'] as num).toInt(),
      success: json['success'] as bool,
      message: json['message'] as String,
      agencies: (json['agencies'] as List<dynamic>)
          .map((e) => Agency.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$InfoAgencyModelToJson(InfoAgencyModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'success': instance.success,
      'message': instance.message,
      'agencies': instance.agencies,
    };

Agency _$AgencyFromJson(Map<String, dynamic> json) => Agency(
  id: (json['id'] as num).toInt(),
  agencyName: json['agency_name'] as String,
  cityName: json['city_name'] as String,
  agencyAddress: json['agency_address'] as String,
  agencyPhone: json['agency_phone'] as String,
  phone: (json['phone'] as List<dynamic>).map((e) => e as String).toList(),
  agencyAvatar: json['agency_avatar'] as String?,
  agencyLat: json['agency_lat'] as String?,
  agencyLng: json['agency_lng'] as String?,
  morningTime: json['morning_time'] as String?,
  nightTime: json['night_time'] as String?,
  agencyDepartureTimes: (json['agency_departure_times'] as List<dynamic>)
      .map((e) => AgencyDepartureTime.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$AgencyToJson(Agency instance) => <String, dynamic>{
  'id': instance.id,
  'agency_name': instance.agencyName,
  'city_name': instance.cityName,
  'agency_address': instance.agencyAddress,
  'agency_phone': instance.agencyPhone,
  'phone': instance.phone,
  'agency_avatar': instance.agencyAvatar,
  'agency_lat': instance.agencyLat,
  'agency_lng': instance.agencyLng,
  'morning_time': instance.morningTime,
  'night_time': instance.nightTime,
  'agency_departure_times': instance.agencyDepartureTimes,
};

AgencyDepartureTime _$AgencyDepartureTimeFromJson(Map<String, dynamic> json) =>
    AgencyDepartureTime(
      id: (json['id'] as num).toInt(),
      agencyId: (json['agency_id'] as num).toInt(),
      departureAt: json['departure_at'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      timeClassificationId: (json['time_classification_id'] as num?)?.toInt(),
      timeName: json['time_name'] as String?,
      timeClassification: json['time_classification'] == null
          ? null
          : TimeClassification.fromJson(
              json['time_classification'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$AgencyDepartureTimeToJson(
  AgencyDepartureTime instance,
) => <String, dynamic>{
  'id': instance.id,
  'agency_id': instance.agencyId,
  'departure_at': instance.departureAt,
  'created_at': instance.createdAt?.toIso8601String(),
  'updated_at': instance.updatedAt?.toIso8601String(),
  'time_classification_id': instance.timeClassificationId,
  'time_name': instance.timeName,
  'time_classification': instance.timeClassification,
};

TimeClassification _$TimeClassificationFromJson(Map<String, dynamic> json) =>
    TimeClassification(
      id: (json['id'] as num).toInt(),
      name: $enumDecode(_$NameEnumMap, json['name']),
      timeStart: json['time_start'] as String,
      timeEnd: json['time_end'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$TimeClassificationToJson(TimeClassification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': _$NameEnumMap[instance.name]!,
      'time_start': instance.timeStart,
      'time_end': instance.timeEnd,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };

const _$NameEnumMap = {
  Name.MALAM: 'Malam',
  Name.PAGI: 'Pagi',
  Name.SORE: 'Sore',
};
