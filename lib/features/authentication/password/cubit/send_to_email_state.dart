part of 'send_to_email_cubit.dart';

sealed class SendToEmailState extends Equatable {
  const SendToEmailState();

  @override
  List<Object> get props => [];
}

final class SendToEmailInitial extends SendToEmailState {}

final class SendToEmailStateLoading extends SendToEmailState {}

final class SendToEmailStateSuccess extends SendToEmailState {
  final String email;

  SendToEmailStateSuccess({required this.email});
}

final class SendToEmailStateError extends SendToEmailState {
  final String message;

  SendToEmailStateError({required this.message});
}
