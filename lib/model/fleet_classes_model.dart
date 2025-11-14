// To parse this JSON data, do
//
//     final fleetClassesModel = fleetClassesModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'fleet_classes_model.g.dart';

FleetClassesModel fleetClassesModelFromJson(String str) => FleetClassesModel.fromJson(json.decode(str));

String fleetClassesModelToJson(FleetClassesModel data) => json.encode(data.toJson());

@JsonSerializable()
class FleetClassesModel {
  @JsonKey(name: "code")
  int code;
  @JsonKey(name: "success")
  bool success;
  @JsonKey(name: "message")
  String message;
  @JsonKey(name: "fleet_classes")
  List<FleetClass> fleetClasses;

  FleetClassesModel({
    required this.code,
    required this.success,
    required this.message,
    required this.fleetClasses,
  });

  factory FleetClassesModel.fromJson(Map<String, dynamic> json) => _$FleetClassesModelFromJson(json);

  Map<String, dynamic> toJson() => _$FleetClassesModelToJson(this);
}

@JsonSerializable()
class FleetClass {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "name")
  String name;
  @JsonKey(name: "price_food")
  String priceFood;
  @JsonKey(name: "code")
  String code;
  @JsonKey(name: "fleets_count")
  int fleetsCount;
  @JsonKey(name: "price_fleet_class1")
  int priceFleetClass1;
  @JsonKey(name: "price_fleet_class2")
  int priceFleetClass2;
  @JsonKey(name: "seat_capacity")
  int seatCapacity;

  FleetClass({
    required this.id,
    required this.name,
    required this.priceFood,
    required this.code,
    required this.fleetsCount,
    required this.priceFleetClass1,
    required this.priceFleetClass2,
    required this.seatCapacity,
  });

  factory FleetClass.fromJson(Map<String, dynamic> json) => _$FleetClassFromJson(json);

  Map<String, dynamic> toJson() => _$FleetClassToJson(this);
}
