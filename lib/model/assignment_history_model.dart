// To parse this JSON data, do
//
//     final assignmentHistoryModel = assignmentHistoryModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';

import '../config/constant.dart';
import 'address_model.dart';

part 'assignment_history_model.g.dart';

@JsonSerializable()
class AssignmentHistoryModel {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "created_at")
  DateTime? createdAt;
  @JsonKey(name: "guard_type_name")
  String? guardTypeName;
  @JsonKey(name: "payment_code")
  dynamic paymentCode;
  @JsonKey(name: "status", fromJson: assignmentHistoryStatusFromString)
  AssignmentHistoryStatus? status;
  @JsonKey(name: "translated_status")
  String? translatedStatus;
  @JsonKey(name: "address")
  AddressModel? address;
  @JsonKey(name: "number_of_guard")
  int? numberOfGuard;
  @JsonKey(name: "guard_type")
  String? guardType;
  @JsonKey(name: "guard_class")
  String? guardClass;
  @JsonKey(name: "start_time")
  DateTime? startTime;
  @JsonKey(name: "end_time")
  DateTime? endTime;

  AssignmentHistoryModel({
    this.id,
    this.createdAt,
    this.guardTypeName,
    this.paymentCode,
    this.status,
    this.translatedStatus,
    this.address,
    this.numberOfGuard,
    this.guardType,
    this.guardClass,
    this.startTime,
    this.endTime,
  });

  factory AssignmentHistoryModel.fromJson(Map<String, dynamic> json) => _$AssignmentHistoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$AssignmentHistoryModelToJson(this);
}
