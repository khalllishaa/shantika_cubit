// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seat_layout_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeatLayoutModel _$SeatLayoutModelFromJson(Map<String, dynamic> json) =>
    SeatLayoutModel(
      code: (json['code'] as num).toInt(),
      success: json['success'] as bool,
      message: json['message'] as String,
      data: SeatLayoutData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SeatLayoutModelToJson(SeatLayoutModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

SeatLayoutData _$SeatLayoutDataFromJson(Map<String, dynamic> json) =>
    SeatLayoutData(
      id: (json['id'] as num).toInt(),
      name: $enumDecode(_$NameEnumMap, json['name']),
      row: (json['row'] as num).toInt(),
      col: (json['col'] as num).toInt(),
      upperRow: (json['upper_row'] as num).toInt(),
      upperCol: (json['upper_col'] as num).toInt(),
      spaceIndexes: (json['space_indexes'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      upperSpaceIndexes: json['upper_space_indexes'] as List<dynamic>,
      toiletIndexes: (json['toilet_indexes'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      upperToiletIndexes: json['upper_toilet_indexes'] as List<dynamic>,
      doorIndexes: (json['door_indexes'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      upperDoorIndexes: json['upper_door_indexes'] as List<dynamic>,
      note: $enumDecode(_$NoteEnumMap, json['note']),
      totalIndexes: (json['total_indexes'] as num).toInt(),
      totalUpperIndexs: json['total_upper_indexs'],
      chairs: (json['chairs'] as List<dynamic>)
          .map((e) => Chair.fromJson(e as Map<String, dynamic>))
          .toList(),
      upperChairs: json['upper_chairs'] as List<dynamic>,
    );

Map<String, dynamic> _$SeatLayoutDataToJson(SeatLayoutData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': _$NameEnumMap[instance.name]!,
      'row': instance.row,
      'col': instance.col,
      'upper_row': instance.upperRow,
      'upper_col': instance.upperCol,
      'space_indexes': instance.spaceIndexes,
      'upper_space_indexes': instance.upperSpaceIndexes,
      'toilet_indexes': instance.toiletIndexes,
      'upper_toilet_indexes': instance.upperToiletIndexes,
      'door_indexes': instance.doorIndexes,
      'upper_door_indexes': instance.upperDoorIndexes,
      'note': _$NoteEnumMap[instance.note]!,
      'total_indexes': instance.totalIndexes,
      'total_upper_indexs': instance.totalUpperIndexs,
      'chairs': instance.chairs,
      'upper_chairs': instance.upperChairs,
    };

const _$NameEnumMap = {Name.EXECUTIVE: 'Executive'};

const _$NoteEnumMap = {Note.JANGAN_DIHAPUS_OKE: 'JANGAN DIHAPUS (oke)'};

Chair _$ChairFromJson(Map<String, dynamic> json) => Chair(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  index: (json['index'] as num).toInt(),
  deletedAt: json['deleted_at'],
  seatType: $enumDecode(_$SeatTypeEnumMap, json['seat_type']),
  position: $enumDecode(_$PositionEnumMap, json['position']),
  isBlocked: json['is_blocked'] as bool,
  isBlockedOnlyAgency: json['is_blocked_only_agency'] as bool,
  isBooking: json['is_booking'] as bool,
  isUnavailableCustomer: json['is_unavailable_customer'] as bool,
  isUnavailable: json['is_unavailable'] as bool,
  isUnavailableNotPaidCustomer:
      json['is_unavailable_not_paid_customer'] as bool,
  isUnavailableWaitingCustomer: json['is_unavailable_waiting_customer'] as bool,
  isMine: json['is_mine'] as bool,
  price: (json['price'] as num).toInt(),
  isSpace: json['is_space'] as bool,
  isDoor: json['is_door'] as bool,
  isToilet: json['is_toilet'] as bool,
  layout: Layout.fromJson(json['layout'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ChairToJson(Chair instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'index': instance.index,
  'deleted_at': instance.deletedAt,
  'seat_type': _$SeatTypeEnumMap[instance.seatType]!,
  'position': _$PositionEnumMap[instance.position]!,
  'is_blocked': instance.isBlocked,
  'is_blocked_only_agency': instance.isBlockedOnlyAgency,
  'is_booking': instance.isBooking,
  'is_unavailable_customer': instance.isUnavailableCustomer,
  'is_unavailable': instance.isUnavailable,
  'is_unavailable_not_paid_customer': instance.isUnavailableNotPaidCustomer,
  'is_unavailable_waiting_customer': instance.isUnavailableWaitingCustomer,
  'is_mine': instance.isMine,
  'price': instance.price,
  'is_space': instance.isSpace,
  'is_door': instance.isDoor,
  'is_toilet': instance.isToilet,
  'layout': instance.layout,
};

const _$SeatTypeEnumMap = {SeatType.DEFAULT: 'DEFAULT'};

const _$PositionEnumMap = {Position.LOWER: 'LOWER'};

Layout _$LayoutFromJson(Map<String, dynamic> json) => Layout(
  id: (json['id'] as num).toInt(),
  name: $enumDecode(_$NameEnumMap, json['name']),
  row: (json['row'] as num).toInt(),
  col: (json['col'] as num).toInt(),
  spaceIndexes: (json['space_indexes'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toList(),
  toiletIndexes: (json['toilet_indexes'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toList(),
  doorIndexes: (json['door_indexes'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toList(),
  note: $enumDecode(_$NoteEnumMap, json['note']),
  deletedAt: json['deleted_at'],
  code: $enumDecode(_$NameEnumMap, json['code']),
  type: $enumDecode(_$TypeEnumMap, json['type']),
  upperCol: (json['upper_col'] as num).toInt(),
  upperRow: (json['upper_row'] as num).toInt(),
  upperSpaceIndexes: json['upper_space_indexes'] as List<dynamic>,
  upperToiletIndexes: json['upper_toilet_indexes'] as List<dynamic>,
  upperDoorIndexes: json['upper_door_indexes'] as List<dynamic>,
  totalIndexes: (json['total_indexes'] as num).toInt(),
  totalChairs: (json['total_chairs'] as num).toInt(),
  totalUpperIndexes: (json['total_upper_indexes'] as num).toInt(),
  totalUpperChairs: (json['total_upper_chairs'] as num).toInt(),
  totalLowerChairs: (json['total_lower_chairs'] as num).toInt(),
);

Map<String, dynamic> _$LayoutToJson(Layout instance) => <String, dynamic>{
  'id': instance.id,
  'name': _$NameEnumMap[instance.name]!,
  'row': instance.row,
  'col': instance.col,
  'space_indexes': instance.spaceIndexes,
  'toilet_indexes': instance.toiletIndexes,
  'door_indexes': instance.doorIndexes,
  'note': _$NoteEnumMap[instance.note]!,
  'deleted_at': instance.deletedAt,
  'code': _$NameEnumMap[instance.code]!,
  'type': _$TypeEnumMap[instance.type]!,
  'upper_col': instance.upperCol,
  'upper_row': instance.upperRow,
  'upper_space_indexes': instance.upperSpaceIndexes,
  'upper_toilet_indexes': instance.upperToiletIndexes,
  'upper_door_indexes': instance.upperDoorIndexes,
  'total_indexes': instance.totalIndexes,
  'total_chairs': instance.totalChairs,
  'total_upper_indexes': instance.totalUpperIndexes,
  'total_upper_chairs': instance.totalUpperChairs,
  'total_lower_chairs': instance.totalLowerChairs,
};

const _$TypeEnumMap = {Type.SINGLE_DECKER: 'SINGLE_DECKER'};
