import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shantika_cubit/utility/extensions/dio_exception_extensions.dart';
import 'dart:math';

import '../../../../config/service_locator.dart';
import '../../../../config/user_preference.dart';
import '../../../../firebase/firebase_apple_auth.dart';
import '../../../../firebase/firebase_google.auth.dart';
import '../../../../model/response/api_response.dart';
import '../../../../model/response/auth_response.dart';
import '../../../../model/user_model.dart';
import '../../../../repository/auth_repository.dart';
import '../../../../utility/resource/data_state.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  late AuthRepository _repository;

  late UserPreference _userPreference;

  String? _token;

  UserModel? _user;

  FirebaseGoogleAuth _firebaseGoogleAuth = FirebaseGoogleAuth();
  FirebaseAppleAuth _firebaseAppleAuthAuth = FirebaseAppleAuth();
  FirebaseMessaging _messaging = FirebaseMessaging.instance;
  Random _random = Random();

  init() {
    _repository = AuthRepository(serviceLocator.get());
    _userPreference = serviceLocator.get();
    _token = null;
    _user = null;
  }

  register({
    required String firstName,
    String? lastName,
    required String email,
    required String password,
    required String confirmPassword,
    String? appleId,
    String? firebaseUid,
  }) async {
    emit(RegisterStateLoading());

    DataState<ApiResponse<AuthResponse>> dataState = await _repository.register(
      firstName: firstName,
      email: email,
      lastName: lastName,
      password: password,
      confirmPassword: confirmPassword,
      appleId: appleId,
      firebaseUid: firebaseUid,
    );

    switch (dataState) {
      case DataStateSuccess<ApiResponse<AuthResponse>>():
        {
          _token = dataState.data?.data?.token ?? null;
          _user = dataState.data?.data?.user ?? UserModel();
          _userPreference.setToken(_token ?? "");
          _userPreference.setUser(_user ?? UserModel());
          emit(RegisterStateSuccess());
        }
      case DataStateError<ApiResponse<AuthResponse>>():
        {
          emit(RegisterStateError(message: dataState.exception?.parseMessage() ?? ""));
        }
    }
  }

  registerWithGoogle() async {
    emit(RegisterStateLoading());
    String? fcmToken = await _messaging.getToken();

    _firebaseGoogleAuth.signInWithGoogle(
      onSuccess: (uid, email, firstName, lastName) async {
        DataState<ApiResponse<AuthResponse>> dataState = await _repository.registerWithGoogleOrApple(
          appleId: null,
          firebaseUid: uid,
          firstName: firstName == "" ? "User" : firstName,
          email: email,
          lastName: lastName == "" ? "${_random.nextInt(99999)}" : lastName,
          fcmToken: fcmToken,
        );

        switch (dataState) {
          case DataStateSuccess<ApiResponse<AuthResponse>>():
            {
              _token = dataState.data?.data?.token ?? null;
              _user = dataState.data?.data?.user ?? UserModel();
              _userPreference.setToken(_token ?? "");
              _userPreference.setUser(_user ?? UserModel());
              emit(RegisterStateSuccess());
            }
          case DataStateError<ApiResponse<AuthResponse>>():
            {
              emit(RegisterStateError(message: dataState.exception?.parseMessage() ?? ""));
            }
        }
      },
      onError: (e) {
        emit(RegisterStateError(message: e));
      },
    );
  }

  registerWithApple() async {
    emit(RegisterStateLoading());
    String? fcmToken = await _messaging.getToken();

    _firebaseAppleAuthAuth.signInWithApple(
      onSuccess: (uid, appleId, name, email) async {
        DataState<ApiResponse<AuthResponse>> dataState = await _repository.registerWithGoogleOrApple(
          appleId: appleId,
          firebaseUid: null,
          firstName: "User",
          email: email,
          lastName: "${_random.nextInt(9999)}",
          fcmToken: fcmToken,
        );

        switch (dataState) {
          case DataStateSuccess<ApiResponse<AuthResponse>>():
            {
              _token = dataState.data?.data?.token ?? null;
              _user = dataState.data?.data?.user ?? UserModel();
              _userPreference.setToken(_token ?? "");
              _userPreference.setUser(_user ?? UserModel());
              emit(RegisterStateSuccess());
            }
          case DataStateError<ApiResponse<AuthResponse>>():
            {
              emit(RegisterStateError(message: dataState.exception?.parseMessage() ?? ""));
            }
        }
      },
      onError: (e) {
        emit(RegisterStateError(message: e));
      },
    );
  }
}
