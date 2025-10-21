part of 'detail_history_assignment_cubit.dart';

sealed class DetailHistoryAssignmentState extends Equatable {
  const DetailHistoryAssignmentState();

  @override
  List<Object> get props => [];
}

final class DetailHistoryAssignmentInitial extends DetailHistoryAssignmentState {}

final class DetailHistoryAssignmentStateLoading extends DetailHistoryAssignmentState {}

final class DetailHistoryAssignmentStateSuccess extends DetailHistoryAssignmentState {
  final DetailAssignmentHistoryModel data;

  DetailHistoryAssignmentStateSuccess({required this.data});
}

final class DetailHistoryAssignmentStateError extends DetailHistoryAssignmentState {
  final String message;

  DetailHistoryAssignmentStateError({required this.message});
}
