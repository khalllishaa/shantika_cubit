import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shantika_cubit/model/fleet_classes_model.dart';
import 'package:shantika_cubit/model/city_depature_model.dart' as departure;
import 'package:shantika_cubit/model/agency_model.dart';
import 'package:shantika_cubit/model/agency_by_id_model.dart' as byId;
import 'package:shantika_cubit/model/routes_available_model.dart';
import 'package:shantika_cubit/model/time_model.dart';
import 'package:shantika_cubit/model/fleet_available_model.dart' as available;
import 'package:shantika_cubit/repository/pesan_tiket_repository.dart';
import 'pesan_tiket_state.dart';

class PesanTiketCubit extends Cubit<PesanTiketState> {
  final TicketRepository _repository;

  PesanTiketCubit(this._repository) : super(PesanTiketInitial());

  Future<void> loadInitialData() async {
    try {
      emit(PesanTiketLoading());
      print('Loading initial data...');

      final departureCities = await _repository.getDepartureCities();
      final timeSlots = await _repository.getTime();
      final fleetClasses = await _repository.getFleetClasses();

      print('Departure cities: ${departureCities.length}');
      print('Time slots: ${timeSlots.length}');
      print('Fleet Classes: ${fleetClasses.length}');

      emit(PesanTiketLoaded(
        departureCities: departureCities,
        agencies: [],
        destinationAgencies: [],
        timeSlots: timeSlots,
        fleetClasses: fleetClasses,
        availableFleetClasses: [],
      ));
    } catch (e) {
      print('Error loading initial data: $e');
      emit(PesanTiketError('Gagal memuat data: ${e.toString()}'));
    }
  }

  Future<void> selectDepartureCity(departure.City city) async {
    if (state is! PesanTiketLoaded) return;
    final currentState = state as PesanTiketLoaded;

    emit(currentState.copyWith(
      selectedDepartureCity: city,
      selectedAgency: null,
      agencies: [],
      clearAvailableFleets: true,
    ));

    try {
      print('Fetching agencies for departure city_id: ${city.id}');
      final agencies = await _repository.getAgencyCities(city.id.toString());
      print('Agencies loaded: ${agencies.length}');

      print('Fetching destination agencies for city_id: ${city.id}');
      final destinationAgencies = await _repository.getDestinationAgencies(city.id.toString());
      print('Destination agencies loaded: ${destinationAgencies.length}');

      emit(currentState.copyWith(
        selectedDepartureCity: city,
        agencies: agencies,
        destinationAgencies: destinationAgencies,
        selectedAgency: null,
      ));
    } catch (e) {
      print('Error fetching agencies: $e');
      emit(PesanTiketError('Gagal memuat data agen: ${e.toString()}'));
      emit(currentState.copyWith(
        selectedDepartureCity: city,
        agencies: [],
        destinationAgencies: [],
      ));
    }
  }

  void selectAgency(AgencyCity agencyCity) {
    if (state is PesanTiketLoaded) {
      final currentState = state as PesanTiketLoaded;
      emit(currentState.copyWith(
        selectedAgency: agencyCity,
        clearAvailableFleets: true,
      ));
    }
  }

  void selectDestinationAgency(byId.Agency agency) {
    if (state is PesanTiketLoaded) {
      final currentState = state as PesanTiketLoaded;
      emit(currentState.copyWith(
        selectedDestinationAgency: agency,
        clearAvailableFleets: true,
      ));
    }
  }

  void selectDate(DateTime date) {
    if (state is PesanTiketLoaded) {
      final currentState = state as PesanTiketLoaded;
      emit(currentState.copyWith(
        selectedDate: date,
        clearAvailableFleets: true,
      ));
    }
  }

  void selectTime(Time time) {
    if (state is PesanTiketLoaded) {
      final currentState = state as PesanTiketLoaded;
      emit(currentState.copyWith(
        selectedTime: time,
        clearAvailableFleets: true,
      ));
    }
  }

  void selectClass(available.FleetClass fleetClass) {
    if (state is PesanTiketLoaded) {
      final currentState = state as PesanTiketLoaded;
      emit(currentState.copyWith(selectedClass: fleetClass));
    }
  }

