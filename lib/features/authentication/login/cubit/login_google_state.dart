part of 'login_google_cubit.dart';

sealed class LoginGoogleState extends Equatable {
  const LoginGoogleState();

  @override
  List<Object> get props => [];
}

final class LoginGoogleInitial extends LoginGoogleState {}

final class LoginGoogleStateLoading extends LoginGoogleState {}

final class LoginGoogleStateSuccess extends LoginGoogleState {}

final class LoginGoogleStateError extends LoginGoogleState {
  final String message;

  LoginGoogleStateError({required this.message});
}
