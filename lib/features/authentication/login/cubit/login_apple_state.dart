part of 'login_apple_cubit.dart';

sealed class LoginAppleState extends Equatable {
  const LoginAppleState();

  @override
  List<Object> get props => [];
}

final class LoginAppleInitial extends LoginAppleState {}

final class LoginAppleStateLoading extends LoginAppleState {}

final class LoginAppleStateSuccess extends LoginAppleState {}

final class LoginAppleStateError extends LoginAppleState {
  final String message;

  LoginAppleStateError({required this.message});
}
