import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shantika_cubit/utility/extensions/dio_exception_extensions.dart';

import '../../../../config/service_locator.dart';
import '../../../../config/user_preference.dart';
import '../../../../firebase/firebase_apple_auth.dart';
import '../../../../model/response/api_response.dart';
import '../../../../model/response/auth_response.dart';
import '../../../../model/user_model.dart';
import '../../../../repository/auth_repository.dart';
import '../../../../utility/resource/data_state.dart';

part 'login_apple_state.dart';

class LoginAppleCubit extends Cubit<LoginAppleState> {
  LoginAppleCubit() : super(LoginAppleInitial());

  late AuthRepository _repository;
  late UserPreference _preference;

  UserModel? _user;
  String? _token;

  FirebaseAppleAuth _firebaseAppleAuth = FirebaseAppleAuth();
  FirebaseMessaging _messaging = FirebaseMessaging.instance;

  init() {
    _repository = AuthRepository(serviceLocator.get());
    _preference = serviceLocator.get();
  }

  loginApple() async {
    emit(LoginAppleStateLoading());
    String? fcmToken = await _messaging.getToken();
    _firebaseAppleAuth.signInWithApple(
      onSuccess: (String uid, String appleId, String name, String email) async {
        DataState<ApiResponse<AuthResponse>> dataState = await _repository.appleLogin(
          appleId: appleId,
          firebaseUid: null,
          fcmToken: fcmToken,
        );

        switch (dataState) {
          case DataStateSuccess<ApiResponse<AuthResponse>>():
            {
              _token = dataState.data?.data?.token;
              _user = dataState.data?.data?.user ?? UserModel();

              _preference.setToken(_token ?? "");
              _preference.setUser(_user ?? UserModel());
              emit(LoginAppleStateSuccess());
            }
          case DataStateError<ApiResponse<AuthResponse>>():
            {
              emit(LoginAppleStateError(message: dataState.exception?.parseMessage() ?? ""));
            }
        }
      },
      onError: (e) {
        emit(LoginAppleStateError(message: e));
      },
    );
  }
}
