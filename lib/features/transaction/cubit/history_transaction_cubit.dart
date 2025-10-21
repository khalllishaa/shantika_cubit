import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shantika_cubit/utility/extensions/dio_exception_extensions.dart';

import '../../../config/service_locator.dart';
import '../../../model/response/api_response.dart';
import '../../../model/response/transaction_response.dart';
import '../../../model/transaction_model.dart';
import '../../../repository/transaction_repository.dart';
import '../../../utility/resource/data_state.dart';

part 'history_transaction_state.dart';

class HistoryTransactionCubit extends Cubit<HistoryTransactionState> {
  HistoryTransactionCubit() : super(HistoryTransactionInitial());

  late TransactionRepository _repository;
  String? _status;

  List<TransactionModel> _transactions = [];

  init() {
    _repository = TransactionRepository(serviceLocator.get());
    _transactions = [];
    _status = null;
  }

  setStatus(String? status) {
    _status = status;
    historyTransaction();
  }

  historyTransaction() async {
    emit(HistoryTransactionStateLoading());

    DataState<ApiResponse<TransactionResponse>> dataState = await _repository.transaction(status: _status);

    switch (dataState) {
      case DataStateSuccess<ApiResponse<TransactionResponse>>():
        {
          _transactions = dataState.data?.data?.transaction ?? [];
          emit(HistoryTransactionStateSuccess(transactions: _transactions));
        }
      case DataStateError<ApiResponse<TransactionResponse>>():
        {
          emit(HistoryTransactionStateError(message: dataState.exception?.parseMessage() ?? ""));
        }
    }
  }
}
