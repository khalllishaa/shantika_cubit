import 'package:equatable/equatable.dart';
import 'package:shantika_cubit/model/history_order_model.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object?> get props => [];
}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderLoaded extends OrderState {
  final HistoryOrderModel data;

  const OrderLoaded(this.data);

  @override
  List<Object?> get props => [data];
}

class OrderError extends OrderState {
  final String message;

  const OrderError(this.message);

  @override
  List<Object?> get props => [message];
}