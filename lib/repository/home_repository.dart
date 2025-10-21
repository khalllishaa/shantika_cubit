import '../data/api/api_service.dart';
import '../model/response/api_response.dart';
import '../model/response/history_assignment_response.dart';
import '../model/response/home_response.dart';
import '../model/slider_model.dart';
import '../utility/resource/data_state.dart';
import 'base/base_repository.dart';

class HomeRepository extends BaseRepository {
  final ApiService _apiService;

  HomeRepository(this._apiService);

  Future<DataState<ApiResponse<HomeResponse>>> home() async {
    DataState<ApiResponse<HomeResponse>> dataStateAuthResponse = await getStateOf<ApiResponse<HomeResponse>>(
      request: () => _apiService.home(),
    );

    if (dataStateAuthResponse is DataStateSuccess) {
      return DataStateSuccess(dataStateAuthResponse.data!);
    } else {
      return DataStateError(dataStateAuthResponse.exception!);
    }
  }

  Future<DataState<ApiResponse<SliderModel>>> detailSlider({required String slug}) async {
    DataState<ApiResponse<SliderModel>> dataStateAuthResponse = await getStateOf<ApiResponse<SliderModel>>(
      request: () => _apiService.detailSlider(slug: slug),
    );

    if (dataStateAuthResponse is DataStateSuccess) {
      return DataStateSuccess(dataStateAuthResponse.data!);
    } else {
      return DataStateError(dataStateAuthResponse.exception!);
    }
  }
}
