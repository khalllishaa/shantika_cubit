part of 'complaint_cubit.dart';

sealed class ComplaintState extends Equatable {
  const ComplaintState();

  @override
  List<Object> get props => [];
}

final class ComplaintInitial extends ComplaintState {}

final class ComplaintStateLoading extends ComplaintState {}

final class ComplaintStateSuccess extends ComplaintState {}

final class ComplaintStateError extends ComplaintState {
  final String message;

  ComplaintStateError({required this.message});
}
