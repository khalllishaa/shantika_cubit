import '../data/api/api_service.dart';
import '../model/response/api_response.dart';
import '../model/response/article_detail_response.dart';
import '../model/response/article_response.dart';
import '../utility/resource/data_state.dart';
import 'base/base_repository.dart';

class ArticleRepository extends BaseRepository {
  final ApiService _apiService;

  ArticleRepository(this._apiService);

  Future<DataState<ApiResponse<ArticleResponse>>> articles({
    String? sort_by,
    String? categoryId,
  }) async {
    DataState<ApiResponse<ArticleResponse>> dataStateAuthResponse = await getStateOf<ApiResponse<ArticleResponse>>(
      request: () => _apiService.article(categoryId: categoryId, sortBy: sort_by),
    );

    if (dataStateAuthResponse is DataStateSuccess) {
      return DataStateSuccess(dataStateAuthResponse.data!);
    } else {
      return DataStateError(dataStateAuthResponse.exception!);
    }
  }

  Future<DataState<ApiResponse<ArticleDetailResponse>>> detailArticle({required String slug}) async {
    DataState<ApiResponse<ArticleDetailResponse>> dataStateAuthResponse =
        await getStateOf<ApiResponse<ArticleDetailResponse>>(request: () => _apiService.detailArticle(slug: slug));

    if (dataStateAuthResponse is DataStateSuccess) {
      return DataStateSuccess(dataStateAuthResponse.data!);
    } else {
      return DataStateError(dataStateAuthResponse.exception!);
    }
  }

  Future<DataState<ApiResponse>> giveLike({
    required String slug,
    required bool isLike,
  }) async {
    DataState<ApiResponse> dataStateAuthResponse = await getStateOf<ApiResponse>(
      request: () => _apiService.giveLike(slug: slug, isLike: isLike),
    );

    if (dataStateAuthResponse is DataStateSuccess) {
      return DataStateSuccess(dataStateAuthResponse.data!);
    } else {
      return DataStateError(dataStateAuthResponse.exception!);
    }
  }
}
