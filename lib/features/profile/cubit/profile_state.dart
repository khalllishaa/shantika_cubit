part of 'profile_cubit.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

final class ProfileStateLoading extends ProfileState {}

final class ProfileStateSuccess extends ProfileState {
  final UserModel user;

  ProfileStateSuccess({required this.user});
}

final class ProfileStateError extends ProfileState {
  final String message;

  ProfileStateError({required this.message});
}
