import '../data/api/api_service.dart';
import '../model/response/api_response.dart';
import '../utility/resource/data_state.dart';
import 'base/base_repository.dart';

class ResetPasswordRepository extends BaseRepository {
  final ApiService _apiService;

  ResetPasswordRepository(this._apiService);

  Future<DataState<ApiResponse>> sendResetTokenEmail({
    required String email,
  }) async {
    DataState<ApiResponse> dataStateAuthResponse = await getStateOf<ApiResponse>(
      request: () => _apiService.sendResetTokenEmail(email: email),
    );

    if (dataStateAuthResponse is DataStateSuccess) {
      return DataStateSuccess(dataStateAuthResponse.data!);
    } else {
      return DataStateError(dataStateAuthResponse.exception!);
    }
  }

  Future<DataState<ApiResponse>> validateResetToken({
    required String email,
    required String token,
  }) async {
    DataState<ApiResponse> dataStateAuthResponse = await getStateOf<ApiResponse>(
      request: () => _apiService.validateResetToken(email: email, token: token),
    );

    if (dataStateAuthResponse is DataStateSuccess) {
      return DataStateSuccess(dataStateAuthResponse.data!);
    } else {
      return DataStateError(dataStateAuthResponse.exception!);
    }
  }

  Future<DataState<ApiResponse>> changePassword({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    DataState<ApiResponse> dataStateAuthResponse = await getStateOf<ApiResponse>(
      request: () => _apiService.changePassword(
        email: email,
        password: password,
        confirm_password: confirmPassword,
      ),
    );

    if (dataStateAuthResponse is DataStateSuccess) {
      return DataStateSuccess(dataStateAuthResponse.data!);
    } else {
      return DataStateError(dataStateAuthResponse.exception!);
    }
  }
}
