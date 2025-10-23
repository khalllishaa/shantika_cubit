part of 'login_phone_cubit.dart';

sealed class LoginPhoneState extends Equatable {
  const LoginPhoneState();

  @override
  List<Object?> get props => [];
}

final class LoginPhoneInitial extends LoginPhoneState {}

final class LoginPhoneStateLoading extends LoginPhoneState {}

final class LoginPhoneStateSuccess extends LoginPhoneState {
  final String? token;
  final UsersModel? user;

  const LoginPhoneStateSuccess({this.token, this.user});

  @override
  List<Object?> get props => [token, user];
}

final class LoginPhoneStateError extends LoginPhoneState {
  final String message;

  const LoginPhoneStateError({required this.message});

  @override
  List<Object> get props => [message];
}