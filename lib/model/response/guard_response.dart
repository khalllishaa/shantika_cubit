import 'package:json_annotation/json_annotation.dart';

import '../article_model.dart';
import '../guard_model.dart';
part 'guard_response.g.dart';

@JsonSerializable()
class GuardResponse {
  List<GuardModel>? guards;
  GuardModel? guard;
  List<ArticleModel>? article;
  GuardResponse();

  factory GuardResponse.fromJson(Map<String, dynamic> json) => _$GuardResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GuardResponseToJson(this);
}
