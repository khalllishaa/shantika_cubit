import 'package:json_annotation/json_annotation.dart';

import '../apps_model.dart';
import '../article_model.dart';
import '../guard_type_model.dart';
import '../promo_model.dart';
import '../slider_model.dart';

part 'home_response.g.dart';

@JsonSerializable()
class HomeResponse {
  List<GuardTypeModel>? guard_types;
  AppsModel? apps;
  List<SliderModel>? sliders;
  List<ArticleModel>? articles;
  List<PromoModel>? promos;

  HomeResponse();

  factory HomeResponse.fromJson(Map<String, dynamic> json) => _$HomeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HomeResponseToJson(this);
}
