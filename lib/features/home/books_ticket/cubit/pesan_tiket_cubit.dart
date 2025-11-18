import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shantika_cubit/model/fleet_classes_model.dart';
import 'package:shantika_cubit/model/pesan_tiket_model.dart';
import 'package:shantika_cubit/model/city_depature_model.dart' as departure;
import 'package:shantika_cubit/model/agency_model.dart';
import 'package:shantika_cubit/model/time_model.dart';
import 'package:shantika_cubit/repository/pesan_tiket_repository.dart';
import 'pesan_tiket_state.dart';

class PesanTiketCubit extends Cubit<PesanTiketState> {
  final TicketRepository _repository;

  PesanTiketCubit(this._repository) : super(PesanTiketInitial());

  Future<void> loadInitialData() async {
    try {
      emit(PesanTiketLoading());
      print('Loading initial data...');

      final destinationCities = await _repository.getCities();
      final departureCities = await _repository.getDepartureCities();
      final timeSlots = await _repository.getTime();
      final fleetClasses = await _repository.getFleetClasses();

      print('Destination cities: ${destinationCities.length}');
      print('Departure cities: ${departureCities.length}');
      print('Time slots: ${timeSlots.length}');
      print('Fleet Classes: ${fleetClasses.length}');

      emit(PesanTiketLoaded(
        cities: destinationCities,
        departureCities: departureCities,
        agencies: [],
        timeSlots: timeSlots,
        fleetClasses: fleetClasses,
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
    ));

    try {
      print('Fetching agencies for city_id: ${city.id}');
      final agencies = await _repository.getAgencyCities(city.id.toString());
      print('Agencies loaded: ${agencies.length}');

      emit(currentState.copyWith(
        selectedDepartureCity: city,
        agencies: agencies,
        selectedAgency: null,
      ));
    } catch (e) {
      print('Error fetching agencies: $e');
      emit(PesanTiketError('Gagal memuat data agen: ${e.toString()}'));
      emit(currentState.copyWith(
        selectedDepartureCity: city,
        agencies: [],
      ));
    }
  }

  void selectDestinationCity(City city) {
    if (state is PesanTiketLoaded) {
      final currentState = state as PesanTiketLoaded;
      emit(currentState.copyWith(selectedDestinationCity: city));
    }
  }

  void selectAgency(AgencyCity agencyCity) {
    if (state is PesanTiketLoaded) {
      final currentState = state as PesanTiketLoaded;
      emit(currentState.copyWith(selectedAgency: agencyCity));
    }
  }

  void selectDate(DateTime date) {
    if (state is PesanTiketLoaded) {
      final currentState = state as PesanTiketLoaded;
      emit(currentState.copyWith(selectedDate: date));
    }
  }

  void selectTime(Time time) {
    if (state is PesanTiketLoaded) {
      final currentState = state as PesanTiketLoaded;
      emit(currentState.copyWith(selectedTime: time));
    }
  }

  void selectClass(FleetClass fleetClass) {
    if (state is PesanTiketLoaded) {
      final currentState = state as PesanTiketLoaded;
      emit(currentState.copyWith(selectedClass: fleetClass));
    }
  }

  Future<void> searchTickets() async {
    if (state is! PesanTiketLoaded) return;
    final currentState = state as PesanTiketLoaded;

    if (!currentState.isValid) {
      emit(PesanTiketError('Mohon lengkapi semua data'));
      emit(currentState);
      return;
    }

    try {
      print('Searching tickets...');
      print('Departure City: ${currentState.selectedDepartureCity?.name}');
      print('Agency: ${currentState.selectedAgency?.name}');
      print('Destination City: ${currentState.selectedDestinationCity?.name}');
      print('Date: ${currentState.selectedDate}');
      print('Time: ${currentState.selectedTime?.name} (${currentState.selectedTime?.timeStart} - ${currentState.selectedTime?.timeEnd})'); // ✅ UPDATED
      print('Class: ${currentState.selectedClass}');
    } catch (e) {
      emit(PesanTiketError('Terjadi kesalahan: ${e.toString()}'));
      emit(currentState);
    }
  }
}