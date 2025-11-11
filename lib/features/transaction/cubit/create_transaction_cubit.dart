import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shantika_cubit/utility/extensions/dio_exception_extensions.dart';

import '../../../config/service_locator.dart';
import '../../../model/request/transaction_request.dart';
import '../../../model/response/api_response.dart';
import '../../../repository/transaction_repository.dart';
import '../../../utility/resource/data_state.dart';

part 'create_transaction_state.dart';

class CreateTransactionCubit extends Cubit<CreateTransactionState> {
  CreateTransactionCubit() : super(CreateTransactionInitial());

  late TransactionRepository _repository;

  init() {
    _repository = TransactionRepository(serviceLocator.get());
  }

  createTransaction({required TransactionRequest request}) async {
    emit(CreateTransactionStateLoading());

    DataState<ApiResponse> dataState = await _repository.createTransaction(request: request);

    switch (dataState) {
      case DataStateSuccess<ApiResponse>():
        {
          emit(CreateTransactionStateSuccess(
            paymentCode: dataState.data?.data['transaction']['payment_code'] ?? "",
            id: dataState.data?.data['transaction']['id'] ?? "",
          ));
        }
      case DataStateError<ApiResponse>():
        {
          emit(CreateTransactionStateError(message: dataState.exception?.parseMessage() ?? ""));
        }
      case DataStateLoading<ApiResponse>():
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }
}
