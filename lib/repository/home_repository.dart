import 'package:dio/dio.dart';
import 'package:shantika_cubit/model/detail_artikel_model.dart';
import 'package:shantika_cubit/model/home_model.dart';

import '../data/api/api_service.dart';
import '../model/response/api_response.dart';
import '../model/response/history_assignment_response.dart';
import '../model/response/home_response.dart';
import '../model/slider_model.dart';
import '../utility/resource/data_state.dart';
import 'base/base_repository.dart';

class HomeRepository extends BaseRepository {
  final ApiService _apiService;

  HomeRepository(this._apiService);

  Future<HomeModel> getHome() async {
    try {
      final response = await _apiService.home();

      if (response.response.statusCode == 200) {
        if (response.data != null) {
          return response.data!;
        } else {
          throw Exception('Data home kosong');
        }
      } else {
        throw Exception(
            'Server error: ${response.response.statusCode} - ${response.response.statusMessage}'
        );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        throw Exception('Endpoint tidak ditemukan (${e.response?.statusCode})');
      } else if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Koneksi timeout');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Server tidak merespons');
      } else {
        throw Exception('Koneksi gagal: ${e.message}');
      }
    } catch (e) {
      throw Exception('Error fetching home: $e');
    }
  }

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

  Future<Article> getArticleDetail(int articleId) async {
    try {
      final response = await _apiService.getArticleDetail(articleId);

      if (response.response.statusCode == 200) {
        if (response.data != null && response.data!.success) {
          return response.data!.article;
        } else {
          throw Exception(response.data?.message ?? 'Data artikel tidak ditemukan');
        }
      } else {
        throw Exception(
            'Server error: ${response.response.statusCode} - ${response.response.statusMessage}'
        );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        throw Exception('Artikel tidak ditemukan (${e.response?.statusCode})');
      } else if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Koneksi timeout');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Server tidak merespons');
      } else {
        throw Exception('Koneksi gagal: ${e.message}');
      }
    } catch (e) {
      throw Exception('Error fetching article detail: $e');
    }
  }
}
