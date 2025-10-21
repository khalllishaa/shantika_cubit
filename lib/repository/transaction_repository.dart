import '../data/api/api_service.dart';
import '../model/request/transaction_request.dart';
import '../model/response/api_response.dart';
import '../model/response/history_assignment_response.dart';
import '../model/response/payment_method_response.dart';
import '../model/response/transaction_detail_response.dart';
import '../model/response/transaction_response.dart';
import '../utility/resource/data_state.dart';
import 'base/base_repository.dart';

class TransactionRepository extends BaseRepository {
  final ApiService _apiService;

  TransactionRepository(this._apiService);

  Future<DataState<ApiResponse<PaymentMethodResponse>>> paymentMethods() async {
    DataState<ApiResponse<PaymentMethodResponse>> dataStateAuthResponse =
        await getStateOf<ApiResponse<PaymentMethodResponse>>(
      request: () => _apiService.paymentMethods(),
    );

    if (dataStateAuthResponse is DataStateSuccess) {
      return DataStateSuccess(dataStateAuthResponse.data!);
    } else {
      return DataStateError(dataStateAuthResponse.exception!);
    }
  }

  Future<DataState<ApiResponse>> createTransaction({
    required TransactionRequest request,
  }) async {
    DataState<ApiResponse> dataStateAuthResponse = await getStateOf<ApiResponse>(
      request: () => _apiService.createTransaction(request: request),
    );

    if (dataStateAuthResponse is DataStateSuccess) {
      return DataStateSuccess(dataStateAuthResponse.data!);
    } else {
      return DataStateError(dataStateAuthResponse.exception!);
    }
  }

  Future<DataState<ApiResponse<TransactionResponse>>> transaction({
    String? status,
  }) async {
    DataState<ApiResponse<TransactionResponse>> dataStateAuthResponse =
        await getStateOf<ApiResponse<TransactionResponse>>(
      request: () => _apiService.transaction(status: status),
    );

    if (dataStateAuthResponse is DataStateSuccess) {
      return DataStateSuccess(dataStateAuthResponse.data!);
    } else {
      return DataStateError(dataStateAuthResponse.exception!);
    }
  }

  Future<DataState<ApiResponse<TransactionDetailResponse>>> detailTransaction({
    required String id,
  }) async {
    DataState<ApiResponse<TransactionDetailResponse>> dataStateAuthResponse =
        await getStateOf<ApiResponse<TransactionDetailResponse>>(
      request: () => _apiService.detailTransaction(id: id),
    );

    if (dataStateAuthResponse is DataStateSuccess) {
      return DataStateSuccess(dataStateAuthResponse.data!);
    } else {
      return DataStateError(dataStateAuthResponse.exception!);
    }
  }

  Future<DataState<ApiResponse>> updateTransaction({
    required String id,
    required TransactionRequest request,
  }) async {
    DataState<ApiResponse> dataStateAuthResponse = await getStateOf<ApiResponse>(
      request: () => _apiService.updateTransaction(request: request, id: id),
    );

    if (dataStateAuthResponse is DataStateSuccess) {
      return DataStateSuccess(dataStateAuthResponse.data!);
    } else {
      return DataStateError(dataStateAuthResponse.exception!);
    }
  }

  Future<DataState<ApiResponse>> cancelTransaction({
    required String id,
  }) async {
    DataState<ApiResponse> dataStateAuthResponse = await getStateOf<ApiResponse>(
      request: () => _apiService.cancelTransaction(id: id),
    );

    if (dataStateAuthResponse is DataStateSuccess) {
      return DataStateSuccess(dataStateAuthResponse.data!);
    } else {
      return DataStateError(dataStateAuthResponse.exception!);
    }
  }

  Future<DataState<ApiResponse>> socketTransaction({
    required String id,
    required String paymentCode,
  }) async {
    DataState<ApiResponse> dataStateAuthResponse = await getStateOf<ApiResponse>(
      request: () => _apiService.socketTransaction(id: id, paymentCode: paymentCode),
    );

    if (dataStateAuthResponse is DataStateSuccess) {
      return DataStateSuccess(dataStateAuthResponse.data!);
    } else {
      return DataStateError(dataStateAuthResponse.exception!);
    }
  }
}
