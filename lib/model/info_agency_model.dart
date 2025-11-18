// To parse this JSON data, do
//
//     final infoAgencyModel = infoAgencyModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'info_agency_model.g.dart';

InfoAgencyModel infoAgencyModelFromJson(String str) => InfoAgencyModel.fromJson(json.decode(str));

String infoAgencyModelToJson(InfoAgencyModel data) => json.encode(data.toJson());

@JsonSerializable()
class InfoAgencyModel {
  @JsonKey(name: "code")
  int code;
  @JsonKey(name: "success")
  bool success;
  @JsonKey(name: "message")
  String message;
  @JsonKey(name: "agencies")
  List<Agency> agencies;

  InfoAgencyModel({
    required this.code,
    required this.success,
    required this.message,
    required this.agencies,
  });

  factory InfoAgencyModel.fromJson(Map<String, dynamic> json) => _$InfoAgencyModelFromJson(json);

  Map<String, dynamic> toJson() => _$InfoAgencyModelToJson(this);
}

@JsonSerializable()
class Agency {
  @JsonKey(name: "id")
  int id;

  @JsonKey(name: "agency_name")
  String agencyName;

  @JsonKey(name: "city_name")
  String cityName;

  @JsonKey(name: "agency_address")
  String agencyAddress;

  @JsonKey(name: "agency_phone")
  String agencyPhone;

  @JsonKey(name: "phone")
  List<String> phone;

  @JsonKey(name: "agency_avatar")
  String? agencyAvatar;

  @JsonKey(name: "agency_lat")
  String? agencyLat;

  @JsonKey(name: "agency_lng")
  String? agencyLng;

  @JsonKey(name: "morning_time")
  String? morningTime;

  @JsonKey(name: "night_time")
  String? nightTime;

  @JsonKey(name: "agency_departure_times")
  List<AgencyDepartureTime> agencyDepartureTimes;

  Agency({
    required this.id,
    required this.agencyName,
    required this.cityName,
    required this.agencyAddress,
    required this.agencyPhone,
    required this.phone,
    this.agencyAvatar,
    this.agencyLat,
    this.agencyLng,
    this.morningTime,
    this.nightTime,
    required this.agencyDepartureTimes,
  });

  factory Agency.fromJson(Map<String, dynamic> json) => _$AgencyFromJson(json);
  Map<String, dynamic> toJson() => _$AgencyToJson(this);
}

enum AgencyAvatar {
  @JsonValue("/avatar/KbzwboL5uHghGdeJyTyJrEWdWwWfw1DlkJXDCrwl.jpg")
  AVATAR_KBZWBO_L5_U_HGH_GDE_JY_TY_JR_E_WD_WW_WFW1_DLK_JXD_CRWL_JPG,
  @JsonValue("")
  EMPTY
}

final agencyAvatarValues = EnumValues({
  "/avatar/KbzwboL5uHghGdeJyTyJrEWdWwWfw1DlkJXDCrwl.jpg": AgencyAvatar.AVATAR_KBZWBO_L5_U_HGH_GDE_JY_TY_JR_E_WD_WW_WFW1_DLK_JXD_CRWL_JPG,
  "": AgencyAvatar.EMPTY
});

@JsonSerializable()
class AgencyDepartureTime {
  @JsonKey(name: "id")
  int id;

  @JsonKey(name: "agency_id")
  int agencyId;

  @JsonKey(name: "departure_at")
  String? departureAt;  // 🔧 Changed to nullable

  @JsonKey(name: "created_at")
  DateTime? createdAt;  // 🔧 Changed to nullable

  @JsonKey(name: "updated_at")
  DateTime? updatedAt;  // 🔧 Changed to nullable

  @JsonKey(name: "time_classification_id")
  int? timeClassificationId;  // 🔧 Changed to nullable

  @JsonKey(name: "time_name")
  String? timeName;  // 🔧 Changed to nullable - THIS WAS THE MAIN ISSUE

  @JsonKey(name: "time_classification")
  TimeClassification? timeClassification;  // 🔧 Changed to nullable

  AgencyDepartureTime({
    required this.id,
    required this.agencyId,
    this.departureAt,
    this.createdAt,
    this.updatedAt,
    this.timeClassificationId,
    this.timeName,
    this.timeClassification,
  });

  factory AgencyDepartureTime.fromJson(Map<String, dynamic> json) => _$AgencyDepartureTimeFromJson(json);

  Map<String, dynamic> toJson() => _$AgencyDepartureTimeToJson(this);
}

@JsonSerializable()
class TimeClassification {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "name")
  Name name;
  @JsonKey(name: "time_start")
  String timeStart;
  @JsonKey(name: "time_end")
  String timeEnd;
  @JsonKey(name: "created_at")
  DateTime createdAt;
  @JsonKey(name: "updated_at")
  DateTime updatedAt;

  TimeClassification({
    required this.id,
    required this.name,
    required this.timeStart,
    required this.timeEnd,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TimeClassification.fromJson(Map<String, dynamic> json) => _$TimeClassificationFromJson(json);

  Map<String, dynamic> toJson() => _$TimeClassificationToJson(this);
}

enum Name {
  @JsonValue("Malam")
  MALAM,
  @JsonValue("Pagi")
  PAGI,
  @JsonValue("Sore")
  SORE
}

final nameValues = EnumValues({
  "Malam": Name.MALAM,
  "Pagi": Name.PAGI,
  "Sore": Name.SORE
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}