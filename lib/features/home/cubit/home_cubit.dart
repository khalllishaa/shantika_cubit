import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shantika_cubit/utility/extensions/dio_exception_extensions.dart';

import '../../../config/service_locator.dart';
import '../../../model/response/api_response.dart';
import '../../../model/response/home_response.dart';
import '../../../repository/home_repository.dart';
import '../../../utility/resource/data_state.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  late HomeRepository _repository;

  init() {
    _repository = HomeRepository(serviceLocator.get());
  }

  home() async {
    emit(HomeStateLoading());

    DataState<ApiResponse<HomeResponse>> dataState = await _repository.home();

    switch (dataState) {
      case DataStateSuccess<ApiResponse<HomeResponse>>():
        {
          emit(HomeStateSuccess(data: dataState.data?.data ?? HomeResponse()));
        }
      case DataStateError<ApiResponse<HomeResponse>>():
        {
          emit(HomeStateError(message: dataState.exception?.parseMessage() ?? ""));
        }
      case DataStateLoading<ApiResponse<HomeResponse>>():
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }
}
