import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shantika_cubit/utility/extensions/dio_exception_extensions.dart';

import '../../../config/service_locator.dart';
import '../../../model/response/api_response.dart';
import '../../../model/response/transaction_detail_response.dart';
import '../../../model/transaction_detail_model.dart';
import '../../../repository/transaction_repository.dart';
import '../../../utility/resource/data_state.dart';

part 'detail_history_transaction_state.dart';

class DetailHistoryTransactionCubit extends Cubit<DetailHistoryTransactionState> {
  DetailHistoryTransactionCubit() : super(DetailHistoryTransactionInitial());

  late TransactionRepository _repository;

  init() {
    _repository = TransactionRepository(serviceLocator.get());
  }

  detailHistory({required String id}) async {
    emit(DetailHistoryTransactionStateLoading());

    DataState<ApiResponse<TransactionDetailResponse>> dataState = await _repository.detailTransaction(id: id);

    switch (dataState) {
      case DataStateSuccess<ApiResponse<TransactionDetailResponse>>():
        {
          emit(
            DetailHistoryTransactionStateSuccess(
                transaction: dataState.data?.data?.transaction ?? TransactionDetailModel()),
          );
        }
      case DataStateError<ApiResponse<TransactionDetailResponse>>():
        {
          emit(DetailHistoryTransactionStateError(message: dataState.exception?.parseMessage() ?? ""));
        }
    }
  }
}
