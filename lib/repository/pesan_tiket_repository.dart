import 'package:dio/dio.dart';
import 'package:shantika_cubit/data/api/api_service.dart';
import 'package:shantika_cubit/model/pesan_tiket_model.dart' as destination;
import 'package:shantika_cubit/model/city_depature_model.dart' as departure;
import 'package:shantika_cubit/model/agency_model.dart';
import 'package:shantika_cubit/repository/base/base_repository.dart';

class TicketRepository extends BaseRepository {
  final ApiService _apiService;

  TicketRepository(this._apiService);

  // ✅ GET Kota Tujuan
  Future<List<destination.City>> getCities() async {
    try {
      final response = await _apiService.getCityDestinations();
      if (response.response.statusCode == 200 &&
          response.data?.success == true) {
        return response.data!.cities;
      } else {
        throw Exception(response.data?.message ?? 'Gagal memuat data kota');
      }
    } catch (e) {
      throw Exception('Error fetching cities: $e');
    }
  }

  // ✅ GET Kota Keberangkatan
  Future<List<departure.City>> getDepartureCities() async {
    try {
      final response = await _apiService.getCityDepartures();
      if (response.response.statusCode == 200 &&
          response.data?.success == true) {
        return response.data!.cities;
      } else {
        throw Exception(response.data?.message ?? 'Gagal memuat data kota keberangkatan');
      }
    } catch (e) {
      throw Exception('Error fetching departure cities: $e');
    }
  }

  // ✅ GET AGEN CITY berdasarkan City ID
  Future<List<AgencyCity>> getAgencyCities(String cityId) async {
    final response = await _apiService.getAgencyCities(cityId);
    if (response.response.statusCode == 200 &&
        response.data?.success == true) {
      return response.data!.agenciesCity;
    } else {
      throw Exception(response.data?.message ?? 'Gagal memuat data agen');
    }
  }
}
