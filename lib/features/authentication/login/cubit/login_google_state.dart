part of 'login_google_cubit.dart';

sealed class LoginGoogleState extends Equatable {
  const LoginGoogleState();

  @override
  List<Object?> get props => [];
}

final class LoginGoogleInitial extends LoginGoogleState {}

final class LoginGoogleStateLoading extends LoginGoogleState {}

final class LoginGoogleStateSuccess extends LoginGoogleState {}

final class LoginGoogleStateError extends LoginGoogleState {
  final String message;

  const LoginGoogleStateError({required this.message});

  @override
  List<Object> get props => [message];
}

/// ✅ State baru untuk popup input data lengkap
final class LoginGoogleNeedMoreInfo extends LoginGoogleState {
  final String firebaseUid;
  final String email;
  final String name;

  const LoginGoogleNeedMoreInfo({
    required this.firebaseUid,
    required this.email,
    required this.name,
  });

  @override
  List<Object> get props => [firebaseUid, email, name];
}