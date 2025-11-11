import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shantika_cubit/utility/extensions/dio_exception_extensions.dart';

import '../../../config/service_locator.dart';
import '../../../model/response/api_response.dart';
import '../../../model/slider_model.dart';
import '../../../repository/home_repository.dart';
import '../../../utility/resource/data_state.dart';

part 'detail_slider_state.dart';

class DetailSliderCubit extends Cubit<DetailSliderState> {
  DetailSliderCubit() : super(DetailSliderInitial());

  late HomeRepository _repository;

  init() {
    _repository = HomeRepository(serviceLocator.get());
  }

  detailSlider({required String slug}) async {
    emit(DetailSliderStateLoading());

    DataState<ApiResponse<SliderModel>> dataState = await _repository.detailSlider(slug: slug);

    switch (dataState) {
      case DataStateSuccess<ApiResponse<SliderModel>>():
        {
          emit(DetailSliderStateSuccess(data: dataState.data?.data ?? SliderModel()));
        }
      case DataStateError<ApiResponse<SliderModel>>():
        {
          emit(DetailSliderStateError(message: dataState.exception?.parseMessage() ?? ""));
        }
      case DataStateLoading<ApiResponse<SliderModel>>():
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }
}
