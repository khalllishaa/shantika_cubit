part of 'change_password_cubit.dart';

sealed class ChangePasswordState extends Equatable {
  const ChangePasswordState();

  @override
  List<Object> get props => [];
}

final class ChangePasswordInitial extends ChangePasswordState {}

final class ChangePasswordStateLoading extends ChangePasswordState {}

final class ChangePasswordStateSuccess extends ChangePasswordState {}

final class ChangePasswordStateError extends ChangePasswordState {
  final String message;

  ChangePasswordStateError({required this.message});
}
