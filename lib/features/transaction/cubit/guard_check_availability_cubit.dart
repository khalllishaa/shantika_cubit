import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shantika_cubit/utility/extensions/dio_exception_extensions.dart';

import '../../../config/service_locator.dart';
import '../../../model/request/transaction_request.dart';
import '../../../model/response/api_response.dart';
import '../../../repository/guard_repository.dart';
import '../../../utility/resource/data_state.dart';

part 'guard_check_availability_state.dart';

class GuardCheckAvailibilityCubit extends Cubit<GuardCheckAvailibilityState> {
  GuardCheckAvailibilityCubit() : super(GuardCheckAvailibilityInitial());

  late GuardRepository _repository;

  init() {
    _repository = GuardRepository(serviceLocator.get());
  }

  checkGuardAvailability({required TransactionRequest request}) async {
    emit(GuardCheckAvailibilityStateLoading());

    DataState<ApiResponse> dataState = await _repository.checkGuardAvailability(request: request);

    switch (dataState) {
      case DataStateSuccess<ApiResponse>():
        {
          emit(
            GuardCheckAvailibilityStateSuccess(
              message: (dataState.data?.data?['is_available'] ?? false) ? "Guard Tersedia" : "Guard Tidak Tersedia",
            ),
          );
        }
      case DataStateError<ApiResponse>():
        {
          emit(GuardCheckAvailibilityStateError(message: dataState.exception?.parseMessage() ?? ""));
        }
      case DataStateLoading<ApiResponse>():
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }
}
