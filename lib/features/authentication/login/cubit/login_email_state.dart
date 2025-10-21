part of 'login_email_cubit.dart';

sealed class LoginEmailState extends Equatable {
  const LoginEmailState();

  @override
  List<Object> get props => [];
}

final class LoginEmailInitial extends LoginEmailState {}

final class LoginStateEmailLoading extends LoginEmailState {}

final class LoginStateEmailSuccess extends LoginEmailState {}

final class LoginStateEmailError extends LoginEmailState {
  final String message;

  LoginStateEmailError({required this.message});
}
