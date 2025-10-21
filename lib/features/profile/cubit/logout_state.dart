part of 'logout_cubit.dart';

sealed class LogoutState extends Equatable {
  const LogoutState();

  @override
  List<Object> get props => [];
}

final class LogoutInitial extends LogoutState {}

final class LogoutStateLoading extends LogoutState {}

final class LogoutStateSuccess extends LogoutState {}

final class LogoutStateError extends LogoutState {
  final String message;

  LogoutStateError({required this.message});
}
