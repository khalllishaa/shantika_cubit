import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:shantika_cubit/utility/extensions/dio_exception_extensions.dart';

import '../../../config/service_locator.dart';
import '../../../config/user_preference.dart';
import '../../../model/response/api_response.dart';
import '../../../model/user_model.dart';
import '../../../repository/profile_repository.dart';
import '../../../utility/resource/data_state.dart';

part 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  UpdateProfileCubit() : super(UpdateProfileInitial());

  late ProfileRepository _repository;

  late UserPreference _preference;

  init() {
    _preference = serviceLocator.get();
    _repository = ProfileRepository(serviceLocator.get());
  }

  // updateProfile({
  //   required String firstName,
  //   String? lastName,
  //   required String gender,
  //   required String email,
  //   File? avatar,
  //   DateTime? birthDate,
  //   String? phone,
  // }) async {
  //   emit(UpdateProfileStateLoading());
  //
  //   MultipartFile? multipart;
  //
  //   if (avatar != null) {
  //     multipart = await MultipartFile.fromFile(
  //       avatar.path,
  //       filename: avatar.path.split('/').last,
  //     );
  //   }
  //
  //   DataState<ApiResponse<UserModel>> dataState = await _repository.updateProfile(
  //     firstName: firstName,
  //     gender: gender,
  //     email: email,
  //     avatar: multipart != null ? [multipart] : null,
  //     birthDate: birthDate,
  //     lastName: lastName,
  //     phone: phone,
  //   );
  //
  //   switch (dataState) {
  //     case DataStateSuccess<ApiResponse<UserModel>>():
  //       {
  //         _preference.setUser(dataState.data?.data ?? UserModel());
  //         emit(UpdateProfileStateSuccess(user: dataState.data?.data ?? UserModel()));
  //       }
  //     case DataStateError<ApiResponse<UserModel>>():
  //       {
  //         emit(UpdateProfileStateError(message: dataState.exception?.parseMessage() ?? ""));
  //       }
  //   }
  // }
}
