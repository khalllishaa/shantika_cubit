// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agency_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AgencyModel _$AgencyModelFromJson(Map<String, dynamic> json) => AgencyModel(
  code: (json['code'] as num).toInt(),
  success: json['success'] as bool,
  message: json['message'] as String?,
  agencies: (json['agencies'] as List<dynamic>?)
      ?.map((e) => Agency.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$AgencyModelToJson(AgencyModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'success': instance.success,
      'message': instance.message,
      'agencies': instance.agencies,
    };

Agency _$AgencyFromJson(Map<String, dynamic> json) => Agency(
  id: (json['id'] as num?)?.toInt(),
  agencyName: json['agency_name'] as String?,
  cityName: json['city_name'] as String?,
  agencyAddress: json['agency_address'] as String?,
  agencyPhone: json['agency_phone'] as String?,
  phone: (json['phone'] as List<dynamic>?)?.map((e) => e as String).toList(),
  agencyAvatar: $enumDecodeNullable(
    _$AgencyAvatarEnumMap,
    json['agency_avatar'],
  ),
  agencyLat: json['agency_lat'] as String?,
  agencyLng: json['agency_lng'] as String?,
  morningTime: json['morning_time'] as String?,
  nightTime: json['night_time'] as String?,
  agencyDepartureTimes: (json['agency_departure_times'] as List<dynamic>?)
      ?.map((e) => AgencyDepartureTime.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$AgencyToJson(Agency instance) => <String, dynamic>{
  'id': instance.id,
  'agency_name': instance.agencyName,
  'city_name': instance.cityName,
  'agency_address': instance.agencyAddress,
  'agency_phone': instance.agencyPhone,
  'phone': instance.phone,
  'agency_avatar': _$AgencyAvatarEnumMap[instance.agencyAvatar],
  'agency_lat': instance.agencyLat,
  'agency_lng': instance.agencyLng,
  'morning_time': instance.morningTime,
  'night_time': instance.nightTime,
  'agency_departure_times': instance.agencyDepartureTimes,
};

const _$AgencyAvatarEnumMap = {
  AgencyAvatar.AVATAR_KBZWBO:
      '/avatar/KbzwboL5uHghGdeJyTyJrEWdWwWfw1DlkJXDCrwl.jpg',
  AgencyAvatar.EMPTY: '',
};

AgencyDepartureTime _$AgencyDepartureTimeFromJson(Map<String, dynamic> json) =>
    AgencyDepartureTime(
      id: (json['id'] as num?)?.toInt(),
      agencyId: (json['agency_id'] as num?)?.toInt(),
      departureAt: json['departure_at'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
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
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
  'time_classification_id': instance.timeClassificationId,
  'time_name': instance.timeName,
  'time_classification': instance.timeClassification,
};

TimeClassification _$TimeClassificationFromJson(Map<String, dynamic> json) =>
    TimeClassification(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      timeStart: json['time_start'] as String?,
      timeEnd: json['time_end'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$TimeClassificationToJson(TimeClassification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'time_start': instance.timeStart,
      'time_end': instance.timeEnd,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
