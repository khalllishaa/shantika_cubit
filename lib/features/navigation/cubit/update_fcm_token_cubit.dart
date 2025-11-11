import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shantika_cubit/utility/extensions/dio_exception_extensions.dart';

import '../../../config/service_locator.dart';
import '../../../model/response/api_response.dart';
import '../../../repository/auth_repository.dart';
import '../../../utility/resource/data_state.dart';

part 'update_fcm_token_state.dart';

class UpdateFcmTokenCubit extends Cubit<UpdateFcmTokenState> {
  UpdateFcmTokenCubit() : super(UpdateFcmTokenInitial());

  late AuthRepository _repository;
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  init() {
    _repository = AuthRepository(serviceLocator.get());
  }

  updateFcmToken() async {
    String? fcmToken = await messaging.getToken();
    emit(UpdateFcmTokenStateLoading());

    DataState<ApiResponse> dataState = await _repository.updateFcmToken(fcmToken: fcmToken ?? "");

    switch (dataState) {
      case DataStateSuccess<ApiResponse>():
        {
          emit(UpdateFcmTokenStateSuccess());
        }
      case DataStateError<ApiResponse>():
        {
          emit(
            UpdateFcmTokenStateError(message: dataState.exception?.parseMessage() ?? ""),
          );
        }
      case DataStateLoading<ApiResponse>():
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }
}
