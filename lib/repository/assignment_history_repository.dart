import 'package:dio/dio.dart';

import '../data/api/api_service.dart';
import '../model/detail_assignment_history_model.dart';
import '../model/response/api_response.dart';
import '../model/response/history_assignment_response.dart';
import '../utility/resource/data_state.dart';
import 'base/base_repository.dart';

class AssignmentHistoryRepository extends BaseRepository {
  final ApiService _apiService;
  AssignmentHistoryRepository(this._apiService);

  Future<DataState<ApiResponse<HistoryAssignmentResponse>>> assignmentHistory({String? status}) async {
    DataState<ApiResponse<HistoryAssignmentResponse>> dataState =
        await getStateOf<ApiResponse<HistoryAssignmentResponse>>(request: () {
      return _apiService.historyAssignment(status: status);
    });

    if (dataState is DataStateSuccess) {
      return DataStateSuccess(dataState.data!);
    } else {
      return DataStateError(dataState.exception!);
    }
  }

  Future<DataState<ApiResponse<DetailAssignmentHistoryModel>>> detailAssignmentHistory({required String id}) async {
    DataState<ApiResponse<DetailAssignmentHistoryModel>> dataState =
        await getStateOf<ApiResponse<DetailAssignmentHistoryModel>>(request: () {
      return _apiService.detailHistoryAssignment(id: id);
    });

    if (dataState is DataStateSuccess) {
      return DataStateSuccess(dataState.data!);
    } else {
      return DataStateError(dataState.exception!);
    }
  }

  Future<DataState<ApiResponse>> reviewAssignment({
    required String id,
    required String starCount,
    required String review,
    List<MultipartFile>? attachment,
  }) async {
    DataState<ApiResponse> dataState = await getStateOf<ApiResponse>(request: () {
      return _apiService.reviewAssignment(
        star: starCount,
        review: review,
        id: id,
        attachment: attachment,
      );
    });

    if (dataState is DataStateSuccess) {
      return DataStateSuccess(dataState.data!);
    } else {
      return DataStateError(dataState.exception!);
    }
  }

  Future<DataState<ApiResponse>> updateReviewAssignment({
    required String id,
    required String starCount,
    required String review,
    List<MultipartFile>? attachment,
  }) async {
    DataState<ApiResponse> dataState = await getStateOf<ApiResponse>(request: () {
      return _apiService.updateReviewAssignment(id: id, star: starCount, review: review);
    });

    if (dataState is DataStateSuccess) {
      return DataStateSuccess(dataState.data!);
    } else {
      return DataStateError(dataState.exception!);
    }
  }

  Future<DataState<ApiResponse>> complaint({
    required String id,
    required String complain,
  }) async {
    DataState<ApiResponse> dataState = await getStateOf<ApiResponse>(request: () {
      return _apiService.complaintGuard(id: id, complain: complain);
    });

    if (dataState is DataStateSuccess) {
      return DataStateSuccess(dataState.data!);
    } else {
      return DataStateError(dataState.exception!);
    }
  }
}
