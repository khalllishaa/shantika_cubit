import 'package:json_annotation/json_annotation.dart';

import '../address_model.dart';
import '../application_model.dart';
import '../guard_model.dart';
import '../guard_type_model.dart';
import '../terms_conditions_model.dart';
import 'equipment_support_response.dart';

part 'guard_type_response.g.dart';

@JsonSerializable()
class GuardTypeResponse {
  ApplicationModel? application;

  GuardTypeModel? guardType;

  @JsonKey(name: "guard_class")
  List<GuardClassModel>? guardClass;

  List<GuardModel>? guards;

  @JsonKey(name: "user_addresses")
  List<AddressModel>? userAddress;

  @JsonKey(name: "equipment_support")
  EquipmentSupportResponse? equipmentSupport;

  @JsonKey(name: "term_and_conditions")
  TermsConditionsModel? termsCondition;

  GuardTypeResponse({
    this.application,
    this.guardType,
    this.guardClass,
    this.guards,
    this.userAddress,
    this.equipmentSupport,
    this.termsCondition,
  });

  factory GuardTypeResponse.fromJson(Map<String, dynamic> json) => _$GuardTypeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GuardTypeResponseToJson(this);
}
