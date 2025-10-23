// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guard_type_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GuardTypeResponse _$GuardTypeResponseFromJson(Map<String, dynamic> json) =>
    GuardTypeResponse(
      application: json['application'] == null
          ? null
          : ApplicationModel.fromJson(
              json['application'] as Map<String, dynamic>,
            ),
      guardType: json['guardType'] == null
          ? null
          : GuardTypeModel.fromJson(json['guardType'] as Map<String, dynamic>),
      guardClass: (json['guard_class'] as List<dynamic>?)
          ?.map((e) => GuardClassModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      guards: (json['guards'] as List<dynamic>?)
          ?.map((e) => GuardModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      userAddress: (json['user_addresses'] as List<dynamic>?)
          ?.map((e) => AddressModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      equipmentSupport: json['equipment_support'] == null
          ? null
          : EquipmentSupportResponse.fromJson(
              json['equipment_support'] as Map<String, dynamic>,
            ),
      termsCondition: json['term_and_conditions'] == null
          ? null
          : TermsConditionsModel.fromJson(
              json['term_and_conditions'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$GuardTypeResponseToJson(GuardTypeResponse instance) =>
    <String, dynamic>{
      'application': instance.application,
      'guardType': instance.guardType,
      'guard_class': instance.guardClass,
      'guards': instance.guards,
      'user_addresses': instance.userAddress,
      'equipment_support': instance.equipmentSupport,
      'term_and_conditions': instance.termsCondition,
    };
