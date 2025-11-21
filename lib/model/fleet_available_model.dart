// To parse this JSON data, do
//
//     final fleetAvailableModel = fleetAvailableModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'fleet_available_model.g.dart';

FleetAvailableModel fleetAvailableModelFromJson(String str) => FleetAvailableModel.fromJson(json.decode(str));

String fleetAvailableModelToJson(FleetAvailableModel data) => json.encode(data.toJson());

@JsonSerializable()
class FleetAvailableModel {
  @JsonKey(name: "code")
  int code;
  @JsonKey(name: "success")
  bool success;
  @JsonKey(name: "message")
  String message;
  @JsonKey(name: "fleet_classes")
  List<FleetClass> fleetClasses;

  FleetAvailableModel({
    required this.code,
    required this.success,
    required this.message,
    required this.fleetClasses,
  });

  factory FleetAvailableModel.fromJson(Map<String, dynamic> json) => _$FleetAvailableModelFromJson(json);

  Map<String, dynamic> toJson() => _$FleetAvailableModelToJson(this);
}

@JsonSerializable()
class FleetClass {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "name")
  String name;
  @JsonKey(name: "price_food")
  String priceFood;
  @JsonKey(name: "seat_capacity")
  int seatCapacity;

  FleetClass({
    required this.id,
    required this.name,
    required this.priceFood,
    required this.seatCapacity,
  });

  factory FleetClass.fromJson(Map<String, dynamic> json) => _$FleetClassFromJson(json);

  Map<String, dynamic> toJson() => _$FleetClassToJson(this);
}
