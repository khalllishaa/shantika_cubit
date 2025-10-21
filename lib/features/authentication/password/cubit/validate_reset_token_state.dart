part of 'validate_reset_token_cubit.dart';

sealed class ValidateResetTokenState extends Equatable {
  const ValidateResetTokenState();

  @override
  List<Object> get props => [];
}

final class ValidateResetTokenInitial extends ValidateResetTokenState {}

final class ValidateResetTokenStateLoading extends ValidateResetTokenState {}

final class ValidateResetTokenStateSuccess extends ValidateResetTokenState {
  final String email;

  ValidateResetTokenStateSuccess({required this.email});
}

final class ValidateResetTokenStateError extends ValidateResetTokenState {
  final String message;

  ValidateResetTokenStateError({required this.message});
}
