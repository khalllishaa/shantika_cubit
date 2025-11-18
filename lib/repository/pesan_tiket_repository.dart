import 'package:dio/dio.dart';
import 'package:shantika_cubit/data/api/api_service.dart';
import 'package:shantika_cubit/model/fleet_classes_model.dart';
import 'package:shantika_cubit/model/fleet_detail_model.dart';
import 'package:shantika_cubit/model/pesan_tiket_model.dart' as destination;
import 'package:shantika_cubit/model/city_depature_model.dart' as departure;
import 'package:shantika_cubit/model/agency_model.dart';
import 'package:shantika_cubit/model/time_model.dart';
import 'package:shantika_cubit/repository/base/base_repository.dart';

class TicketRepository extends BaseRepository {
  final ApiService _apiService;

  TicketRepository(this._apiService);

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

  Future<List<AgencyCity>> getAgencyCities(String cityId) async {
    final response = await _apiService.getAgencyCities(cityId);
    if (response.response.statusCode == 200 &&
        response.data?.success == true) {
      return response.data!.agenciesCity;
    } else {
      throw Exception(response.data?.message ?? 'Gagal memuat data agen');
    }
  }

  Future<List<Time>> getTime() async {
    try {
      final response = await _apiService.getTime();
      if (response.response.statusCode == 200 &&
          response.data?.success == true) {
        return response.data!.time;
      } else {
        throw Exception(response.data?.message ?? 'Gagal memuat data waktu');
      }
    } catch (e) {
      throw Exception('Error fetching time: $e');
    }
  }

  Future<List<FleetClass>> getFleetClasses() async {
    try {
      final response = await _apiService.getFleetClasses();
      if (response.response.statusCode == 200 &&
          response.data?.success == true) {
        return response.data!.fleetClasses;
      } else {
        throw Exception(response.data?.message ?? 'Gagal memuat data armada');
      }
    } catch (e) {
      throw Exception('Error fetching time: $e');
    }
  }

  Future<FleetDetail> getFleetDetail(int fleetClassId) async {
    try {
      print('Fetching fleet detail for ID: $fleetClassId');
      final response = await _apiService.getInfoFleet(fleetClassId);

      print('Response status: ${response.response.statusCode}');

      if (response.response.statusCode == 200 && response.data?.success == true) {
        print('Fleet detail fetched successfully');
        return response.data!.fleetDetail;
      } else {
        throw Exception(response.data?.message ?? 'Gagal memuat detail armada');
      }
    } catch (e) {
      print('Error in getFleetDetail: $e');
      throw Exception('Error fetching fleet detail: $e');
    }
  }
}
