part of 'update_profile_cubit.dart';

sealed class UpdateProfileState extends Equatable {
  const UpdateProfileState();

  @override
  List<Object> get props => [];
}

final class UpdateProfileInitial extends UpdateProfileState {}

final class UpdateProfileStateLoading extends UpdateProfileState {}

final class UpdateProfileStateSuccess extends UpdateProfileState {
  final UserModel user;

  UpdateProfileStateSuccess({required this.user});
}

final class UpdateProfileStateError extends UpdateProfileState {
  final String message;

  UpdateProfileStateError({required this.message});
}
