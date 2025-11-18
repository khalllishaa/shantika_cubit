import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'fleet_detail_model.g.dart';

FleetDetailResponse fleetDetailResponseFromJson(String str) =>
    FleetDetailResponse.fromJson(json.decode(str));

String fleetDetailResponseToJson(FleetDetailResponse data) =>
    json.encode(data.toJson());

@JsonSerializable()
class FleetDetailResponse {
  @JsonKey(name: "code")
  int code;

  @JsonKey(name: "success")
  bool success;

  @JsonKey(name: "message")
  String message;

  @JsonKey(name: "fleet_detail")
  FleetDetail fleetDetail;

  FleetDetailResponse({
    required this.code,
    required this.success,
    required this.message,
    required this.fleetDetail,
  });

  factory FleetDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$FleetDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FleetDetailResponseToJson(this);
}

@JsonSerializable()
class FleetDetail {
  @JsonKey(name: "id")
  int id;

  @JsonKey(name: "name")
  String name;

  @JsonKey(name: "description")
  String description;

  @JsonKey(name: "image")
  String image;

  @JsonKey(name: "images")
  List<String> images;

  @JsonKey(name: "fleet_class")
  String fleetClass;

  @JsonKey(name: "total_chair")
  int totalChair;

  @JsonKey(name: "estimate_time")
  String estimateTime;

  @JsonKey(name: "facilities")
  List<Facility> facilities;

  @JsonKey(name: "route")
  List<dynamic> route;

  FleetDetail({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.images,
    required this.fleetClass,
    required this.totalChair,
    required this.estimateTime,
    required this.facilities,
    required this.route,
  });

  factory FleetDetail.fromJson(Map<String, dynamic> json) =>
      _$FleetDetailFromJson(json);

  Map<String, dynamic> toJson() => _$FleetDetailToJson(this);
}

@JsonSerializable()
class Facility {
  @JsonKey(name: "id")
  int id;

  @JsonKey(name: "name")
  String name;

  @JsonKey(name: "image")
  String image;

  @JsonKey(name: "created_at")
  String createdAt;

  @JsonKey(name: "updated_at")
  String updatedAt;

  Facility({
    required this.id,
    required this.name,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Facility.fromJson(Map<String, dynamic> json) =>
      _$FacilityFromJson(json);

  Map<String, dynamic> toJson() => _$FacilityToJson(this);
}