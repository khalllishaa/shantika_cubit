import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../data/api/api_service.dart';
import '../model/response/api_response.dart';
import '../model/response/auth_response.dart';
import '../utility/resource/data_state.dart';
import 'base/base_repository.dart';

class AuthRepository extends BaseRepository {
  final ApiService _apiService;

  AuthRepository(this._apiService);

  // /// ✅ Register baru (endpoint /customer/registration)
  // /// Response: AuthResponse langsung tanpa wrapper ApiResponse
  // Future<DataState<AuthResponse>> registerr({
  //   required String name,
  //   required String email,
  //   required String phone,
  //   File? avatar,
  //   required String birth,
  //   required String birthPlace,
  //   required String gender,
  //   String? uuid,
  // }) async {
  //   return await getStateOf<AuthResponse>(
  //     request: () async {
  //       final response = await _apiService.registerr(
  //         name: name,
  //         email: email,
  //         phone: phone,
  //         avatar: avatar,
  //         birth: birth,
  //         birth_place: birthPlace,
  //         gender: gender,
  //         uuid: uuid,
  //       );
  //
  //       // ✅ Parse langsung dari response.data (bukan dari response.data['data'])
  //       final authResponse = AuthResponse.fromJson(response.data as Map<String, dynamic>);
  //
  //       return HttpResponse<AuthResponse>(
  //         authResponse,
  //         response.response,
  //       );
  //     },
  //   );
  // }
  //
  Future<DataState<AuthResponse>> loginByPhone({
    required String phone,
  }) async {
    return await getStateOf<AuthResponse>(
      request: () async {
        final response = await _apiService.loginByPhone(phone: phone);

        // ✅ Parse langsung dari response.data
        final authResponse = AuthResponse.fromJson(response.data as Map<String, dynamic>);

        return HttpResponse<AuthResponse>(
          authResponse,
          response.response,
        );
      },
    );
  }

  /// ✅ Register baru (endpoint /customer/registration)
  Future<DataState<AuthResponse>> registerr({
    required String name,
    required String email,
    required String phone,
    File? avatar,
    required String birth,
    required String birthPlace,
    required String gender,
    String? uuid,
  }) async {
    return await getStateOf<AuthResponse>(
      request: () => _apiService.registerr(
        name: name,
        email: email,
        phone: phone,
        avatar: avatar,
        birth: birth,
        birth_place: birthPlace,
        gender: gender,
        uuid: uuid,
      ),
    );
  }

  // /// ✅ Login by phone
  // Future<DataState<AuthResponse>> loginByPhone({
  //   required String phone,
  // }) async {
  //   return await getStateOf<AuthResponse>(
  //     request: () => _apiService.loginByPhone(phone: phone),
  //   );
  // }


  /// Register lama (untuk compatibility)
  Future<DataState<ApiResponse<AuthResponse>>> register({
    required String firstName,
    String? lastName,
    required String email,
    String? password,
    String? confirmPassword,
    String? appleId,
    String? firebaseUid,
  }) async {
    DataState<ApiResponse<AuthResponse>> dataStateAuthResponse =
    await getStateOf<ApiResponse<AuthResponse>>(
      request: () => _apiService.register(
        first_name: firstName,
        last_name: lastName,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
        appleId: appleId,
        firebaseUid: firebaseUid,
      ),
    );

    if (dataStateAuthResponse is DataStateSuccess) {
      return DataStateSuccess(dataStateAuthResponse.data!);
    } else {
      return DataStateError(dataStateAuthResponse.exception!);
    }
  }

  Future<DataState<ApiResponse<AuthResponse>>> registerWithGoogleOrApple({
    required String firstName,
    String? lastName,
    required String email,
    String? appleId,
    String? firebaseUid,
    String? fcmToken,
  }) async {
    DataState<ApiResponse<AuthResponse>> dataStateAuthResponse =
    await getStateOf<ApiResponse<AuthResponse>>(
      request: () => _apiService.registerWithGoogleOrApple(
        first_name: firstName,
        last_name: lastName,
        email: email,
        appleId: appleId,
        firebaseUid: firebaseUid,
        fcm_token: fcmToken,
      ),
    );

    if (dataStateAuthResponse is DataStateSuccess) {
      return DataStateSuccess(dataStateAuthResponse.data!);
    } else {
      return DataStateError(dataStateAuthResponse.exception!);
    }
  }

  Future<DataState<ApiResponse<AuthResponse>>> login({
    required String email,
    required String password,
    String? firebaseUid,
    String? fcmToken,
  }) async {
    DataState<ApiResponse<AuthResponse>> dataStateAuthResponse =
    await getStateOf<ApiResponse<AuthResponse>>(
      request: () => _apiService.login(
        email: email,
        password: password,
        firebase_uid: firebaseUid,
        fcmToken: fcmToken,
      ),
    );

    if (dataStateAuthResponse is DataStateSuccess) {
      return DataStateSuccess(dataStateAuthResponse.data!);
    } else {
      return DataStateError(dataStateAuthResponse.exception!);
    }
  }

  Future<DataState<ApiResponse<AuthResponse>>> googleLogin({
    required String email,
    required String firebaseUid,
    String? fcmToken,
  }) async {
    DataState<ApiResponse<AuthResponse>> dataStateAuthResponse =
    await getStateOf<ApiResponse<AuthResponse>>(
      request: () => _apiService.loginGoogle(
        email: email,
        firebase_uid: firebaseUid,
        fcmToken: fcmToken,
      ),
    );

    if (dataStateAuthResponse is DataStateSuccess) {
      return DataStateSuccess(dataStateAuthResponse.data!);
    } else {
      return DataStateError(dataStateAuthResponse.exception!);
    }
  }

  Future<DataState<ApiResponse<AuthResponse>>> appleLogin({
    required String appleId,
    String? firebaseUid,
    String? fcmToken,
  }) async {
    DataState<ApiResponse<AuthResponse>> dataStateAuthResponse =
    await getStateOf<ApiResponse<AuthResponse>>(
      request: () => _apiService.loginApple(
        apple_id: appleId,
        firebase_uid: firebaseUid,
        fcmToken: fcmToken,
      ),
    );

    if (dataStateAuthResponse is DataStateSuccess) {
      return DataStateSuccess(dataStateAuthResponse.data!);
    } else {
      return DataStateError(dataStateAuthResponse.exception!);
    }
  }

  Future<DataState<ApiResponse>> logout() async {
    DataState<ApiResponse> dataState = await getStateOf<ApiResponse>(
      request: () => _apiService.logout(),
    );

    if (dataState is DataStateSuccess) {
      return DataStateSuccess(dataState.data!);
    } else {
      return DataStateError(dataState.exception!);
    }
  }

  Future<DataState<ApiResponse>> updateFcmToken({required String fcmToken}) async {
    DataState<ApiResponse> dataState = await getStateOf<ApiResponse>(
      request: () => _apiService.updateFcmToken(fcm_token: fcmToken),
    );

    if (dataState is DataStateSuccess) {
      return DataStateSuccess(dataState.data!);
    } else {
      return DataStateError(dataState.exception!);
    }
  }
}