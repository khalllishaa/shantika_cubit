// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fleet_classes_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FleetClassesModel _$FleetClassesModelFromJson(Map<String, dynamic> json) =>
    FleetClassesModel(
      code: (json['code'] as num).toInt(),
      success: json['success'] as bool,
      message: json['message'] as String,
      fleetClasses: (json['fleet_classes'] as List<dynamic>)
          .map((e) => FleetClass.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FleetClassesModelToJson(FleetClassesModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'success': instance.success,
      'message': instance.message,
      'fleet_classes': instance.fleetClasses,
    };

FleetClass _$FleetClassFromJson(Map<String, dynamic> json) => FleetClass(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  priceFood: json['price_food'] as String,
  code: json['code'] as String,
  fleetsCount: (json['fleets_count'] as num).toInt(),
  priceFleetClass1: (json['price_fleet_class1'] as num).toInt(),
  priceFleetClass2: (json['price_fleet_class2'] as num).toInt(),
  seatCapacity: (json['seat_capacity'] as num).toInt(),
);

Map<String, dynamic> _$FleetClassToJson(FleetClass instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price_food': instance.priceFood,
      'code': instance.code,
      'fleets_count': instance.fleetsCount,
      'price_fleet_class1': instance.priceFleetClass1,
      'price_fleet_class2': instance.priceFleetClass2,
      'seat_capacity': instance.seatCapacity,
    };
