// To parse this JSON data, do
//
//     final allCitiesModel = allCitiesModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'all_cities_model.g.dart';

AllCitiesModel allCitiesModelFromJson(String str) => AllCitiesModel.fromJson(json.decode(str));

String allCitiesModelToJson(AllCitiesModel data) => json.encode(data.toJson());

@JsonSerializable()
class AllCitiesModel {
  @JsonKey(name: "code")
  int code;
  @JsonKey(name: "success")
  bool success;
  @JsonKey(name: "message")
  String message;
  @JsonKey(name: "cities")
  List<City> cities;

  AllCitiesModel({
    required this.code,
    required this.success,
    required this.message,
    required this.cities,
  });

  factory AllCitiesModel.fromJson(Map<String, dynamic> json) => _$AllCitiesModelFromJson(json);

  Map<String, dynamic> toJson() => _$AllCitiesModelToJson(this);
}

@JsonSerializable()
class City {
  @JsonKey(name: "id")
  final int id;

  @JsonKey(name: "name")
  final String name;

  @JsonKey(name: "province_id")
  final int? provinceId;

  @JsonKey(name: "area_id")
  final int areaId;

  @JsonKey(name: "pg_id")
  final String? pgId;

  @JsonKey(name: "duration")
  final int? duration;

  @JsonKey(name: "agent_count")
  final int? agentCount;

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

