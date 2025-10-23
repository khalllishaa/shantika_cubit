// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_assignment_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryAssignmentResponse _$HistoryAssignmentResponseFromJson(
  Map<String, dynamic> json,
) => HistoryAssignmentResponse(
  guard_history: (json['guard_history'] as List<dynamic>?)
      ?.map((e) => AssignmentHistoryModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$HistoryAssignmentResponseToJson(
  HistoryAssignmentResponse instance,
) => <String, dynamic>{'guard_history': instance.guard_history};
