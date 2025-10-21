// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignment_history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssignmentHistoryModel _$AssignmentHistoryModelFromJson(
        Map<String, dynamic> json) =>
    AssignmentHistoryModel(
      id: json['id'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      guardTypeName: json['guard_type_name'] as String?,
      paymentCode: json['payment_code'],
      status: assignmentHistoryStatusFromString(json['status'] as String?),
      translatedStatus: json['translated_status'] as String?,
      address: json['address'] == null
          ? null
          : AddressModel.fromJson(json['address'] as Map<String, dynamic>),
      numberOfGuard: (json['number_of_guard'] as num?)?.toInt(),
      guardType: json['guard_type'] as String?,
      guardClass: json['guard_class'] as String?,
      startTime: json['start_time'] == null
          ? null
          : DateTime.parse(json['start_time'] as String),
      endTime: json['end_time'] == null
          ? null
          : DateTime.parse(json['end_time'] as String),
    );

Map<String, dynamic> _$AssignmentHistoryModelToJson(
        AssignmentHistoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt?.toIso8601String(),
      'guard_type_name': instance.guardTypeName,
      'payment_code': instance.paymentCode,
      'status': _$AssignmentHistoryStatusEnumMap[instance.status],
      'translated_status': instance.translatedStatus,
      'address': instance.address,
      'number_of_guard': instance.numberOfGuard,
      'guard_type': instance.guardType,
      'guard_class': instance.guardClass,
      'start_time': instance.startTime?.toIso8601String(),
      'end_time': instance.endTime?.toIso8601String(),
    };

const _$AssignmentHistoryStatusEnumMap = {
  AssignmentHistoryStatus.pending: 'pending',
  AssignmentHistoryStatus.upcoming: 'upcoming',
  AssignmentHistoryStatus.process: 'process',
  AssignmentHistoryStatus.finished: 'finished',
  AssignmentHistoryStatus.cancelled: 'cancelled',
};
