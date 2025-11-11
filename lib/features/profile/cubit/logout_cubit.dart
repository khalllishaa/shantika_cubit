import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shantika_cubit/utility/extensions/dio_exception_extensions.dart';

import '../../../config/service_locator.dart';
import '../../../config/user_preference.dart';
import '../../../model/response/api_response.dart';
import '../../../repository/auth_repository.dart';
import '../../../utility/resource/data_state.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit() : super(LogoutInitial());

  late AuthRepository _repository;

  late UserPreference _preference;

  init() {
    _repository = AuthRepository(serviceLocator.get());
    _preference = serviceLocator.get();
  }

  logout() async {
    emit(LogoutStateLoading());

    DataState<ApiResponse> dataState = await _repository.logout();

    switch (dataState) {
      case DataStateSuccess<ApiResponse>():
        {
          _preference.clearData();

          emit(LogoutStateSuccess());
        }
      case DataStateError<ApiResponse>():
        {
          emit(LogoutStateError(message: dataState.exception?.parseMessage() ?? ""));
        }
      case DataStateLoading<ApiResponse>():
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }
}
