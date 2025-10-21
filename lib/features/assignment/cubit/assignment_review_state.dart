part of 'assignment_review_cubit.dart';

sealed class AssignmentReviewState extends Equatable {
  const AssignmentReviewState();

  @override
  List<Object> get props => [];
}

final class AssignmentReviewInitial extends AssignmentReviewState {}

final class AssignmentReviewStateLoading extends AssignmentReviewState {}

final class AssignmentReviewStateSuccess extends AssignmentReviewState {}

final class AssignmentReviewStateError extends AssignmentReviewState {
  final String message;

  AssignmentReviewStateError({required this.message});
}
