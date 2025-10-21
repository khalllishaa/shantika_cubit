import 'package:json_annotation/json_annotation.dart';

import '../payment_method_model.dart';
part 'payment_method_response.g.dart';

@JsonSerializable()
class PaymentMethodResponse {
  List<PaymentMethodModel>? payment_methods;
  List<OfflinePaymentMethodModel>? offline_payment_methods;

  PaymentMethodResponse({this.payment_methods, this.offline_payment_methods});

  factory PaymentMethodResponse.fromJson(Map<String, dynamic> json) => _$PaymentMethodResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentMethodResponseToJson(this);
}
