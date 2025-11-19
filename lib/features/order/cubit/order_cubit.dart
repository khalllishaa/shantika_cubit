import 'package:bloc/bloc.dart';
import 'package:shantika_cubit/features/order/cubit/order_state.dart';
import 'package:shantika_cubit/repository/order_repository.dart';

class OrderCubit extends Cubit<OrderState> {
  final OrderRepository _repository;

  OrderCubit(this._repository) : super (OrderInitial());

  Future<void> loadHistoryOrder() async {
    emit(OrderLoading());
    try {
      print('Fetching order data...');
      final data = await _repository.getHistoryOrder();
      print('Oder data loaded successfully');
      emit(OrderLoaded(data));
    } catch (e) {
      print('Error loading order: $e');
      emit(OrderError(e.toString()));
    }
  }

  Future<void> refreshHistoryOrder() async {
    await loadHistoryOrder();
  }
}