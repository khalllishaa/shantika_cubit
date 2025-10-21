// To parse this JSON data, do
//
//     final promoModel = promoModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';

part 'promo_model.g.dart';

@JsonSerializable()
class PromoModel {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "thumbnail")
  String? thumbnail;
  @JsonKey(name: "code")
  String? code;
  @JsonKey(name: "quota")
  int? quota;
  @JsonKey(name: "remaining_quota")
  int? remainingQuota;
  @JsonKey(name: "used_quota")
  int? usedQuota;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "start_date")
  String? startDate;
  @JsonKey(name: "expiry_date")
  String? expiryDate;
  @JsonKey(name: "start_time")
  String? startTime;
  @JsonKey(name: "expiry_time")
  String? expiryTime;
  @JsonKey(name: "min_purchase")
  int? minPurchase;

  PromoModel({
    this.id,
    this.name,
    this.thumbnail,
    this.code,
    this.quota,
    this.remainingQuota,
    this.usedQuota,
  });

  factory PromoModel.fromJson(Map<String, dynamic> json) => _$PromoModelFromJson(json);

  Map<String, dynamic> toJson() => _$PromoModelToJson(this);
}
