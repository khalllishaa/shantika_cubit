part of 'guard_check_availability_cubit.dart';

sealed class GuardCheckAvailibilityState extends Equatable {
  const GuardCheckAvailibilityState();

  @override
  List<Object> get props => [];
}

final class GuardCheckAvailibilityInitial extends GuardCheckAvailibilityState {}

final class GuardCheckAvailibilityStateLoading extends GuardCheckAvailibilityState {}

final class GuardCheckAvailibilityStateSuccess extends GuardCheckAvailibilityState {
  final String message;

  GuardCheckAvailibilityStateSuccess({required this.message});
}

final class GuardCheckAvailibilityStateError extends GuardCheckAvailibilityState {
  final String message;

  GuardCheckAvailibilityStateError({required this.message});
}
