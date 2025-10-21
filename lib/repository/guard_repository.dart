import '../data/api/api_service.dart';
import '../model/equipment_support_model.dart';
import '../model/guard_model.dart';
import '../model/request/transaction_request.dart';
import '../model/response/api_response.dart';
import '../model/response/guard_response.dart';
import '../model/response/guard_type_response.dart';
import '../model/response/history_assignment_response.dart';
import '../utility/resource/data_state.dart';
import 'base/base_repository.dart';

class GuardRepository extends BaseRepository {
  final ApiService _apiService;

  GuardRepository(this._apiService);

  Future<DataState<ApiResponse<GuardResponse>>> guards({
    String? guardClassId,
    List<String>? sortBy,
  }) async {
    DataState<ApiResponse<GuardResponse>> dataStateAuthResponse = await getStateOf<ApiResponse<GuardResponse>>(
      request: () => _apiService.guards(
        guardClassId: guardClassId,
        sortBy: sortBy,
      ),
    );

    if (dataStateAuthResponse is DataStateSuccess) {
      return DataStateSuccess(dataStateAuthResponse.data!);
    } else {
      return DataStateError(dataStateAuthResponse.exception!);
    }
  }

  Future<DataState<ApiResponse<GuardResponse>>> detailGuard({
    String? guardId,
  }) async {
    DataState<ApiResponse<GuardResponse>> dataStateAuthResponse = await getStateOf<ApiResponse<GuardResponse>>(
      request: () => _apiService.detailGuard(guardId: guardId ?? ""),
    );

    if (dataStateAuthResponse is DataStateSuccess) {
      return DataStateSuccess(dataStateAuthResponse.data!);
    } else {
      return DataStateError(dataStateAuthResponse.exception!);
    }
  }

  Future<DataState<ApiResponse>> favoriteGuard({
    String? guardId,
    required String isFavorite,
  }) async {
    DataState<ApiResponse> dataStateAuthResponse = await getStateOf<ApiResponse>(
      request: () => _apiService.favorite(guardId: guardId ?? "", isFavorite: isFavorite),
    );

    if (dataStateAuthResponse is DataStateSuccess) {
      return DataStateSuccess(dataStateAuthResponse.data!);
    } else {
      return DataStateError(dataStateAuthResponse.exception!);
    }
  }

  Future<DataState<ApiResponse<GuardTypeResponse>>> guardType({
    required String guardTypeId,
  }) async {
    DataState<ApiResponse<GuardTypeResponse>> dataStateAuthResponse = await getStateOf<ApiResponse<GuardTypeResponse>>(
      request: () => _apiService.guardTypeById(guardTypeId: guardTypeId),
    );

    if (dataStateAuthResponse is DataStateSuccess) {
      return DataStateSuccess(dataStateAuthResponse.data!);
    } else {
      return DataStateError(dataStateAuthResponse.exception!);
    }
  }

  Future<DataState<ApiResponse<GuardModel>>> guardRecomendation({
    required String guardClassId,
    required String startTime,
    required String endTime,
  }) async {
    DataState<ApiResponse<GuardModel>> dataStateAuthResponse = await getStateOf<ApiResponse<GuardModel>>(
      request: () => _apiService.guardRecomendation(
        guardClassId: guardClassId,
        startTime: startTime,
        endTime: endTime,
      ),
    );

    if (dataStateAuthResponse is DataStateSuccess) {
      return DataStateSuccess(dataStateAuthResponse.data!);
    } else {
      return DataStateError(dataStateAuthResponse.exception!);
    }
  }

  Future<DataState<ApiResponse>> checkGuardAvailability({
    required TransactionRequest request,
  }) async {
    DataState<ApiResponse> dataStateAuthResponse =
        await getStateOf<ApiResponse>(request: () => _apiService.checkGuardAvailability(request: request));

    if (dataStateAuthResponse is DataStateSuccess) {
      return DataStateSuccess(dataStateAuthResponse.data!);
    } else {
      return DataStateError(dataStateAuthResponse.exception!);
    }
  }

  Future<DataState<ApiResponse<List<EquipmentSupportModel>>>> equipmentSupports() async {
    DataState<ApiResponse<List<EquipmentSupportModel>>> dataStateAuthResponse =
        await getStateOf<ApiResponse<List<EquipmentSupportModel>>>(
      request: () => _apiService.equipmentSupports(),
    );

    if (dataStateAuthResponse is DataStateSuccess) {
      return DataStateSuccess(dataStateAuthResponse.data!);
    } else {
      return DataStateError(dataStateAuthResponse.exception!);
    }
  }
}
