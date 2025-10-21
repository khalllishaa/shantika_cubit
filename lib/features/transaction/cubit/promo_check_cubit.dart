import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shantika_cubit/utility/extensions/dio_exception_extensions.dart';

import '../../../config/service_locator.dart';
import '../../../model/guard_model.dart';
import '../../../model/request/transaction_request.dart';
import '../../../model/response/api_response.dart';
import '../../../repository/promo_repository.dart';
import '../../../utility/resource/data_state.dart';

part 'promo_check_state.dart';

class PromoCheckCubit extends Cubit<PromoCheckState> {
  PromoCheckCubit() : super(PromoCheckInitial());

  late PromoRepository _repository;

  init() {
    _repository = PromoRepository(serviceLocator.get());
  }

  checkPromo({required TransactionRequest request, GuardModel? guard}) async {
    emit(PromoCheckStateLoading());

    DataState<ApiResponse> dataState = await _repository.checkPromo(request: request);

    switch (dataState) {
      case DataStateSuccess<ApiResponse>():
        {
          emit(PromoCheckStateSuccess(discount: dataState.data?.data['discount'] ?? 0, guard: guard));
        }
      case DataStateError<ApiResponse>():
        {
          emit(PromoCheckStateError(message: dataState.exception?.parseMessage() ?? ""));
        }
    }
  }
}
