// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'equipment_support_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EquipmentSupportModel _$EquipmentSupportModelFromJson(
        Map<String, dynamic> json) =>
    EquipmentSupportModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      type: json['type'] as String?,
      thumbnail: json['thumbnail'] as String?,
      quantity: (json['quantity'] as num?)?.toInt(),
      rentPrice: (json['rent_price'] as num?)?.toInt(),
      readyToUse: (json['ready_to_use'] as num?)?.toInt(),
      selectedQty: (json['selectedQty'] as num?)?.toInt(),
    );

Map<String, dynamic> _$EquipmentSupportModelToJson(
        EquipmentSupportModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'thumbnail': instance.thumbnail,
      'quantity': instance.quantity,
      'rent_price': instance.rentPrice,
      'ready_to_use': instance.readyToUse,
      'selectedQty': instance.selectedQty,
    };
