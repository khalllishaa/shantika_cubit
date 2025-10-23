import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shantika_cubit/utility/extensions/dio_exception_extensions.dart';
import 'dart:math';

import '../../../../config/service_locator.dart';
import '../../../../config/user_preference.dart';
import '../../../../firebase/firebase_apple_auth.dart';
import '../../../../firebase/firebase_google.auth.dart';
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
    required String name,
    required String email,
    required String phone,
    File? avatar,
    required String birth,
    required String birthPlace,
    required String gender,
    String? uuid,
  }) async {
    emit(RegisterStateLoading());

    DataState<AuthResponse> dataState = await _repository.registerr(
      name: name,
      email: email,
      phone: phone,
      avatar: avatar,
      birth: birth,
      birthPlace: birthPlace,
      gender: gender,
      uuid: uuid,
    );

    if (dataState is DataStateSuccess<AuthResponse>) {
      _token = dataState.data?.token; // ✅ Pakai getter
      _user = dataState.data?.user; // ✅ Ini akan return UserModel

      if (_token != null) {
        _userPreference.setToken(_token!);
      }
      if (_user != null) {
        _userPreference.setUser(_user!);
      }

      emit(RegisterStateSuccess(token: _token));
    } else if (dataState is DataStateError<AuthResponse>) {
      emit(RegisterStateError(
          message: dataState.exception?.parseMessage() ?? "Terjadi kesalahan"
      ));
    }
  }
}