part of 'cancel_transaction_cubit.dart';

sealed class CancelTransactionState extends Equatable {
  const CancelTransactionState();

  @override
  List<Object> get props => [];
}

final class CancelTransactionInitial extends CancelTransactionState {}

final class CancelTransactionStateLoading extends CancelTransactionState {}

final class CancelTransactionStateSuccess extends CancelTransactionState {
  final String message;

  CancelTransactionStateSuccess({required this.message});
}

final class CancelTransactionStateError extends CancelTransactionState {
  final String message;

  CancelTransactionStateError({required this.message});
}
