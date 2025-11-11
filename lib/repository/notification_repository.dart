// lib/repository/notification_repository.dart
import 'package:shantika_cubit/model/notification_model.dart';
import '../data/api/api_service.dart';
import '../model/response/api_response.dart';
import '../utility/resource/data_state.dart';
import 'base/base_repository.dart';

class NotificationRepository extends BaseRepository {
  final ApiService _apiService;

  NotificationRepository(this._apiService);

  Future<DataState<NotificationModel>> notifications({required int page}) async {
    DataState<NotificationModel> dataStateAuthResponse =
    await getStateOf<NotificationModel>(
      request: () => _apiService.notifications(page: page),
    );

    if (dataStateAuthResponse is DataStateSuccess) {
      return DataStateSuccess(dataStateAuthResponse.data!);
    } else if (dataStateAuthResponse is DataStateError) {
      return DataStateError(dataStateAuthResponse.exception!);
    } else {
      return const DataStateLoading();
    }
  }

  Future<DataState<ApiResponse>> readNotification({required String id}) async {
    DataState<ApiResponse> dataStateAuthResponse =
    await getStateOf<ApiResponse>(
      request: () => _apiService.readNotification(id: id),
    );

    if (dataStateAuthResponse is DataStateSuccess) {
      return DataStateSuccess(dataStateAuthResponse.data!);
    } else if (dataStateAuthResponse is DataStateError) {
      return DataStateError(dataStateAuthResponse.exception!);
    } else {
      return const DataStateLoading();
    }
  }

  Future<DataState<ApiResponse>> readAllNotification() async {
    DataState<ApiResponse> dataStateAuthResponse = await getStateOf<ApiResponse>(
      request: () => _apiService.readAllNotification(),
    );

    if (dataStateAuthResponse is DataStateSuccess) {
      return DataStateSuccess(dataStateAuthResponse.data!);
    } else if (dataStateAuthResponse is DataStateError) {
      return DataStateError(dataStateAuthResponse.exception!);
    } else {
      return const DataStateLoading();
    }
  }
}