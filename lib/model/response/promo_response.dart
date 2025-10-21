import 'package:json_annotation/json_annotation.dart';

import '../my_promo_model.dart';
import '../promo_model.dart';

part 'promo_response.g.dart';

@JsonSerializable()
class PromoResponse {
  List<PromoModel>? promos;
  List<MyPromoModel>? my_promos;

  int? discount;

  PromoResponse();

  factory PromoResponse.fromJson(Map<String, dynamic> json) => _$PromoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PromoResponseToJson(this);
}
