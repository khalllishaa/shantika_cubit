part of 'create_transaction_cubit.dart';

sealed class CreateTransactionState extends Equatable {
  const CreateTransactionState();

  @override
  List<Object> get props => [];
}

final class CreateTransactionInitial extends CreateTransactionState {}

final class CreateTransactionStateLoading extends CreateTransactionState {}

final class CreateTransactionStateSuccess extends CreateTransactionState {
  final String paymentCode;
  final String id;

  CreateTransactionStateSuccess({required this.paymentCode, required this.id});
}

final class CreateTransactionStateError extends CreateTransactionState {
  final String message;

  CreateTransactionStateError({required this.message});
}
