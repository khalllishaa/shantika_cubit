import 'package:json_annotation/json_annotation.dart';
import '../equipment_support_model.dart';

part 'equipment_support_response.g.dart';

@JsonSerializable()
class EquipmentSupportResponse {
  List<EquipmentSupportModel>? SECURITY;
  List<EquipmentSupportModel>? EMERGENCY;

  EquipmentSupportResponse({this.SECURITY, this.EMERGENCY});

  factory EquipmentSupportResponse.fromJson(Map<String, dynamic> json) => _$EquipmentSupportResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EquipmentSupportResponseToJson(this);
}
