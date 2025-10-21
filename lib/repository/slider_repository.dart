import '../data/api/api_service.dart';
import '../model/response/api_response.dart';
import '../model/slider_model.dart';
import '../utility/resource/data_state.dart';
import 'base/base_repository.dart';

class SliderRepository extends BaseRepository {
  final ApiService _apiService;

  SliderRepository(this._apiService);

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
