// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeModel _$TimeModelFromJson(Map<String, dynamic> json) => TimeModel(
  code: (json['code'] as num).toInt(),
  success: json['success'] as bool,
  message: json['message'] as String,
  time: (json['time'] as List<dynamic>)
      .map((e) => Time.fromJson(e as Map<String, dynamic>))
      .toList(),
  d: json['d'] as String,
);

Map<String, dynamic> _$TimeModelToJson(TimeModel instance) => <String, dynamic>{
  'code': instance.code,
  'success': instance.success,
  'message': instance.message,
  'time': instance.time,
  'd': instance.d,
};

Time _$TimeFromJson(Map<String, dynamic> json) => Time(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  timeStart: json['time_start'] as String,
  timeEnd: json['time_end'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$TimeToJson(Time instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'time_start': instance.timeStart,
  'time_end': instance.timeEnd,
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
};
