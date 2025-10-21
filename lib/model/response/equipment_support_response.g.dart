// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'equipment_support_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EquipmentSupportResponse _$EquipmentSupportResponseFromJson(
        Map<String, dynamic> json) =>
    EquipmentSupportResponse(
      SECURITY: (json['SECURITY'] as List<dynamic>?)
          ?.map(
              (e) => EquipmentSupportModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      EMERGENCY: (json['EMERGENCY'] as List<dynamic>?)
          ?.map(
              (e) => EquipmentSupportModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EquipmentSupportResponseToJson(
        EquipmentSupportResponse instance) =>
    <String, dynamic>{
      'SECURITY': instance.SECURITY,
      'EMERGENCY': instance.EMERGENCY,
    };
