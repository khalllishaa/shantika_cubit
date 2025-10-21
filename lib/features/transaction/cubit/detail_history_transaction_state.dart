part of 'detail_history_transaction_cubit.dart';

sealed class DetailHistoryTransactionState extends Equatable {
  const DetailHistoryTransactionState();

  @override
  List<Object> get props => [];
}

final class DetailHistoryTransactionInitial extends DetailHistoryTransactionState {}

final class DetailHistoryTransactionStateLoading extends DetailHistoryTransactionState {}

final class DetailHistoryTransactionStateSuccess extends DetailHistoryTransactionState {
  final TransactionDetailModel transaction;

  DetailHistoryTransactionStateSuccess({required this.transaction});
}

final class DetailHistoryTransactionStateError extends DetailHistoryTransactionState {
  final String message;

  DetailHistoryTransactionStateError({required this.message});
}
