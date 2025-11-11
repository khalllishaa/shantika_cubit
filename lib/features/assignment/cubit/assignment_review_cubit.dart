import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:shantika_cubit/utility/extensions/dio_exception_extensions.dart';

import '../../../config/service_locator.dart';
import '../../../model/response/api_response.dart';
import '../../../repository/assignment_history_repository.dart';
import '../../../utility/resource/data_state.dart';

part 'assignment_review_state.dart';

class AssignmentReviewCubit extends Cubit<AssignmentReviewState> {
  AssignmentReviewCubit() : super(AssignmentReviewInitial());

  late AssignmentHistoryRepository _repository;

  init() {
    _repository = AssignmentHistoryRepository(serviceLocator.get());
  }

  review({
    required String id,
    required String starCount,
    required String review,
    File? attachment,
  }) async {
    MultipartFile? multipart;

    if (attachment != null) {
      multipart = await MultipartFile.fromFile(
        attachment.path,
        filename: attachment.path.split('/').last,
      );
    }
    emit(AssignmentReviewStateLoading());

    DataState<ApiResponse> dataState = await _repository.reviewAssignment(
      attachment: multipart == null ? null : [multipart],
      id: id,
      starCount: starCount,
      review: review,
    );

    switch (dataState) {
      case DataStateSuccess<ApiResponse>():
        {
          emit(AssignmentReviewStateSuccess());
        }
      case DataStateError<ApiResponse>():
        {
          emit(AssignmentReviewStateError(message: dataState.exception?.parseMessage() ?? ""));
        }
      case DataStateLoading<ApiResponse>():
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }
}
