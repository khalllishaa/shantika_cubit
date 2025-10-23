import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shantika_cubit/utility/extensions/dio_exception_extensions.dart';

import '../../../../config/service_locator.dart';
import '../../../../config/user_preference.dart';
import '../../../../model/response/auth_response.dart';
import '../../../../model/users_model.dart'; // ✅ Import UsersModel
import '../../../../repository/auth_repository.dart';
import '../../../../utility/resource/data_state.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  late AuthRepository _repository;
  late UserPreference _userPreference;

  String? _token;
  UsersModel? _user;

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
      _token = dataState.data?.token;
      _user = dataState.data?.user; // ✅ Sudah UsersModel

      if (_token != null) {
        _userPreference.setToken(_token!);
      }

      // ✅ COMMENT DULU karena UserPreference expect UserModel, bukan UsersModel
      // if (_user != null) {
      //   _userPreference.setUser(_user!);
      // }

      emit(RegisterStateSuccess(token: _token));
    } else if (dataState is DataStateError<AuthResponse>) {
      emit(RegisterStateError(
          message: dataState.exception?.parseMessage() ?? "Terjadi kesalahan"
      ));
    }
  }
}