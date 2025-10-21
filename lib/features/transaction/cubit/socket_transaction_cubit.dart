import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shantika_cubit/utility/extensions/dio_exception_extensions.dart';

import '../../../config/service_locator.dart';
import '../../../model/response/api_response.dart';
import '../../../repository/transaction_repository.dart';
import '../../../utility/resource/data_state.dart';
part 'socket_transaction_state.dart';

class SocketTransactionCubit extends Cubit<SocketTransactionState> {
  SocketTransactionCubit() : super(SocketTransactionInitial());

  late TransactionRepository _repository;

  init() {
    _repository = TransactionRepository(serviceLocator.get());
  }

  socketTransaction({required String id, required String paymentCode}) async {
    emit(SocketTransactionStateLoading());

    DataState<ApiResponse> dataState = await _repository.socketTransaction(id: id, paymentCode: paymentCode);

    switch (dataState) {
      case DataStateSuccess<ApiResponse>():
        {
          emit(SocketTransactionStateSuccess(message: dataState.data?.message ?? ""));
        }
      case DataStateError<ApiResponse>():
        {
          emit(SocketTransactionStateError(message: dataState.exception?.parseMessage() ?? ""));
        }
    }
  }
}
