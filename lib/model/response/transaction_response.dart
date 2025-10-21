import 'package:json_annotation/json_annotation.dart';

import '../transaction_model.dart';

part 'transaction_response.g.dart';

@JsonSerializable()
class TransactionResponse {
  List<TransactionModel>? transaction;

  TransactionResponse({this.transaction});

  factory TransactionResponse.fromJson(Map<String, dynamic> json) => _$TransactionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionResponseToJson(this);
}
