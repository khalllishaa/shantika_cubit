import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shantika_cubit/utility/extensions/dio_exception_extensions.dart';

import '../../../config/service_locator.dart';
import '../../../model/response/api_response.dart';
import '../../../model/user_model.dart';
import '../../../repository/profile_repository.dart';
import '../../../utility/resource/data_state.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  late ProfileRepository _repository;
  UserModel? _user;

  init() {
    _repository = ProfileRepository(serviceLocator.get());
    _user = null;
  }

  profile() async {
    emit(ProfileStateLoading());

    DataState<ApiResponse<UserModel>> dataState = await _repository.profile();

    switch (dataState) {
      case DataStateSuccess<ApiResponse<UserModel>>():
        {
          _user = dataState.data?.data;
          emit(ProfileStateSuccess(user: _user ?? UserModel()));
        }
      case DataStateError<ApiResponse<UserModel>>():
        {
          emit(ProfileStateError(message: dataState.exception?.parseMessage() ?? ""));
        }
    }
  }
}
