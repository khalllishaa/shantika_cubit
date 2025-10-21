// To parse this JSON data, do
//
//     final myPromoModel = myPromoModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'package:shantika_cubit/model/promo_model.dart';


part 'my_promo_model.g.dart';

@JsonSerializable()
class MyPromoModel {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "user_id")
  String? userId;
  @JsonKey(name: "promo_id")
  String? promoId;
  @JsonKey(name: "is_used")
  bool? isUsed;
  @JsonKey(name: "deleted_at")
  dynamic deletedAt;
  @JsonKey(name: "created_at")
  DateTime? createdAt;
  @JsonKey(name: "updated_at")
  DateTime? updatedAt;
  @JsonKey(name: "promo")
  PromoModel? promo;

  MyPromoModel({
    this.id,
    this.userId,
    this.promoId,
    this.isUsed,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.promo,
  });

  factory MyPromoModel.fromJson(Map<String, dynamic> json) => _$MyPromoModelFromJson(json);

  Map<String, dynamic> toJson() => _$MyPromoModelToJson(this);
}
