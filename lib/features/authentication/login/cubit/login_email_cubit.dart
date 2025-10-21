import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shantika_cubit/utility/extensions/dio_exception_extensions.dart';

import '../../../../config/service_locator.dart';
import '../../../../config/user_preference.dart';
import '../../../../model/response/api_response.dart';
import '../../../../model/response/auth_response.dart';
import '../../../../model/user_model.dart';
import '../../../../repository/auth_repository.dart';
import '../../../../utility/resource/data_state.dart';

part 'login_email_state.dart';

class LoginEmailCubit extends Cubit<LoginEmailState> {
  LoginEmailCubit() : super(LoginEmailInitial());

  late AuthRepository _repository;
  late UserPreference _preference;

  FirebaseMessaging _messaging = FirebaseMessaging.instance;

  String? _token;
  UserModel? _user;

  init() {
    _repository = AuthRepository(serviceLocator.get());
    _preference = serviceLocator.get();
    _token = null;
    _user = null;
  }

  login({
    required String email,
    required String password,
    String? firebaseUid,
  }) async {
    String? fcmToken = await _messaging.getToken();
    emit(LoginStateEmailLoading());

    DataState<ApiResponse<AuthResponse>> dataState = await _repository.login(
      email: email,
      password: password,
      firebaseUid: firebaseUid,
      fcmToken: fcmToken,
    );

    switch (dataState) {
      case DataStateSuccess<ApiResponse<AuthResponse>>():
        {
          _token = dataState.data?.data?.token;
          _user = dataState.data?.data?.user ?? UserModel();

          _preference.setToken(_token ?? "");
          _preference.setUser(_user ?? UserModel());

          emit(LoginStateEmailSuccess());
        }
      case DataStateError<ApiResponse<AuthResponse>>():
        {
          emit(LoginStateEmailError(message: dataState.exception?.parseMessage() ?? ""));
        }
    }
  }
}
