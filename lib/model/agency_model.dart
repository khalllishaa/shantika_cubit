import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'agency_model.g.dart';

AgencyModel agencyModelFromJson(String str) => AgencyModel.fromJson(json.decode(str));
String agencyModelToJson(AgencyModel data) => json.encode(data.toJson());

@JsonSerializable()
class AgencyModel {
  @JsonKey(name: "code")
  final int code;
  @JsonKey(name: "success")
  final bool success;
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "agencies")
  final List<Agency>? agencies;

  AgencyModel({
    required this.code,
    required this.success,
    this.message,
    this.agencies,
  });

  factory AgencyModel.fromJson(Map<String, dynamic> json) => _$AgencyModelFromJson(json);
  Map<String, dynamic> toJson() => _$AgencyModelToJson(this);
}

@JsonSerializable()
class Agency {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "agency_name")
  final String? agencyName;
  @JsonKey(name: "city_name")
  final String? cityName;
  @JsonKey(name: "agency_address")
  final String? agencyAddress;
  @JsonKey(name: "agency_phone")
  final String? agencyPhone;
  @JsonKey(name: "phone")
  final List<String>? phone;
  @JsonKey(name: "agency_avatar")
  final AgencyAvatar? agencyAvatar;
  @JsonKey(name: "agency_lat")
  final String? agencyLat;
  @JsonKey(name: "agency_lng")
  final String? agencyLng;
  @JsonKey(name: "morning_time")
  final String? morningTime;
  @JsonKey(name: "night_time")
  final String? nightTime;
  @JsonKey(name: "agency_departure_times")
  final List<AgencyDepartureTime>? agencyDepartureTimes;

  Agency({
    this.id,
    this.agencyName,
    this.cityName,
    this.agencyAddress,
    this.agencyPhone,
    this.phone,
    this.agencyAvatar,
    this.agencyLat,
    this.agencyLng,
    this.morningTime,
    this.nightTime,
    this.agencyDepartureTimes,
  });

  factory Agency.fromJson(Map<String, dynamic> json) => _$AgencyFromJson(json);
  Map<String, dynamic> toJson() => _$AgencyToJson(this);
}

enum AgencyAvatar {
  @JsonValue("/avatar/KbzwboL5uHghGdeJyTyJrEWdWwWfw1DlkJXDCrwl.jpg")
  AVATAR_KBZWBO,
  @JsonValue("")
  EMPTY,
}

@JsonSerializable()
class AgencyDepartureTime {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "agency_id")
  final int? agencyId;
  @JsonKey(name: "departure_at")
  final String? departureAt;
  @JsonKey(name: "created_at")
  final String? createdAt;
  @JsonKey(name: "updated_at")
  final String? updatedAt;
  @JsonKey(name: "time_classification_id")
  final int? timeClassificationId;
  @JsonKey(name: "time_name")
  final String? timeName;
  @JsonKey(name: "time_classification")
  final TimeClassification? timeClassification;

  AgencyDepartureTime({
    this.id,
    this.agencyId,
    this.departureAt,
    this.createdAt,
    this.updatedAt,
    this.timeClassificationId,
    this.timeName,
    this.timeClassification,
  });

  factory AgencyDepartureTime.fromJson(Map<String, dynamic> json) =>
      _$AgencyDepartureTimeFromJson(json);
  Map<String, dynamic> toJson() => _$AgencyDepartureTimeToJson(this);
}

@JsonSerializable()
class TimeClassification {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "time_start")
  final String? timeStart;
  @JsonKey(name: "time_end")
  final String? timeEnd;
  @JsonKey(name: "created_at")
  final String? createdAt;
  @JsonKey(name: "updated_at")
  final String? updatedAt;

  TimeClassification({
    this.id,
    this.name,
    this.timeStart,
    this.timeEnd,
    this.createdAt,
    this.updatedAt,
  });

  factory TimeClassification.fromJson(Map<String, dynamic> json) =>
      _$TimeClassificationFromJson(json);
  Map<String, dynamic> toJson() => _$TimeClassificationToJson(this);
}