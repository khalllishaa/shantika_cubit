part of 'detail_history_transaction_cubit.dart';

sealed class DetailHistoryTransactionState extends Equatable {
  const DetailHistoryTransactionState();

  @override
  List<Object> get props => [];
}

final class DetailHistoryTransactionInitial
    extends DetailHistoryTransactionState {}

final class DetailHistoryTransactionStateLoading
    extends DetailHistoryTransactionState {}

final class DetailHistoryTransactionStateSuccess
    extends DetailHistoryTransactionState {
  final TransactionDetailModel transaction;

  const DetailHistoryTransactionStateSuccess({required this.transaction});

  @override
  List<Object> get props => [transaction];
}

final class DetailHistoryTransactionStateError
    extends DetailHistoryTransactionState {
  final String message;

  const DetailHistoryTransactionStateError({required this.message});

  @override
  List<Object> get props => [message];
}

// Ini bagian buat dummy pesanan (pakai Map)
final class DetailPesananInitial extends DetailHistoryTransactionState {}

final class DetailPesananLoaded extends DetailHistoryTransactionState {
  final Map<String, dynamic> pesananData;

  const DetailPesananLoaded(this.pesananData);

  @override
  List<Object> get props => [pesananData];
}
