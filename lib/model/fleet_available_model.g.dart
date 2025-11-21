// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fleet_available_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FleetAvailableModel _$FleetAvailableModelFromJson(Map<String, dynamic> json) =>
    FleetAvailableModel(
      code: (json['code'] as num).toInt(),
      success: json['success'] as bool,
      message: json['message'] as String,
      fleetClasses: (json['fleet_classes'] as List<dynamic>)
          .map((e) => FleetClass.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FleetAvailableModelToJson(
  FleetAvailableModel instance,
) => <String, dynamic>{
  'code': instance.code,
  'success': instance.success,
  'message': instance.message,
  'fleet_classes': instance.fleetClasses,
};

FleetClass _$FleetClassFromJson(Map<String, dynamic> json) => FleetClass(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  priceFood: json['price_food'] as String,
  seatCapacity: (json['seat_capacity'] as num).toInt(),
);

Map<String, dynamic> _$FleetClassToJson(FleetClass instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price_food': instance.priceFood,
      'seat_capacity': instance.seatCapacity,
    };
