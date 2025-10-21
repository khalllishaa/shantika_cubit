import '../data/api/api_service.dart';
import '../model/application_model.dart';
import '../model/faq_model.dart';
import '../model/privacy_policy_model.dart';
import '../model/response/api_response.dart';
import '../model/terms_conditions_model.dart';
import '../utility/resource/data_state.dart';
import 'base/base_repository.dart';

class AppSettingsRepository extends BaseRepository {
  final ApiService _apiService;

  AppSettingsRepository(this._apiService);

  Future<DataState<List<FaqModel>>> faq() async {
    DataState<ApiResponse<List<FaqModel>>> dataState = await getStateOf<ApiResponse<List<FaqModel>>>(request: () {
      return _apiService.faq();
    });

    if (dataState is DataStateSuccess) {
      return DataStateSuccess(dataState.data!.data!);
    } else {
      return DataStateError(dataState.exception!);
    }
  }

  Future<DataState<TermsConditionsModel>> termsConditions() async {
    DataState<ApiResponse<TermsConditionsModel>> dataState =
        await getStateOf<ApiResponse<TermsConditionsModel>>(request: () {
      return _apiService.termConditions();
    });

    if (dataState is DataStateSuccess) {
      return DataStateSuccess(dataState.data!.data!);
    } else {
      return DataStateError(dataState.exception!);
    }
  }

  Future<DataState<PrivacyPolicyModel>> privacyPolicy() async {
    DataState<ApiResponse<PrivacyPolicyModel>> dataState = await getStateOf(request: () {
      return _apiService.privacyPolicy();
    });

    if (dataState is DataStateSuccess) {
      return DataStateSuccess(dataState.data!.data!);
    } else {
      return DataStateError(dataState.exception!);
    }
  }

  Future<DataState<ApiResponse>> contactUs({
    required String name,
    required String email,
    required String company,
    required String message,
  }) async {
    DataState<ApiResponse> dataState = await getStateOf<ApiResponse>(
        request: () => _apiService.contactUs(name: name, email: email, company: company, message: message));

    if (dataState is DataStateSuccess) {
      return DataStateSuccess(dataState.data!);
    } else {
      return DataStateError(dataState.exception!);
    }
  }

  Future<DataState<ApiResponse<ApplicationModel>>> informationApplication() async {
    DataState<ApiResponse<ApplicationModel>> dataState = await getStateOf<ApiResponse<ApplicationModel>>(
      request: () => _apiService.informationApplication(),
    );

    if (dataState is DataStateSuccess) {
      return DataStateSuccess(dataState.data!);
    } else {
      return DataStateError(dataState.exception!);
    }
  }
}
