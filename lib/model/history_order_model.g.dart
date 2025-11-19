// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryOrderModel _$HistoryOrderModelFromJson(Map<String, dynamic> json) =>
    HistoryOrderModel(
      code: (json['code'] as num).toInt(),
      success: json['success'] as bool,
      message: json['message'] as String,
      order: (json['order'] as List<dynamic>)
          .map((e) => Order.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HistoryOrderModelToJson(HistoryOrderModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'success': instance.success,
      'message': instance.message,
      'order': instance.order,
    };

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
  id: (json['id'] as num).toInt(),
  codeOrder: json['code_order'] as String,
  nameFleet: json['name_fleet'] as String,
  fleetClass: json['fleet_class'] as String,
  createdAt: json['created_at'] as String,
  departureAt: json['departure_at'] as String,
  price: (json['price'] as num).toInt(),
  status: json['status'] as String,
  checkpoints: Checkpoints.fromJson(
    json['checkpoints'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
  'id': instance.id,
  'code_order': instance.codeOrder,
  'name_fleet': instance.nameFleet,
  'fleet_class': instance.fleetClass,
  'created_at': instance.createdAt,
  'departure_at': instance.departureAt,
  'price': instance.price,
  'status': instance.status,
  'checkpoints': instance.checkpoints,
};

Checkpoints _$CheckpointsFromJson(Map<String, dynamic> json) => Checkpoints(
  start: CheckpointDetail.fromJson(json['start'] as Map<String, dynamic>),
  destination: CheckpointDetail.fromJson(
    json['destination'] as Map<String, dynamic>,
  ),
  end: CheckpointDetail.fromJson(json['end'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CheckpointsToJson(Checkpoints instance) =>
    <String, dynamic>{
      'start': instance.start,
      'destination': instance.destination,
      'end': instance.end,
    };

CheckpointDetail _$CheckpointDetailFromJson(Map<String, dynamic> json) =>
    CheckpointDetail(
      agencyId: (json['agency_id'] as num).toInt(),
      agencyName: json['agency_name'] as String,
      agencyAddress: json['agency_address'] as String,
      agencyPhone: json['agency_phone'] as String,
      agencyLat: json['agency_lat'] as String,
      agencyLng: json['agency_lng'] as String,
      cityName: json['city_name'] as String,
    );

Map<String, dynamic> _$CheckpointDetailToJson(CheckpointDetail instance) =>
    <String, dynamic>{
      'agency_id': instance.agencyId,
      'agency_name': instance.agencyName,
      'agency_address': instance.agencyAddress,
      'agency_phone': instance.agencyPhone,
      'agency_lat': instance.agencyLat,
      'agency_lng': instance.agencyLng,
      'city_name': instance.cityName,
    };
