part of 'register_cubit.dart';

sealed class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

final class RegisterInitial extends RegisterState {}

final class RegisterStateLoading extends RegisterState {}

final class RegisterStateSuccess extends RegisterState {
  final String? token;

  RegisterStateSuccess({this.token});
}

final class RegisterStateError extends RegisterState {
  final String message;

  RegisterStateError({required this.message});
}
