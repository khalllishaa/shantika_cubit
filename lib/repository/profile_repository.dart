import 'package:dio/dio.dart';
import 'package:shantika_cubit/utility/extensions/date_time_extensions.dart';
import '../data/api/api_service.dart';
import '../model/response/api_response.dart';
import '../model/user_model.dart';
import '../utility/resource/data_state.dart';
import 'base/base_repository.dart';

class ProfileRepository extends BaseRepository {
  final ApiService _apiService;

  ProfileRepository(this._apiService);

  Future<DataState<ApiResponse<UserModel>>> profile() async {
    DataState<ApiResponse<UserModel>> dataStateAuthResponse = await getStateOf<ApiResponse<UserModel>>(
      request: () => _apiService.profile(),
    );

    if (dataStateAuthResponse is DataStateSuccess) {
      return DataStateSuccess(dataStateAuthResponse.data!);
    } else {
      return DataStateError(dataStateAuthResponse.exception!);
    }
  }

  Future<DataState<ApiResponse<UserModel>>> updateProfile({
    required String firstName,
    String? lastName,
    required String gender,
    required String email,
    List<MultipartFile>? avatar,
    DateTime? birthDate,
    String? phone,
  }) async {
    String? numberWithoutPrefix = phone?.replaceFirst(RegExp(r'^\+62'), '');
    DataState<ApiResponse<UserModel>> dataStateAuthResponse = await getStateOf<ApiResponse<UserModel>>(
      request: () => _apiService.updateProfile(
        first_name: firstName,
        gender: gender,
        email: email,
        last_name: lastName,
        avatar: avatar,
        birth_date: birthDate?.convert(format: "yyyy-MM-dd"),
        phone: '+62${numberWithoutPrefix}',
      ),
    );

    if (dataStateAuthResponse is DataStateSuccess) {
      return DataStateSuccess(dataStateAuthResponse.data!);
    } else {
      return DataStateError(dataStateAuthResponse.exception!);
    }
  }
}
