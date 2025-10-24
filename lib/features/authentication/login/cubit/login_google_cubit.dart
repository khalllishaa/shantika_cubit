import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shantika_cubit/utility/extensions/dio_exception_extensions.dart';

import '../../../../config/service_locator.dart';
import '../../../../config/user_preference.dart';
import '../../../../firebase/firebase_google.auth.dart';
import '../../../../model/response/auth_response.dart';
import '../../../../model/users_model.dart';
import '../../../../repository/auth_repository.dart';
import '../../../../utility/resource/data_state.dart';

part 'login_google_state.dart';

class LoginGoogleCubit extends Cubit<LoginGoogleState> {
  LoginGoogleCubit() : super(LoginGoogleInitial());

  late AuthRepository _authRepository;
  late UserPreference _userPreference;

  final FirebaseGoogleAuth _firebaseGoogleAuth = FirebaseGoogleAuth();
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  String? _token;
  UsersModel? _user;

  init() {
    _authRepository = AuthRepository(serviceLocator.get());
    _userPreference = serviceLocator.get();
    _token = null;
    _user = null;
  }

  /// ✅ Login with Google - Register as new user
  loginGoogle() async {
    emit(LoginGoogleStateLoading());

    _firebaseGoogleAuth.signInWithGoogle(
      onSuccess: (uid, email, firstName, lastName) async {
        // ✅ Emit state untuk popup input data lengkap
        emit(LoginGoogleNeedMoreInfo(
          firebaseUid: uid,
          email: email,
          name: "$firstName $lastName".trim(),
        ));
      },
      onError: (errorMessage) {
        emit(LoginGoogleStateError(message: errorMessage));
      },
    );
  }

  /// ✅ Complete registration dengan data lengkap dari user
  completeGoogleRegistration({
    required String firebaseUid,
    required String name,
    required String email,
    required String phone,
    required String birth,
    required String birthPlace,
    required String gender,
  }) async {
    emit(LoginGoogleStateLoading());

    DataState<AuthResponse> dataState = await _authRepository.registerr(
      name: name,
      email: email,
      phone: phone,
      avatar: null,
      birth: birth,
      birthPlace: birthPlace,
      gender: gender,
      uuid: firebaseUid, // ✅ Firebase UID sebagai UUID
    );

    if (dataState is DataStateSuccess<AuthResponse>) {
      _token = dataState.data?.token;
      _user = dataState.data?.user;

      if (_token != null) {
        _userPreference.setToken(_token!);
      }

      emit(LoginGoogleStateSuccess());
    } else if (dataState is DataStateError<AuthResponse>) {
      emit(LoginGoogleStateError(
          message: dataState.exception?.parseMessage() ?? "Registrasi dengan Google gagal"
      ));
    }
  }
}