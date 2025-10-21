import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shantika_cubit/utility/extensions/dio_exception_extensions.dart';

import '../../../../config/service_locator.dart';
import '../../../../config/user_preference.dart';
import '../../../../firebase/firebase_google.auth.dart';
import '../../../../model/response/api_response.dart';
import '../../../../model/response/auth_response.dart';
import '../../../../model/user_model.dart';
import '../../../../repository/auth_repository.dart';
import '../../../../utility/resource/data_state.dart';

part 'login_google_state.dart';

class LoginGoogleCubit extends Cubit<LoginGoogleState> {
  LoginGoogleCubit() : super(LoginGoogleInitial());

  late AuthRepository _authRepository;
  late UserPreference _userPreference;
  FirebaseGoogleAuth _firebaseGoogleAuth = FirebaseGoogleAuth();
  FirebaseMessaging _messaging = FirebaseMessaging.instance;

  String? _token;
  UserModel? _user;

  init() {
    _authRepository = AuthRepository(serviceLocator.get());
    _userPreference = serviceLocator.get();
  }

  loginGoogle() async {
    emit(LoginGoogleStateLoading());
    String? fcmToken = await _messaging.getToken();

    _firebaseGoogleAuth.signInWithGoogle(
      onSuccess: (uid, email, firstName, lastName) async {
        DataState<ApiResponse<AuthResponse>> dataState = await _authRepository.googleLogin(
          email: email,
          firebaseUid: uid,
          fcmToken: fcmToken,
        );
        switch (dataState) {
          case DataStateSuccess<ApiResponse<AuthResponse>>():
            {
              _token = dataState.data?.data?.token ?? null;
              _user = dataState.data?.data?.user ?? UserModel();
              _userPreference.setToken(_token ?? "");
              _userPreference.setUser(_user ?? UserModel());
              emit(LoginGoogleStateSuccess());
            }
          case DataStateError<ApiResponse<AuthResponse>>():
            {
              emit(LoginGoogleStateError(message: dataState.exception?.parseMessage() ?? ""));
            }
        }
      },
      onError: (e) {
        print(e);
        emit(LoginGoogleStateError(message: e));
      },
    );
  }
}
