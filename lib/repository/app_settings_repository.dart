  import 'package:dio/dio.dart';
  import 'package:shantika_cubit/model/about_us_model.dart';

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
      try {
        final response = await _apiService.faq();

        // Cek apakah response success
        if (response.response.statusCode == 200) {
          // Akses data dari HttpResponse
          final faqList = response.data.faqs;
          return DataStateSuccess(faqList);
        } else {
          return DataStateError(
            DioException(
              requestOptions: response.response.requestOptions,
              response: response.response,
              type: DioExceptionType.badResponse,
            ),
          );
        }
      } on DioException catch (e) {
        return DataStateError(e);
      } catch (e) {
        // Jika bukan DioException, wrap dalam DioException
        return DataStateError(
          DioException(
            requestOptions: RequestOptions(path: '/faq'),
            error: e,
            type: DioExceptionType.unknown,
          ),
        );
      }
    }

    Future<DataState<TermsConditionsModel>> termsConditions() async {
      try {
        final response = await _apiService.termConditions();

        if (response.response.statusCode == 200) {
          return DataStateSuccess(response.data.termAndCondition);
        } else {
          return DataStateError(
            DioException(
              requestOptions: response.response.requestOptions,
              response: response.response,
              type: DioExceptionType.badResponse,
            ),
          );
        }
      } on DioException catch (e) {
        return DataStateError(e);
      } catch (e) {
        return DataStateError(
          DioException(
            requestOptions: RequestOptions(path: '/term_and_condition'),
            error: e,
            type: DioExceptionType.unknown,
          ),
        );
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

    Future<DataState<About>> about() async {
      try {
        final response = await _apiService.about();

        // response.data adalah AboutUsModel
        return DataStateSuccess(response.data.about);

      } catch (e) {
        return DataStateError(e as DioException);
      }
    }

  }
