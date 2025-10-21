part of 'socket_transaction_cubit.dart';

sealed class SocketTransactionState extends Equatable {
  const SocketTransactionState();

  @override
  List<Object> get props => [];
}

final class SocketTransactionInitial extends SocketTransactionState {}

final class SocketTransactionStateLoading extends SocketTransactionState {}

final class SocketTransactionStateSuccess extends SocketTransactionState {
  final String? message;

  SocketTransactionStateSuccess({this.message});
}

final class SocketTransactionStateError extends SocketTransactionState {
  final String message;

  SocketTransactionStateError({required this.message});
}
