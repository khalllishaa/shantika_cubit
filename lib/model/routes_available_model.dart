// To parse this JSON data, do
//
//     final routesAvailableModel = routesAvailableModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'routes_available_model.g.dart';

RoutesAvailableModel routesAvailableModelFromJson(String str) => RoutesAvailableModel.fromJson(json.decode(str));

String routesAvailableModelToJson(RoutesAvailableModel data) => json.encode(data.toJson());

@JsonSerializable()
class RoutesAvailableModel {
  @JsonKey(name: "code")
  int code;
  @JsonKey(name: "success")
  bool success;
  @JsonKey(name: "message")
  String message;
  @JsonKey(name: "routes")
  List<Route> routes;

  RoutesAvailableModel({
    required this.code,
    required this.success,
    required this.message,
    required this.routes,
  });

  factory RoutesAvailableModel.fromJson(Map<String, dynamic> json) => _$RoutesAvailableModelFromJson(json);

  Map<String, dynamic> toJson() => _$RoutesAvailableModelToJson(this);
}

@JsonSerializable()
class Route {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "layout_id")
  int layoutId;
  @JsonKey(name: "route_name")
  String routeName;
  @JsonKey(name: "fleet_name")
  String fleetName;
  @JsonKey(name: "fleet_detail_time")
  String fleetDetailTime;
  @JsonKey(name: "fleet_class")
  String fleetClass;
  @JsonKey(name: "departure_at")
  String departureAt;
  @JsonKey(name: "price")
  int price;
  @JsonKey(name: "agency_id")
  int agencyId;
  @JsonKey(name: "chairs_available")
  int chairsAvailable;
  @JsonKey(name: "checkpoints")
  Checkpoints checkpoints;

  Route({
    required this.id,
    required this.layoutId,
    required this.routeName,
    required this.fleetName,
    required this.fleetDetailTime,
    required this.fleetClass,
    required this.departureAt,
    required this.price,
    required this.agencyId,
    required this.chairsAvailable,
    required this.checkpoints,
  });

  factory Route.fromJson(Map<String, dynamic> json) => _$RouteFromJson(json);

  Map<String, dynamic> toJson() => _$RouteToJson(this);
}

@JsonSerializable()
class Checkpoints {
  @JsonKey(name: "start")
  Destination start;
  @JsonKey(name: "destination")
  Destination destination;
  @JsonKey(name: "end")
  Destination end;

  Checkpoints({
    required this.start,
    required this.destination,
    required this.end,
  });

  factory Checkpoints.fromJson(Map<String, dynamic> json) => _$CheckpointsFromJson(json);

  Map<String, dynamic> toJson() => _$CheckpointsToJson(this);
}

@JsonSerializable()
class Destination {
  @JsonKey(name: "agency_id")
  int agencyId;
  @JsonKey(name: "agency_name")
  String agencyName;
  @JsonKey(name: "agency_address")
  String agencyAddress;
  @JsonKey(name: "agency_phone")
  String agencyPhone;
  @JsonKey(name: "agency_lat")
  String agencyLat;
  @JsonKey(name: "agency_lng")
  String agencyLng;
  @JsonKey(name: "city_name")
  String cityName;

  Destination({
    required this.agencyId,
    required this.agencyName,
    required this.agencyAddress,
    required this.agencyPhone,
    required this.agencyLat,
    required this.agencyLng,
    required this.cityName,
  });

  factory Destination.fromJson(Map<String, dynamic> json) => _$DestinationFromJson(json);

  Map<String, dynamic> toJson() => _$DestinationToJson(this);
}
