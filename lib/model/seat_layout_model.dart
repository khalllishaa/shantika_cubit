// To parse this JSON data, do
//
//     final seatLayoutModel = seatLayoutModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'seat_layout_model.g.dart';

SeatLayoutModel seatLayoutModelFromJson(String str) =>
    SeatLayoutModel.fromJson(json.decode(str));

String seatLayoutModelToJson(SeatLayoutModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class SeatLayoutModel {
  @JsonKey(name: "code")
  int code;
  @JsonKey(name: "success")
  bool success;
  @JsonKey(name: "message")
  String message;
  @JsonKey(name: "data")
  SeatLayoutData data;

  SeatLayoutModel({
    required this.code,
    required this.success,
    required this.message,
    required this.data,
  });

  factory SeatLayoutModel.fromJson(Map<String, dynamic> json) =>
      _$SeatLayoutModelFromJson(json);

  Map<String, dynamic> toJson() => _$SeatLayoutModelToJson(this);
}

@JsonSerializable()
class SeatLayoutData {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "name")
  Name name;
  @JsonKey(name: "row")
  int row;
  @JsonKey(name: "col")
  int col;
  @JsonKey(name: "upper_row")
  int upperRow;
  @JsonKey(name: "upper_col")
  int upperCol;
  @JsonKey(name: "space_indexes")
  List<int> spaceIndexes;
  @JsonKey(name: "upper_space_indexes")
  List<dynamic> upperSpaceIndexes;
  @JsonKey(name: "toilet_indexes")
  List<int> toiletIndexes;
  @JsonKey(name: "upper_toilet_indexes")
  List<dynamic> upperToiletIndexes;
  @JsonKey(name: "door_indexes")
  List<int> doorIndexes;
  @JsonKey(name: "upper_door_indexes")
  List<dynamic> upperDoorIndexes;
  @JsonKey(name: "note")
  Note note;
  @JsonKey(name: "total_indexes")
  int totalIndexes;
  @JsonKey(name: "total_upper_indexs")
  dynamic totalUpperIndexs;
  @JsonKey(name: "chairs")
  List<Chair> chairs;
  @JsonKey(name: "upper_chairs")
  List<dynamic> upperChairs;

  SeatLayoutData({
    required this.id,
    required this.name,
    required this.row,
    required this.col,
    required this.upperRow,
    required this.upperCol,
    required this.spaceIndexes,
    required this.upperSpaceIndexes,
    required this.toiletIndexes,
    required this.upperToiletIndexes,
    required this.doorIndexes,
    required this.upperDoorIndexes,
    required this.note,
    required this.totalIndexes,
    required this.totalUpperIndexs,
    required this.chairs,
    required this.upperChairs,
  });

  factory SeatLayoutData.fromJson(Map<String, dynamic> json) =>
      _$SeatLayoutDataFromJson(json);

  Map<String, dynamic> toJson() => _$SeatLayoutDataToJson(this);
}

@JsonSerializable()
class Chair {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "name")
  String name;
  @JsonKey(name: "index")
  int index;
  @JsonKey(name: "deleted_at")
  dynamic deletedAt;
  @JsonKey(name: "seat_type")
  SeatType seatType;
  @JsonKey(name: "position")
  Position position;
  @JsonKey(name: "is_blocked")
  bool isBlocked;
  @JsonKey(name: "is_blocked_only_agency")
  bool isBlockedOnlyAgency;
  @JsonKey(name: "is_booking")
  bool isBooking;
  @JsonKey(name: "is_unavailable_customer")
  bool isUnavailableCustomer;
  @JsonKey(name: "is_unavailable")
  bool isUnavailable;
  @JsonKey(name: "is_unavailable_not_paid_customer")
  bool isUnavailableNotPaidCustomer;
  @JsonKey(name: "is_unavailable_waiting_customer")
  bool isUnavailableWaitingCustomer;
  @JsonKey(name: "is_mine")
  bool isMine;
  @JsonKey(name: "price")
  int price;
  @JsonKey(name: "is_space")
  bool isSpace;
  @JsonKey(name: "is_door")
  bool isDoor;
  @JsonKey(name: "is_toilet")
  bool isToilet;
  @JsonKey(name: "layout")
  Layout layout;

  Chair({
    required this.id,
    required this.name,
    required this.index,
    required this.deletedAt,
    required this.seatType,
    required this.position,
    required this.isBlocked,
    required this.isBlockedOnlyAgency,
    required this.isBooking,
    required this.isUnavailableCustomer,
    required this.isUnavailable,
    required this.isUnavailableNotPaidCustomer,
    required this.isUnavailableWaitingCustomer,
    required this.isMine,
    required this.price,
    required this.isSpace,
    required this.isDoor,
    required this.isToilet,
    required this.layout,
  });

  factory Chair.fromJson(Map<String, dynamic> json) =>
      _$ChairFromJson(json);

  Map<String, dynamic> toJson() => _$ChairToJson(this);
}

@JsonSerializable()
class Layout {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "name")
  Name name;
  @JsonKey(name: "row")
  int row;
  @JsonKey(name: "col")
  int col;
  @JsonKey(name: "space_indexes")
  List<int> spaceIndexes;
  @JsonKey(name: "toilet_indexes")
  List<int> toiletIndexes;
  @JsonKey(name: "door_indexes")
  List<int> doorIndexes;
  @JsonKey(name: "note")
  Note note;
  @JsonKey(name: "deleted_at")
  dynamic deletedAt;
  @JsonKey(name: "code")
  Name code;
  @JsonKey(name: "type")
  Type type;
  @JsonKey(name: "upper_col")
  int upperCol;
  @JsonKey(name: "upper_row")
  int upperRow;
  @JsonKey(name: "upper_space_indexes")
  List<dynamic> upperSpaceIndexes;
  @JsonKey(name: "upper_toilet_indexes")
  List<dynamic> upperToiletIndexes;
  @JsonKey(name: "upper_door_indexes")
  List<dynamic> upperDoorIndexes;
  @JsonKey(name: "total_indexes")
  int totalIndexes;
  @JsonKey(name: "total_chairs")
  int totalChairs;
  @JsonKey(name: "total_upper_indexes")
  int totalUpperIndexes;
  @JsonKey(name: "total_upper_chairs")
  int totalUpperChairs;
  @JsonKey(name: "total_lower_chairs")
  int totalLowerChairs;

  Layout({
    required this.id,
    required this.name,
    required this.row,
    required this.col,
    required this.spaceIndexes,
    required this.toiletIndexes,
    required this.doorIndexes,
    required this.note,
    required this.deletedAt,
    required this.code,
    required this.type,
    required this.upperCol,
    required this.upperRow,
    required this.upperSpaceIndexes,
    required this.upperToiletIndexes,
    required this.upperDoorIndexes,
    required this.totalIndexes,
    required this.totalChairs,
    required this.totalUpperIndexes,
    required this.totalUpperChairs,
    required this.totalLowerChairs,
  });

  factory Layout.fromJson(Map<String, dynamic> json) =>
      _$LayoutFromJson(json);

  Map<String, dynamic> toJson() => _$LayoutToJson(this);
}

// ENUMS

enum Name {
  @JsonValue("Executive")
  EXECUTIVE
}

enum Note {
  @JsonValue("JANGAN DIHAPUS (oke)")
  JANGAN_DIHAPUS_OKE
}

enum Type {
  @JsonValue("SINGLE_DECKER")
  SINGLE_DECKER
}

enum Position {
  @JsonValue("LOWER")
  LOWER
}

enum SeatType {
  @JsonValue("DEFAULT")
  DEFAULT
}

// ENUM HELPER
class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
