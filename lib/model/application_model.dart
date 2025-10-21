// To parse this JSON data, do
//
//     final applicationModel = applicationModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';

part 'application_model.g.dart';

@JsonSerializable()
class ApplicationModel {
  @JsonKey(name: "min_booking_hours")
  int? minBookingHours;
  @JsonKey(name: "max_booking_hours")
  int? maxBookingHours;
  @JsonKey(name: "technical_meeting_price")
  int? technicalMeetingPrice;
  @JsonKey(name: "includes_meals_price")
  int? includesMealsPrice;
  @JsonKey(name: "admin_fees")
  int? adminFees;
  @JsonKey(name: "xendit_fee")
  int? xenditFee;

  ApplicationModel({
    this.minBookingHours,
    this.maxBookingHours,
    this.technicalMeetingPrice,
    this.includesMealsPrice,
    this.adminFees,
    this.xenditFee,
  });

  factory ApplicationModel.fromJson(Map<String, dynamic> json) => _$ApplicationModelFromJson(json);

  Map<String, dynamic> toJson() => _$ApplicationModelToJson(this);
}
