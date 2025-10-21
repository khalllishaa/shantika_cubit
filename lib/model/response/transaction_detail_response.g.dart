// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionDetailResponse _$TransactionDetailResponseFromJson(
        Map<String, dynamic> json) =>
    TransactionDetailResponse(
      transaction: json['transaction'] == null
          ? null
          : TransactionDetailModel.fromJson(
              json['transaction'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TransactionDetailResponseToJson(
        TransactionDetailResponse instance) =>
    <String, dynamic>{
      'transaction': instance.transaction,
    };
