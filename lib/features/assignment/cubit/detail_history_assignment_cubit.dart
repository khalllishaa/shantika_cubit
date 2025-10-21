import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shantika_cubit/utility/extensions/dio_exception_extensions.dart';

import '../../../config/service_locator.dart';
import '../../../model/detail_assignment_history_model.dart';
import '../../../model/response/api_response.dart';
import '../../../repository/assignment_history_repository.dart';
import '../../../utility/resource/data_state.dart';
part 'detail_history_assignment_state.dart';

class DetailHistoryAssignmentCubit extends Cubit<DetailHistoryAssignmentState> {
  DetailHistoryAssignmentCubit() : super(DetailHistoryAssignmentInitial());

  late AssignmentHistoryRepository _repository;
  init() {
    _repository = AssignmentHistoryRepository(serviceLocator.get());
  }

  detailHistory({required String id}) async {
    emit(DetailHistoryAssignmentStateLoading());

    DataState<ApiResponse<DetailAssignmentHistoryModel>> dataState = await _repository.detailAssignmentHistory(id: id);

    switch (dataState) {
      case DataStateSuccess<ApiResponse<DetailAssignmentHistoryModel>>():
        {
          emit(
            DetailHistoryAssignmentStateSuccess(data: dataState.data?.data ?? DetailAssignmentHistoryModel()),
          );
        }
      case DataStateError<ApiResponse<DetailAssignmentHistoryModel>>():
        {
          emit(DetailHistoryAssignmentStateError(message: dataState.exception?.parseMessage() ?? ""));
        }
    }
  }
}
