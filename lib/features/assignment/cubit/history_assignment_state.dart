part of 'history_assignment_cubit.dart';

sealed class HistoryAssignmentState extends Equatable {
  const HistoryAssignmentState();

  @override
  List<Object> get props => [];
}

final class HistoryAssignmentInitial extends HistoryAssignmentState {}

final class HistoryAssignmentStateLoading extends HistoryAssignmentState {}

final class HistoryAssignmentStateSuccess extends HistoryAssignmentState {
  final List<AssignmentHistoryModel> histories;

  HistoryAssignmentStateSuccess({required this.histories});
}

final class HistoryAssignmentStateError extends HistoryAssignmentState {
  final String message;

  HistoryAssignmentStateError({required this.message});
}
