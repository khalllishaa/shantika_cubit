import 'package:shantika_cubit/data/api/api_service.dart';
import 'package:shantika_cubit/model/all_cities_model.dart';
import 'package:shantika_cubit/model/info_agency_model.dart';
import 'package:shantika_cubit/repository/base/base_repository.dart';

class InfoAgencyRepository extends BaseRepository {
  final ApiService _apiService;

  InfoAgencyRepository(this._apiService);

  Future<List<Agency>> getInfoAgency(int cityId) async {
    try {
      print('Repository: Calling API getInfoAgency($cityId)');
      final response = await _apiService.getInfoAgency(cityId);

      print('Repository: Status Code = ${response.response.statusCode}');
      print('Repository: Success = ${response.data?.success}');
      print('Repository: Raw data = ${response.data}');

      if (response.response.statusCode == 200 && response.data?.success == true) {
        print('Repository: Agencies count = ${response.data!.agencies.length}');

        for (var agency in response.data!.agencies) {
          print('Agency: ${agency.agencyName}');
          print('morningTime: ${agency.morningTime}');
          print('nightTime: ${agency.nightTime}');
          print('lat: ${agency.agencyLat}');
          print('lng: ${agency.agencyLng}');
        }

        return response.data!.agencies;
      } else {
        final errorMsg = response.data?.message ?? 'Gagal memuat data agencies';
        print('Repository: Error - $errorMsg');
        throw Exception(errorMsg);
      }
    } catch (e, stackTrace) {
      print('Repository: Exception - $e');
      print('StackTrace: $stackTrace');
      throw Exception('Error fetching agencies: $e');
    }
  }

  Future<List<City>> getAllCities() async {
    try {
      print('Repository: Calling API getAllCities()');
      final response = await _apiService.getAllCities();

      print('Repository: Status Code = ${response.response.statusCode}');
      print('Repository: Success = ${response.data?.success}');
      print('Repository: Cities count = ${response.data?.cities.length}');

      if (response.response.statusCode == 200 && response.data?.success == true) {
        print('Repository: Returning ${response.data!.cities.length} cities');
        return response.data!.cities;
      } else {
        final errorMsg = response.data?.message ?? 'Gagal memuat data kota';
        print('Repository: Error - $errorMsg');
        throw Exception(errorMsg);
      }
    } catch (e) {
      print('Repository: Exception - $e');
      throw Exception('Error fetching cities: $e');
    }
  }
}
