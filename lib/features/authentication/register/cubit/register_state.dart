part of 'register_cubit.dart';

sealed class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object?> get props => [];
}

final class RegisterInitial extends RegisterState {}

final class RegisterStateLoading extends RegisterState {}

final class RegisterStateSuccess extends RegisterState {
  final String? token;

  const RegisterStateSuccess({this.token});

  @override
  List<Object?> get props => [token];
}

final class RegisterStateError extends RegisterState {
  final String message;

  const RegisterStateError({required this.message});

  @override
  List<Object> get props => [message];
}