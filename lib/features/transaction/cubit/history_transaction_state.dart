part of 'history_transaction_cubit.dart';

sealed class HistoryTransactionState extends Equatable {
  const HistoryTransactionState();

  @override
  List<Object> get props => [];
}

final class HistoryTransactionInitial extends HistoryTransactionState {}

final class HistoryTransactionStateLoading extends HistoryTransactionState {}

final class HistoryTransactionStateSuccess extends HistoryTransactionState {
  final List<TransactionModel> transactions;

  HistoryTransactionStateSuccess({required this.transactions});
}

final class HistoryTransactionStateError extends HistoryTransactionState {
  final String message;

  HistoryTransactionStateError({required this.message});
}
