// To parse this JSON data, do
//
//     final detailAssignmentHistoryModel = detailAssignmentHistoryModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'package:shantika_cubit/model/transaction_model.dart';
import 'package:shantika_cubit/model/user_model.dart';

import '../config/constant.dart';
import 'address_model.dart';
import 'guard_model.dart';

part 'detail_assignment_history_model.g.dart';

@JsonSerializable()
class DetailAssignmentHistoryModel {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "user_id")
  String? userId;
  @JsonKey(name: "transaction_id")
  String? transactionId;
  @JsonKey(name: "user_address_id")
  String? userAddressId;
  @JsonKey(name: "guard_type_id")
  String? guardTypeId;
  @JsonKey(name: "guard_class_id")
  String? guardClassId;
  @JsonKey(name: "event_name")
  dynamic eventName;
  @JsonKey(name: "pic_name")
  dynamic picName;
  @JsonKey(name: "phone")
  String? phone;
  @JsonKey(name: "start_time")
  DateTime? startTime;
  @JsonKey(name: "end_time")
  DateTime? endTime;
  @JsonKey(name: "is_guard_recommendation")
  bool? isGuardRecommendation;
  @JsonKey(name: "number_of_guard")
  int? numberOfGuard;
  @JsonKey(name: "is_technical_meeting")
  bool? isTechnicalMeeting;
  @JsonKey(name: "is_includes_meals")
  bool? isIncludesMeals;
  @JsonKey(name: "security_objectives")
  String? securityObjectives;
  @JsonKey(name: "status", fromJson: assignmentHistoryStatusFromString)
  AssignmentHistoryStatus? status;
  @JsonKey(name: "deleted_at")
  dynamic deletedAt;
  @JsonKey(name: "created_at")
  DateTime? createdAt;
  @JsonKey(name: "updated_at")
  DateTime? updatedAt;
  @JsonKey(name: "translated_status")
  String? translatedStatus;
  @JsonKey(name: "transaction")
  TransactionModel? transaction;
  @JsonKey(name: "user")
  UserModel? user;
  @JsonKey(name: "user_address")
  AddressModel? userAddress;
  @JsonKey(name: "guard_type")
  GuardModel? guardType;
  @JsonKey(name: "guard_class")
  GuardClassModel? guardClass;
  @JsonKey(name: "guard_history_officers")
  List<GuardHistoryOfficer>? guardHistoryOfficers;
  @JsonKey(name: "guard_history_equipment_supports")
  List<dynamic>? guardHistoryEquipmentSupports;
  @JsonKey(name: "review")
  ReviewModel? review;

  DetailAssignmentHistoryModel({
    this.id,
    this.userId,
    this.transactionId,
    this.userAddressId,
    this.guardTypeId,
    this.guardClassId,
    this.eventName,
    this.picName,
    this.phone,
    this.startTime,
    this.endTime,
    this.isGuardRecommendation,
    this.numberOfGuard,
    this.isTechnicalMeeting,
    this.isIncludesMeals,
    this.securityObjectives,
    this.status,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.translatedStatus,
    this.transaction,
    this.user,
    this.userAddress,
    this.guardType,
    this.guardClass,
    this.guardHistoryOfficers,
    this.guardHistoryEquipmentSupports,
    this.review,
  });

  factory DetailAssignmentHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$DetailAssignmentHistoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$DetailAssignmentHistoryModelToJson(this);
}

@JsonSerializable()
class GuardHistoryOfficer {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "guard_history_id")
  String? guardHistoryId;
  @JsonKey(name: "guard_id")
  String? guardId;
  @JsonKey(name: "deleted_at")
  dynamic deletedAt;
  @JsonKey(name: "created_at")
  DateTime? createdAt;
  @JsonKey(name: "updated_at")
  DateTime? updatedAt;
  @JsonKey(name: "status")
  String? status;
  @JsonKey(name: "guard_relation")
  GuardRelation? guardRelation;

  GuardHistoryOfficer({
    this.id,
    this.guardHistoryId,
    this.guardId,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.guardRelation,
  });

  factory GuardHistoryOfficer.fromJson(Map<String, dynamic> json) => _$GuardHistoryOfficerFromJson(json);

  Map<String, dynamic> toJson() => _$GuardHistoryOfficerToJson(this);
}

@JsonSerializable()
class GuardRelation {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "vendor_id")
  String? vendorId;
  @JsonKey(name: "guard_class_id")
  String? guardClassId;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "avatar")
  String? avatar;
  @JsonKey(name: "phone")
  String? phone;
  @JsonKey(name: "whatsapp")
  String? whatsapp;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "address")
  String? address;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "latitude")
  String? latitude;
  @JsonKey(name: "longitude")
  String? longitude;
  @JsonKey(name: "is_active")
  bool? isActive;
  @JsonKey(name: "deleted_at")
  dynamic deletedAt;
  @JsonKey(name: "created_at")
  DateTime? createdAt;
  @JsonKey(name: "updated_at")
  DateTime? updatedAt;
  @JsonKey(name: "gender")
  String? gender;
  @JsonKey(name: "is_favorite_guard")
  bool? isFavoriteGuard;

  GuardRelation({
    this.id,
    this.vendorId,
    this.guardClassId,
    this.name,
    this.avatar,
    this.phone,
    this.whatsapp,
    this.email,
    this.address,
    this.description,
    this.latitude,
    this.longitude,
    this.isActive,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.gender,
    this.isFavoriteGuard,
  });

  factory GuardRelation.fromJson(Map<String, dynamic> json) => _$GuardRelationFromJson(json);

  Map<String, dynamic> toJson() => _$GuardRelationToJson(this);
}

@JsonSerializable()
class ReviewModel {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "user_id")
  String? userId;
  @JsonKey(name: "guard_history_id")
  String? guardHistoryId;
  @JsonKey(name: "attachment")
  dynamic attachment;
  @JsonKey(name: "star")
  int? star;
  @JsonKey(name: "review")
  String? review;
  @JsonKey(name: "is_active")
  bool? isActive;
  @JsonKey(name: "deleted_at")
  dynamic deletedAt;
  @JsonKey(name: "created_at")
  DateTime? createdAt;
  @JsonKey(name: "updated_at")
  DateTime? updatedAt;

  ReviewModel({
    this.id,
    this.userId,
    this.guardHistoryId,
    this.attachment,
    this.star,
    this.review,
    this.isActive,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) => _$ReviewModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewModelToJson(this);
}

@JsonSerializable()
class TransactionComplainModel {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "transaction_id")
  String? transactionId;
  @JsonKey(name: "complain")
  String? complain;
  @JsonKey(name: "is_seen")
  bool? isSeen;
  @JsonKey(name: "created_at")
  DateTime? createdAt;
  @JsonKey(name: "updated_at")
  DateTime? updatedAt;

  TransactionComplainModel({
    this.id,
    this.transactionId,
    this.complain,
    this.isSeen,
    this.createdAt,
    this.updatedAt,
  });

  factory TransactionComplainModel.fromJson(Map<String, dynamic> json) => _$TransactionComplainModelFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionComplainModelToJson(this);
}
