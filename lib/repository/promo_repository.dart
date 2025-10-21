import '../data/api/api_service.dart';
import '../model/promo_model.dart';
import '../model/request/transaction_request.dart';
import '../model/response/api_response.dart';
import '../model/response/history_assignment_response.dart';
import '../model/response/promo_response.dart';
import '../utility/resource/data_state.dart';
import 'base/base_repository.dart';

class PromoRepository extends BaseRepository {
  final ApiService _apiService;

  PromoRepository(this._apiService);

  Future<DataState<ApiResponse<PromoResponse>>> promo() async {
    DataState<ApiResponse<PromoResponse>> dataStateAuthResponse = await getStateOf<ApiResponse<PromoResponse>>(
      request: () => _apiService.promo(),
    );

    if (dataStateAuthResponse is DataStateSuccess) {
      return DataStateSuccess(dataStateAuthResponse.data!);
    } else {
      return DataStateError(dataStateAuthResponse.exception!);
    }
  }

  Future<DataState<ApiResponse<PromoModel>>> detailPromo({required String id}) async {
    DataState<ApiResponse<PromoModel>> dataStateAuthResponse = await getStateOf<ApiResponse<PromoModel>>(
      request: () => _apiService.detailPromo(id: id),
    );

    if (dataStateAuthResponse is DataStateSuccess) {
      return DataStateSuccess(dataStateAuthResponse.data!);
    } else {
      return DataStateError(dataStateAuthResponse.exception!);
    }
  }

  Future<DataState<ApiResponse>> claimPromo({required String promoCode}) async {
    DataState<ApiResponse> dataStateAuthResponse = await getStateOf<ApiResponse>(
      request: () => _apiService.claimPromo(code_promo: promoCode),
    );

    if (dataStateAuthResponse is DataStateSuccess) {
      return DataStateSuccess(dataStateAuthResponse.data!);
    } else {
      return DataStateError(dataStateAuthResponse.exception!);
    }
  }

  Future<DataState<ApiResponse>> checkPromo({
    required TransactionRequest request,
  }) async {
    DataState<ApiResponse> dataStateAuthResponse = await getStateOf<ApiResponse>(
      request: () => _apiService.checkPromo(request: request),
    );

    if (dataStateAuthResponse is DataStateSuccess) {
      return DataStateSuccess(dataStateAuthResponse.data!);
    } else {
      return DataStateError(dataStateAuthResponse.exception!);
    }
  }
}
