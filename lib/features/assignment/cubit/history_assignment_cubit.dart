import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shantika_cubit/utility/extensions/dio_exception_extensions.dart';

import '../../../config/service_locator.dart';
import '../../../model/assignment_history_model.dart';
import '../../../model/response/api_response.dart';
import '../../../model/response/history_assignment_response.dart';
import '../../../repository/assignment_history_repository.dart';
import '../../../utility/resource/data_state.dart';

part 'history_assignment_state.dart';

class HistoryAssignmentCubit extends Cubit<HistoryAssignmentState> {
  HistoryAssignmentCubit() : super(HistoryAssignmentInitial());

  late AssignmentHistoryRepository _repository;

  List<AssignmentHistoryModel> _histories = [];
  String? _status;

  init() {
    _repository = AssignmentHistoryRepository(serviceLocator.get());
    _histories = [];
    _status = null;
  }

  setStatus(String? status) {
    _status = status;
    history();
  }

  history() async {
    emit(HistoryAssignmentStateLoading());

    DataState<ApiResponse<HistoryAssignmentResponse>> dataState = await _repository.assignmentHistory(
      status: _status,
    );

    switch (dataState) {
      case DataStateSuccess<ApiResponse<HistoryAssignmentResponse>>():
        {
          _histories = dataState.data?.data?.guard_history ?? [];
          emit(HistoryAssignmentStateSuccess(histories: _histories));
        }
      case DataStateError<ApiResponse<HistoryAssignmentResponse>>():
        {
          emit(HistoryAssignmentStateError(message: dataState.exception?.parseMessage() ?? ""));
        }
      case DataStateLoading<ApiResponse<HistoryAssignmentResponse>>():
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }
}
