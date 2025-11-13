// To parse this JSON data, do
//
//     final cityDepatureModel = cityDepatureModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'city_depature_model.g.dart';

CityDepatureModel cityDepatureModelFromJson(String str) => CityDepatureModel.fromJson(json.decode(str));

String cityDepatureModelToJson(CityDepatureModel data) => json.encode(data.toJson());

@JsonSerializable()
class CityDepatureModel {
  @JsonKey(name: "code")
  int code;
  @JsonKey(name: "success")
  bool success;
  @JsonKey(name: "message")
  String message;
  @JsonKey(name: "cities")
  List<City> cities;

  CityDepatureModel({
    required this.code,
    required this.success,
    required this.message,
    required this.cities,
  });

  factory CityDepatureModel.fromJson(Map<String, dynamic> json) => _$CityDepatureModelFromJson(json);

  Map<String, dynamic> toJson() => _$CityDepatureModelToJson(this);
}

@JsonSerializable()
class City {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "name")
  String name;
  @JsonKey(name: "province_id")
  int provinceId;
  @JsonKey(name: "area_id")
  int areaId;
  @JsonKey(name: "pg_id")
  String pgId;
  @JsonKey(name: "duration")
  dynamic duration;
  @JsonKey(name: "agent_count")
  int agentCount;

  City({
    required this.id,
    required this.name,
    required this.provinceId,
    required this.areaId,
    required this.pgId,
    required this.duration,
    required this.agentCount,
  });

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);

  Map<String, dynamic> toJson() => _$CityToJson(this);
}
