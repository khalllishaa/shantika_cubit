// To parse this JSON data, do
//
//     final equipmentSupportModel = equipmentSupportModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';

part 'equipment_support_model.g.dart';

@JsonSerializable()
class EquipmentSupportModel {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "type")
  String? type;
  @JsonKey(name: "thumbnail")
  String? thumbnail;
  @JsonKey(name: "quantity")
  int? quantity;
  @JsonKey(name: "rent_price")
  int? rentPrice;
  @JsonKey(name: "ready_to_use")
  int? readyToUse;

  int? selectedQty;

  EquipmentSupportModel({
    this.id,
    this.name,
    this.type,
    this.thumbnail,
    this.quantity,
    this.rentPrice,
    this.readyToUse,
    this.selectedQty,
  });

  factory EquipmentSupportModel.fromJson(Map<String, dynamic> json) => _$EquipmentSupportModelFromJson(json);

  Map<String, dynamic> toJson() => _$EquipmentSupportModelToJson(this);

  EquipmentSupportModel copyWith({
    String? id,
    String? name,
    String? type,
    String? thumbnail,
    int? quantity,
    int? rentPrice,
    int? readyToUse,
    int? selectedQty,
  }) {
    return EquipmentSupportModel(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      thumbnail: thumbnail ?? this.thumbnail,
      quantity: quantity ?? this.quantity,
      rentPrice: rentPrice ?? this.rentPrice,
      readyToUse: readyToUse ?? this.readyToUse,
      selectedQty: selectedQty ?? this.selectedQty,
    );
  }
}
