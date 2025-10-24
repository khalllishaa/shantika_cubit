import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shantika_cubit/model/users_model.dart';
import 'package:shantika_cubit/utility/extensions/dio_exception_extensions.dart';

import '../../../config/service_locator.dart';
import '../../../model/response/api_response.dart';
import '../../../repository/profile_repository.dart';
import '../../../utility/resource/data_state.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  late ProfileRepository _repository;
  UsersModel? _user;

  init() {
    _repository = ProfileRepository(serviceLocator.get());
    _user = null;
  }

  profile() async {
    emit(ProfileStateLoading());

    DataState<UsersModel> dataState = await _repository.profile();

    switch (dataState) {
      case DataStateSuccess<UsersModel>():
        {
          _user = dataState.data;
          emit(ProfileStateSuccess(user: _user ?? UsersModel()));
        }
      case DataStateError<UsersModel>():
        {
          emit(ProfileStateError(message: dataState.exception?.parseMessage() ?? ""));
        }
    }
  }
}