  Future<void> loadAvailableFleetClasses() async {
    if (state is! PesanTiketLoaded) return;
    final currentState = state as PesanTiketLoaded;
    if (currentState.selectedAgency == null ||
        currentState.selectedDestinationAgency == null ||
        currentState.selectedDate == null ||
        currentState.selectedTime == null) {
      print('Cannot load available fleets: missing required fields');
      return;
    }

    try {
      print('Loading available fleet classes...');

      final dateString = DateFormat('yyyy-MM-dd').format(currentState.selectedDate!);

      final availableFleets = await _repository.getAvailableFleetClasses(
        agencyId: currentState.selectedDestinationAgency!.id,
        timeClassificationId: currentState.selectedTime!.id,
        date: dateString,
        agencyDepartureId: currentState.selectedAgency!.id,
      );

      print('Available fleets loaded: ${availableFleets.length}');

      emit(currentState.copyWith(
        availableFleetClasses: availableFleets,
        selectedClass: null,
      ));
    } catch (e) {
      print('Error loading available fleet classes: $e');
      emit(PesanTiketError('Gagal memuat armada tersedia: ${e.toString()}'));
      emit(currentState.copyWith(availableFleetClasses: []));
    }
  }

  Future<List<Route>?> searchTickets() async {
    if (state is! PesanTiketLoaded) return null;
    final currentState = state as PesanTiketLoaded;

    if (!currentState.isValid) {
      emit(PesanTiketError('Mohon lengkapi semua data'));
      emit(currentState);
      return null;
    }

    try {
      print('Searching tickets...');
      print('Departure City: ${currentState.selectedDepartureCity?.name}');
      print('Agency Departure: ${currentState.selectedAgency?.name}');
      print('Agency Destination: ${currentState.selectedDestinationAgency?.agencyName}');
      print('Date: ${currentState.selectedDate}');
      print('Time: ${currentState.selectedTime?.name}');
      print('Class: ${currentState.selectedClass?.name}');

      final dateString = DateFormat('yyyy-MM-dd').format(currentState.selectedDate!);

      final routes = await _repository.getAvailableRoutes(
        fleetClassId: currentState.selectedClass!.id,
        agencyDepartureId: currentState.selectedAgency!.id,
        agencyArrivedId: currentState.selectedDestinationAgency!.id,
        timeClassificationId: currentState.selectedTime!.id,
        date: dateString,
      );

      print('Routes found: ${routes.length}');

      return routes;
    } catch (e) {
      print('Error searching tickets: $e');
      emit(PesanTiketError('Gagal mencari tiket: ${e.toString()}'));
      emit(currentState);
      return null;
    }
  }

  Future<void> getSeatLayout({
    required int fleetRouteId,
    required int timeClassificationId,
    required String date,
    required int departureAgencyId,
    required int destinationAgencyId,
  }) async {
    try {
      emit(SeatLayoutLoading());

      print('Fetching seat layout...');
      final seatLayout = await _repository.getSeatLayout(
        fleetRouteId: fleetRouteId,
        timeClassificationId: timeClassificationId,
        date: date,
        departureAgencyId: departureAgencyId,
        destinationAgencyId: destinationAgencyId,
      );

      print('Seat layout loaded successfully');
      emit(SeatLayoutLoaded(
        layoutBawah: seatLayout.data,
        layoutAtas: seatLayout.data,
      ));

    } catch (e) {
      print('Error fetching seat layout: $e');
      emit(SeatLayoutError('Gagal memuat layout kursi: ${e.toString()}'));
    }
  }

  Future<void> loadSampleSeatLayout() async {
    try {
      emit(SeatLayoutLoading());
      final seatLayout = await _repository.getSeatLayout(
        fleetRouteId: 1,
        timeClassificationId: 1,
        date: '2024-01-01',
        departureAgencyId: 1,
        destinationAgencyId: 2,
      );

      emit(SeatLayoutLoaded(
        layoutBawah: seatLayout.data,
        layoutAtas: seatLayout.data,
      ));

    } catch (e) {
      print('Error loading sample seat layout: $e');
      emit(SeatLayoutError('Gagal memuat layout kursi: ${e.toString()}'));
    }
  }
}