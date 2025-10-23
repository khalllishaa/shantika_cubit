import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shantika_cubit/utility/extensions/dio_exception_extensions.dart';
// ❌ HAPUS import extension
// import 'package:shantika_cubit/utility/extensions/user_extensions.dart';

import '../../../../config/service_locator.dart';
import '../../../../config/user_preference.dart';
import '../../../../model/response/auth_response.dart';
import '../../../../model/users_model.dart';
import '../../../../repository/auth_repository.dart';
import '../../../../utility/resource/data_state.dart';

part 'login_phone_state.dart';

class LoginPhoneCubit extends Cubit<LoginPhoneState> {
  LoginPhoneCubit() : super(LoginPhoneInitial());

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

  login({required String phone}) async {
    emit(LoginPhoneStateLoading());

    DataState<AuthResponse> dataState = await _repository.loginByPhone(
      phone: phone,
    );

    switch (dataState) {
      case DataStateSuccess<AuthResponse>():
        {
          _token = dataState.data?.token;
          _user = dataState.data?.user; // ✅ Langsung assign, sudah UsersModel!

          _userPreference.setToken(_token ?? "");

          emit(LoginPhoneStateSuccess(token: _token, user: _user));
        }
      case DataStateError<AuthResponse>():
        {
          emit(LoginPhoneStateError(
            message: dataState.exception?.parseMessage() ?? "Terjadi kesalahan",
          ));
        }
    }
  }
}