// To parse this JSON data, do
//
//     final pesanTiketModel = pesanTiketModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'pesan_tiket_model.g.dart';

PesanTiketModel pesanTiketModelFromJson(String str) => PesanTiketModel.fromJson(json.decode(str));

String pesanTiketModelToJson(PesanTiketModel data) => json.encode(data.toJson());

@JsonSerializable()
class PesanTiketModel {
  @JsonKey(name: "code")
  int code;
  @JsonKey(name: "success")
  bool success;
  @JsonKey(name: "message")
  String message;
  @JsonKey(name: "cities")
  List<City> cities;

  PesanTiketModel({
    required this.code,
    required this.success,
    required this.message,
    required this.cities,
  });

  factory PesanTiketModel.fromJson(Map<String, dynamic> json) => _$PesanTiketModelFromJson(json);

  Map<String, dynamic> toJson() => _$PesanTiketModelToJson(this);
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
  String? pgId;
  @JsonKey(name: "duration")
  int? duration;
  @JsonKey(name: "agent_count")
  int agentCount;

  City({
    required this.id,
    required this.name,
    required this.provinceId,
    required this.areaId,
    this.pgId,
    this.duration,
    required this.agentCount,
  });

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);

  Map<String, dynamic> toJson() => _$CityToJson(this);
}
