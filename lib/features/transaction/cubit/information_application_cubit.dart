import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shantika_cubit/utility/extensions/dio_exception_extensions.dart';

import '../../../config/service_locator.dart';
import '../../../model/application_model.dart';
import '../../../model/response/api_response.dart';
import '../../../repository/app_settings_repository.dart';
import '../../../utility/resource/data_state.dart';

part 'information_application_state.dart';

class InformationApplicationCubit extends Cubit<InformationApplicationState> {
  InformationApplicationCubit() : super(InformationApplicationInitial());

  late AppSettingsRepository _repository;

  init() {
    _repository = AppSettingsRepository(serviceLocator.get());
  }

  informationApp() async {
    emit(InformationApplicationStateLoading());

    DataState<ApiResponse<ApplicationModel>> dataState = await _repository.informationApplication();

    switch (dataState) {
      case DataStateSuccess<ApiResponse<ApplicationModel>>():
        {
          emit(InformationApplicationStateSuccess(data: dataState.data?.data ?? ApplicationModel()));
        }
      case DataStateError<ApiResponse<ApplicationModel>>():
        {
          emit(InformationApplicationStateError(message: dataState.exception?.parseMessage() ?? ""));
        }
    }
  }
}
