import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shantika_cubit/utility/extensions/dio_exception_extensions.dart';

import '../../../config/service_locator.dart';
import '../../../model/response/api_response.dart';
import '../../../repository/transaction_repository.dart';
import '../../../utility/resource/data_state.dart';

part 'cancel_transaction_state.dart';

class CancelTransactionCubit extends Cubit<CancelTransactionState> {
  CancelTransactionCubit() : super(CancelTransactionInitial());

  late TransactionRepository _repository;

  init() {
    _repository = TransactionRepository(serviceLocator.get());
  }

  cancelTransaction({required String id}) async {
    emit(CancelTransactionStateLoading());

    DataState<ApiResponse> dataState = await _repository.cancelTransaction(id: id);

    switch (dataState) {
      case DataStateSuccess<ApiResponse>():
        {
          emit(CancelTransactionStateSuccess(message: dataState.data?.message ?? ""));
        }
      case DataStateError<ApiResponse>():
        {
          emit(
            CancelTransactionStateError(message: dataState.exception?.parseMessage() ?? ""),
          );
        }
    }
  }
}
