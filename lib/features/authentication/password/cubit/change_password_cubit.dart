import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shantika_cubit/utility/extensions/dio_exception_extensions.dart';

import '../../../../config/service_locator.dart';
import '../../../../model/response/api_response.dart';
import '../../../../repository/reset_password_repository.dart';
import '../../../../utility/resource/data_state.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit() : super(ChangePasswordInitial());

  late ResetPasswordRepository _repository;

  init() {
    _repository = ResetPasswordRepository(serviceLocator.get());
  }

  changePassword({
    required String password,
    required String confirmPassword,
    required String email,
  }) async {
    emit(ChangePasswordStateLoading());

    DataState<ApiResponse> dataState = await _repository.changePassword(
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );

    switch (dataState) {
      case DataStateSuccess<ApiResponse>():
        {
          emit(ChangePasswordStateSuccess());
        }
      case DataStateError<ApiResponse>():
        {
          emit(ChangePasswordStateError(message: dataState.exception?.parseMessage() ?? ""));
        }
      case DataStateLoading<ApiResponse>():
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }
}
