// To parse this JSON data, do
//
//     final historyOrderModel = historyOrderModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'history_order_model.g.dart';

HistoryOrderModel historyOrderModelFromJson(String str) =>
    HistoryOrderModel.fromJson(json.decode(str));

String historyOrderModelToJson(HistoryOrderModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class HistoryOrderModel {
  @JsonKey(name: "code")
  final int code;

  @JsonKey(name: "success")
  final bool success;

  @JsonKey(name: "message")
  final String message;

  @JsonKey(name: "order")
  final List<Order> order;

  HistoryOrderModel({
    required this.code,
    required this.success,
    required this.message,
    required this.order,
  });

  factory HistoryOrderModel.fromJson(Map<String, dynamic> json) =>
      _$HistoryOrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryOrderModelToJson(this);
}

@JsonSerializable()
class Order {
  @JsonKey(name: "id")
  final int id;

  @JsonKey(name: "code_order")
  final String codeOrder;

  @JsonKey(name: "name_fleet")
  final String nameFleet;

  @JsonKey(name: "fleet_class")
  final String fleetClass;

  @JsonKey(name: "created_at")
  final String createdAt;

  @JsonKey(name: "departure_at")
  final String departureAt;

  @JsonKey(name: "price")
  final int price;

  @JsonKey(name: "status")
  final String status;

  @JsonKey(name: "checkpoints")
  final Checkpoints checkpoints;

  Order({
    required this.id,
    required this.codeOrder,
    required this.nameFleet,
    required this.fleetClass,
    required this.createdAt,
    required this.departureAt,
    required this.price,
    required this.status,
    required this.checkpoints,
  });

  DateTime get createdAtDateTime {
    try {
      return DateTime.parse(createdAt.replaceFirst(' ', 'T'));
    } catch (e) {
      return DateTime.now();
    }
  }

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}

@JsonSerializable()
class Checkpoints {
  @JsonKey(name: "start")
  final CheckpointDetail start;

  @JsonKey(name: "destination")
  final CheckpointDetail destination;

  @JsonKey(name: "end")
  final CheckpointDetail end;

  Checkpoints({
    required this.start,
    required this.destination,
    required this.end,
  });

  factory Checkpoints.fromJson(Map<String, dynamic> json) =>
      _$CheckpointsFromJson(json);

  Map<String, dynamic> toJson() => _$CheckpointsToJson(this);
}

@JsonSerializable()
class CheckpointDetail {
  @JsonKey(name: "agency_id")
  final int agencyId;

  @JsonKey(name: "agency_name")
  final String agencyName;

  @JsonKey(name: "agency_address")
  final String agencyAddress;

  @JsonKey(name: "agency_phone")
  final String agencyPhone;

  @JsonKey(name: "agency_lat")
  final String agencyLat;

  @JsonKey(name: "agency_lng")
  final String agencyLng;

  @JsonKey(name: "city_name")
  final String cityName;

  CheckpointDetail({
    required this.agencyId,
    required this.agencyName,
    required this.agencyAddress,
    required this.agencyPhone,
    required this.agencyLat,
    required this.agencyLng,
    required this.cityName,
  });

  factory CheckpointDetail.fromJson(Map<String, dynamic> json) =>
      _$CheckpointDetailFromJson(json);

  Map<String, dynamic> toJson() => _$CheckpointDetailToJson(this);
}