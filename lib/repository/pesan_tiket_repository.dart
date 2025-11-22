import 'package:dio/dio.dart';
import 'package:shantika_cubit/data/api/api_service.dart';
import 'package:shantika_cubit/model/agency_by_id_model.dart';
import 'package:shantika_cubit/model/fleet_available_model.dart' as available;
import 'package:shantika_cubit/model/fleet_classes_model.dart' as classes;
import 'package:shantika_cubit/model/fleet_classes_model.dart';
import 'package:shantika_cubit/model/fleet_detail_model.dart';
import 'package:shantika_cubit/model/pesan_tiket_model.dart' as destination;
import 'package:shantika_cubit/model/city_depature_model.dart' as departure;
import 'package:shantika_cubit/model/agency_model.dart';
import 'package:shantika_cubit/model/agency_by_id_model.dart' as byId;
import 'package:shantika_cubit/model/seat_layout_model.dart';
import 'package:shantika_cubit/model/time_model.dart';
import 'package:shantika_cubit/repository/base/base_repository.dart';

import '../model/routes_available_model.dart';

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

  Future<List<available.FleetClass>> getAvailableFleetClasses({
    required int agencyId,
    required int timeClassificationId,
    required String date,
    required int agencyDepartureId,
    int? destinationCityId,
  }) async {
    try {
      print('Fetching available fleet classes with params:');
      print('- agency_id: $agencyId');
      print('- time_classification_id: $timeClassificationId');
      print('- date: $date');
      print('- agency_departure_id: $agencyDepartureId');
      if (destinationCityId != null) {
        print('- destination_city_id: $destinationCityId');
      }

      final response = await _apiService.getAvailableFleetClasses(
        agencyId: agencyId,
        timeClassificationId: timeClassificationId,
        date: date,
        agencyDepartureId: agencyDepartureId,
        destinationCityId: destinationCityId,
      );

      if (response.response.statusCode == 200 &&
          response.data?.success == true) {
        print('Available fleet classes loaded: ${response.data!.fleetClasses.length}');
        return response.data!.fleetClasses;
      } else {
        throw Exception(response.data?.message ?? 'Gagal memuat data kelas armada tersedia');
      }
    } catch (e) {
      print('Error fetching available fleet classes: $e');
      throw Exception('Error fetching available fleet classes: $e');
    }
  }

  Future<List<byId.Agency>> getDestinationAgencies(String cityId) async {
    try {
      final response = await _apiService.getAgenciesById(cityId);

      if (response.response.statusCode == 200 &&
          response.data?.success == true) {
        return response.data!.agencies;
      } else {
        throw Exception(response.data?.message ?? 'Gagal memuat data tujuan');
      }
    } catch (e) {
      throw Exception('Error fetching destination agencies: $e');
    }
  }

  Future<List<Route>> getAvailableRoutes({
    required int fleetClassId,
    required int agencyDepartureId,
    required int agencyArrivedId,
    required int timeClassificationId,
    required String date,
  }) async {
    try {
      print('Fetching available routes with params:');
      print('- fleet_class_id: $fleetClassId');
      print('- agency_departure_id: $agencyDepartureId');
      print('- agency_arrived_id: $agencyArrivedId');
      print('- time_classification_id: $timeClassificationId');
      print('- date: $date');

      final response = await _apiService.getAvailableRoutes(
        fleetClassId: fleetClassId,
        agencyDepartureId: agencyDepartureId,
        agencyArrivedId: agencyArrivedId,
        timeClassificationId: timeClassificationId,
        date: date,
      );

      if (response.response.statusCode == 200 &&
          response.data?.success == true) {
        print('Available routes loaded: ${response.data!.routes.length}');
        return response.data!.routes;
      } else {
        throw Exception(response.data?.message ?? 'Gagal memuat data rute');
      }
    } catch (e) {
      print('Error fetching available routes: $e');
      throw Exception('Error fetching available routes: $e');
    }
  }

  Future<SeatLayoutModel> getSeatLayout({
    required int fleetRouteId,
    required int timeClassificationId,
    required String date,
    required int departureAgencyId,
    required int destinationAgencyId,
  }) async {
    try {
      final response = await _apiService.getSeatLayout(
        fleetRouteId: fleetRouteId,
        timeClassificationId: timeClassificationId,
        date: date,
        departureAgencyId: departureAgencyId,
        destinationAgencyId: destinationAgencyId,
      );

      if (response.response.statusCode == 200 && response.data!.success == true) {
        return response.data!;
      } else {
        throw Exception(response.data?.message ?? 'Gagal memuat layout kursi');
      }
    } catch (e) {
      throw Exception('Error getSeatLayout: $e');
    }
  }

}
