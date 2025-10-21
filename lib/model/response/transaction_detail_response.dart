import 'package:json_annotation/json_annotation.dart';

import '../transaction_detail_model.dart';

part 'transaction_detail_response.g.dart';

@JsonSerializable()
class TransactionDetailResponse {
  TransactionDetailModel? transaction;

  TransactionDetailResponse({this.transaction});

  factory TransactionDetailResponse.fromJson(Map<String, dynamic> json) => _$TransactionDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionDetailResponseToJson(this);
}
