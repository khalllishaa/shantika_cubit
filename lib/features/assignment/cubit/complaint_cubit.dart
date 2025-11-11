import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shantika_cubit/utility/extensions/dio_exception_extensions.dart';

import '../../../config/service_locator.dart';
import '../../../model/response/api_response.dart';
import '../../../repository/assignment_history_repository.dart';
import '../../../utility/resource/data_state.dart';

part 'complaint_state.dart';

class ComplaintCubit extends Cubit<ComplaintState> {
  ComplaintCubit() : super(ComplaintInitial());

  late AssignmentHistoryRepository _repository;

  init() {
    _repository = AssignmentHistoryRepository(serviceLocator.get());
  }

  createComplaint({required String id, required String complain}) async {
    emit(ComplaintStateLoading());

    DataState<ApiResponse> dataState = await _repository.complaint(id: id, complain: complain);

    switch (dataState) {
      case DataStateSuccess<ApiResponse>():
        {
          emit(ComplaintStateSuccess());
        }
      case DataStateError<ApiResponse>():
        {
          emit(ComplaintStateError(message: dataState.exception?.parseMessage() ?? ""));
        }
      case DataStateLoading<ApiResponse>():
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }
}
