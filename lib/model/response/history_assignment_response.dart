import 'package:json_annotation/json_annotation.dart';

import '../assignment_history_model.dart';
part 'history_assignment_response.g.dart';

@JsonSerializable()
class HistoryAssignmentResponse {
  List<AssignmentHistoryModel>? guard_history;

  HistoryAssignmentResponse({this.guard_history});

  factory HistoryAssignmentResponse.fromJson(Map<String, dynamic> json) => _$HistoryAssignmentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryAssignmentResponseToJson(this);
}
