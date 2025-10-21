// To parse this JSON data, do
//
//     final guardHistoryEquipmentSupportModel = guardHistoryEquipmentSupportModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';

import 'equipment_support_model.dart';

part 'guard_history_equipment_support_model.g.dart';

@JsonSerializable()
class GuardHistoryEquipmentSupportModel {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "transaction_id")
  String? transactionId;
  @JsonKey(name: "guard_history_id")
  String? guardHistoryId;
  @JsonKey(name: "equipment_support_id")
  String? equipmentSupportId;
  @JsonKey(name: "quantity")
  int? quantity;
  @JsonKey(name: "is_active")
  bool? isActive;
  @JsonKey(name: "deleted_at")
  dynamic deletedAt;
  @JsonKey(name: "created_at")
  DateTime? createdAt;
  @JsonKey(name: "updated_at")
  DateTime? updatedAt;
  @JsonKey(name: "equipment_support")
  EquipmentSupportModel? equipmentSupport;

  GuardHistoryEquipmentSupportModel({
    this.id,
    this.transactionId,
    this.guardHistoryId,
    this.equipmentSupportId,
    this.quantity,
    this.isActive,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.equipmentSupport,
  });

  factory GuardHistoryEquipmentSupportModel.fromJson(Map<String, dynamic> json) =>
      _$GuardHistoryEquipmentSupportModelFromJson(json);

  Map<String, dynamic> toJson() => _$GuardHistoryEquipmentSupportModelToJson(this);
}
