import '../data/api/api_service.dart';
import '../model/address_model.dart';
import '../model/response/api_response.dart';
import '../utility/resource/data_state.dart';
import 'base/base_repository.dart';

class AddressRepository extends BaseRepository {
  final ApiService _apiService;
  AddressRepository(this._apiService);

  Future<DataState<ApiResponse<List<AddressModel>>>> address() async {
    DataState<ApiResponse<List<AddressModel>>> dataState =
        await getStateOf<ApiResponse<List<AddressModel>>>(request: () {
      return _apiService.address();
    });

    if (dataState is DataStateSuccess) {
      return DataStateSuccess(dataState.data!);
    } else {
      return DataStateError(dataState.exception!);
    }
  }

  Future<DataState<ApiResponse>> createUpdateAddress({
    String? id,
    required String name,
    required String phone,
    required String address,
    required bool isMainAddress,
    required String latitude,
    required String longitude,
    String? note,
  }) async {
    //String? numberWithoutPrefix = phone.replaceFirst(RegExp(r'^\+62'), '');
    DataState<ApiResponse> dataState = await getStateOf<ApiResponse>(request: () {
      return _apiService.createUpdateAddress(
        note: note,
        id: id,
        name: name,
        phone: phone,
        address: address,
        isMainAddress: isMainAddress,
        latitude: latitude,
        longitude: longitude,
      );
    });

    if (dataState is DataStateSuccess) {
      return DataStateSuccess(dataState.data!);
    } else {
      return DataStateError(dataState.exception!);
    }
  }

  Future<DataState<ApiResponse>> deleteAddress({required String id}) async {
    DataState<ApiResponse> dataState = await getStateOf<ApiResponse>(request: () {
      return _apiService.deleteAddress(id: id);
    });

    if (dataState is DataStateSuccess) {
      return DataStateSuccess(dataState.data!);
    } else {
      return DataStateError(dataState.exception!);
    }
  }
}
