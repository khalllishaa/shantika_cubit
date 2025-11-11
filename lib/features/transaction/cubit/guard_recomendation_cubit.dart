import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shantika_cubit/utility/extensions/dio_exception_extensions.dart';

import '../../../config/service_locator.dart';
import '../../../model/guard_model.dart';
import '../../../model/response/api_response.dart';
import '../../../repository/guard_repository.dart';
import '../../../utility/resource/data_state.dart';
part 'guard_recomendation_state.dart';

class GuardRecomendationCubit extends Cubit<GuardRecomendationState> {
  GuardRecomendationCubit() : super(GuardRecomendationInitial());

  late GuardRepository _repository;

  init() {
    _repository = GuardRepository(serviceLocator.get());
  }

  guardRecomendation({
    required String guardClassId,
    required String startTime,
    required String endTime,
  }) async {
    emit(GuardRecomendationStateLoading());

    DataState<ApiResponse<GuardModel>> dataState = await _repository.guardRecomendation(
      guardClassId: guardClassId,
      startTime: startTime,
      endTime: endTime,
    );

    switch (dataState) {
      case DataStateSuccess<ApiResponse<GuardModel>>():
        {
          emit(GuardRecomendationStateSuccess(guard: dataState.data?.data ?? GuardModel()));
        }
      case DataStateError<ApiResponse<GuardModel>>():
        {
          emit(GuardRecomendationStateError(message: dataState.exception?.parseMessage() ?? ""));
        }
      case DataStateLoading<ApiResponse<GuardModel>>():
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }
}
