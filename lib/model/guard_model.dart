// To parse this JSON data, do
//
//     final guardModel = guardModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';

part 'guard_model.g.dart';

@JsonSerializable()
class GuardModel {
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
  @JsonKey(name: "guard_class")
  GuardClassModel? guardClass;

  List<GuardSkillModel>? guard_skills;

  @JsonKey(name: "is_guard_recommendation")
  bool? isGuardRecomendation;

  @JsonKey(name: "number_of_guard")
  int? numberOfGuard;

  @JsonKey(name: "security_objectives")
  String? securityObjective;

  @JsonKey(name: "is_technical_meeting")
  bool? isTechicalMeeting;

  @JsonKey(name: "is_includes_meals")
  bool? isIncludeMeals;

  GuardModel({
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
    this.guardClass,
    this.isGuardRecomendation,
    this.guard_skills,
    this.numberOfGuard,
    this.isIncludeMeals,
    this.isTechicalMeeting,
    this.securityObjective,
  });

  GuardModel copyWith({
    String? id,
    String? vendorId,
    String? guardClassId,
    String? name,
    String? avatar,
    String? phone,
    String? whatsapp,
    String? email,
    String? address,
    String? description,
    String? latitude,
    String? longitude,
    bool? isActive,
    dynamic deletedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? gender,
    bool? isFavoriteGuard,
    GuardClassModel? guardClass,
    bool? isGuardRecomendation,
    List<GuardSkillModel>? guard_skills,
    int? numberOfGuard,
    String? securityObjective,
    bool? isTechicalMeeting,
    bool? isIncludeMeals,
  }) {
    return GuardModel(
      id: id ?? this.id,
      vendorId: vendorId ?? this.vendorId,
      guardClassId: guardClassId ?? this.guardClassId,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      phone: phone ?? this.phone,
      whatsapp: whatsapp ?? this.whatsapp,
      email: email ?? this.email,
      address: address ?? this.address,
      description: description ?? this.description,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      isActive: isActive ?? this.isActive,
      deletedAt: deletedAt ?? this.deletedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      gender: gender ?? this.gender,
      isFavoriteGuard: isFavoriteGuard ?? this.isFavoriteGuard,
      guardClass: guardClass ?? this.guardClass,
      isGuardRecomendation: isGuardRecomendation ?? this.isGuardRecomendation,
      guard_skills: guard_skills ?? this.guard_skills,
      numberOfGuard: numberOfGuard ?? this.numberOfGuard,
      isTechicalMeeting: isTechicalMeeting ?? this.isTechicalMeeting,
      securityObjective: securityObjective ?? this.securityObjective,
      isIncludeMeals: isIncludeMeals ?? this.isIncludeMeals,
    );
  }

  factory GuardModel.fromJson(Map<String, dynamic> json) => _$GuardModelFromJson(json);

  Map<String, dynamic> toJson() => _$GuardModelToJson(this);
}

@JsonSerializable()
class GuardClassModel {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "hourly_price")
  int? hourlyPrice;
  @JsonKey(name: "daily_price")
  int? dailyPrice;
  @JsonKey(name: "is_active")
  bool? isActive;
  @JsonKey(name: "deleted_at")
  dynamic deletedAt;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  dynamic updatedAt;
  List<GuardSkillModel>? guard_skills;

  GuardClassModel({
    this.id,
    this.name,
    this.description,
    this.hourlyPrice,
    this.dailyPrice,
    this.isActive,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.guard_skills,
  });

  factory GuardClassModel.fromJson(Map<String, dynamic> json) => _$GuardClassModelFromJson(json);

  Map<String, dynamic> toJson() => _$GuardClassModelToJson(this);
}

@JsonSerializable()
class GuardSkillModel {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "guard_id")
  String? guardId;
  @JsonKey(name: "name")
  String? name;
  bool? is_skilled;

  GuardSkillModel({
    this.id,
    this.guardId,
    this.name,
    this.is_skilled,
  });

  factory GuardSkillModel.fromJson(Map<String, dynamic> json) => _$GuardSkillModelFromJson(json);

  Map<String, dynamic> toJson() => _$GuardSkillModelToJson(this);
}
