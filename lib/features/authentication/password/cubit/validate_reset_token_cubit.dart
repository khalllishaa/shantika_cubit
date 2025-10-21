import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shantika_cubit/utility/extensions/dio_exception_extensions.dart';

import '../../../../config/service_locator.dart';
import '../../../../model/response/api_response.dart';
import '../../../../repository/reset_password_repository.dart';
import '../../../../utility/resource/data_state.dart';

part 'validate_reset_token_state.dart';

class ValidateResetTokenCubit extends Cubit<ValidateResetTokenState> {
  ValidateResetTokenCubit() : super(ValidateResetTokenInitial());

  late ResetPasswordRepository _repository;

  init() {
    _repository = ResetPasswordRepository(serviceLocator.get());
  }

  validateResetToken({required String email, required String token}) async {
    emit(ValidateResetTokenStateLoading());

    DataState<ApiResponse> dataState = await _repository.validateResetToken(email: email, token: token);

    switch (dataState) {
      case DataStateSuccess<ApiResponse>():
        {
          emit(ValidateResetTokenStateSuccess(email: email));
        }
      case DataStateError<ApiResponse>():
        {
          emit(ValidateResetTokenStateError(message: dataState.exception?.parseMessage() ?? ""));
        }
    }
  }
}
