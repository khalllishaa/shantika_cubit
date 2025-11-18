// To parse this JSON data, do
//
//     final timeModel = timeModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'time_model.g.dart';

TimeModel timeModelFromJson(String str) => TimeModel.fromJson(json.decode(str));

String timeModelToJson(TimeModel data) => json.encode(data.toJson());

@JsonSerializable()
class TimeModel {
  @JsonKey(name: "code")
  int code;
  @JsonKey(name: "success")
  bool success;
  @JsonKey(name: "message")
  String message;
  @JsonKey(name: "time")
  List<Time> time;
  @JsonKey(name: "d")
  String d;

  TimeModel({
    required this.code,
    required this.success,
    required this.message,
    required this.time,
    required this.d,
  });

  factory TimeModel.fromJson(Map<String, dynamic> json) => _$TimeModelFromJson(json);

  Map<String, dynamic> toJson() => _$TimeModelToJson(this);
}

@JsonSerializable()
class Time {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "name")
  String name;
  @JsonKey(name: "time_start")
  String timeStart;
  @JsonKey(name: "time_end")
  String timeEnd;
  @JsonKey(name: "created_at")
  DateTime createdAt;
  @JsonKey(name: "updated_at")
  DateTime updatedAt;

  Time({
    required this.id,
    required this.name,
    required this.timeStart,
    required this.timeEnd,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Time.fromJson(Map<String, dynamic> json) => _$TimeFromJson(json);

  Map<String, dynamic> toJson() => _$TimeToJson(this);
}
