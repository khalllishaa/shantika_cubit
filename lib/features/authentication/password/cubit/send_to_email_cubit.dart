import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shantika_cubit/utility/extensions/dio_exception_extensions.dart';

import '../../../../config/service_locator.dart';
import '../../../../model/response/api_response.dart';
import '../../../../repository/reset_password_repository.dart';
import '../../../../utility/resource/data_state.dart';

part 'send_to_email_state.dart';

class SendToEmailCubit extends Cubit<SendToEmailState> {
  SendToEmailCubit() : super(SendToEmailInitial());

  late ResetPasswordRepository _repository;

  init() {
    _repository = ResetPasswordRepository(serviceLocator.get());
  }

  sendToEmail({required String email}) async {
    emit(SendToEmailStateLoading());

    DataState<ApiResponse> dataState = await _repository.sendResetTokenEmail(email: email);

    switch (dataState) {
      case DataStateSuccess<ApiResponse>():
        {
          emit(SendToEmailStateSuccess(email: email));
        }
      case DataStateError<ApiResponse>():
        {
          emit(SendToEmailStateError(message: dataState.exception?.parseMessage() ?? ""));
        }
      case DataStateLoading<ApiResponse>():
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }
}
