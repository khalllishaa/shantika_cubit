import 'package:shantika_cubit/data/api/api_service.dart';
import 'package:shantika_cubit/model/social_media_model.dart';
import 'package:shantika_cubit/repository/base/base_repository.dart';

class SocialMediaRepository extends BaseRepository {
  final ApiService _apiService;

  SocialMediaRepository(this._apiService);

  Future<List<SocialMedia>> getSocialMedia() async {
    try {
      final response = await _apiService.getSocialMedia();

      print('Repository: Status Code = ${response.response.statusCode}');
      print('Repository: Success = ${response.data?.success}');
      print('Repository: social media count = ${response.data?.socialMedias.length}');

      if (response.response.statusCode == 200 && response.data?.success == true) {
        print('Repository: Returning ${response.data!.socialMedias.length} social media');
        return response.data!.socialMedias;
      } else {
        final errorMsg = response.data?.message ?? 'Gagal memuat data sosial media';
        print('Repository: Error - $errorMsg');
        throw Exception(errorMsg);
      }
    } catch (e) {
      print('Repository: Exception - $e');
      throw Exception('Error fetching social media: $e');
    }
  }
}