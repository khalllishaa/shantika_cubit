import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shantika_cubit/model/fleet_classes_model.dart';
import 'package:shantika_cubit/model/fleet_available_model.dart' as available;
import 'package:shantika_cubit/model/pesan_tiket_model.dart';
import 'package:shantika_cubit/model/city_depature_model.dart' as departure;
import 'package:shantika_cubit/model/agency_by_id_model.dart'; // ✅ GANTI IMPORT
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
        agencies: [], // ✅ List kosong Agency
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
      clearClass: true,
    ));

    try {
      print('Fetching agencies for city_id: ${city.id}');

      // ✅ GUNAKAN getAgencyById DARI REPOSITORY
      final agencyResponse = await _repository.getAgencyById(city.id.toString());
      final agencies = agencyResponse.agencies;

      print('Agencies loaded: ${agencies.length}');

      emit(currentState.copyWith(
        selectedDepartureCity: city,
        agencies: agencies,
        selectedAgency: null,
        clearClass: true,
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
      emit(currentState.copyWith(
        selectedDestinationCity: city,
        clearClass: true,
      ));
    }
  }

  void selectAgency(Agency agency) { // ✅ GANTI PARAMETER DARI AgencyCity
    if (state is PesanTiketLoaded) {
      final currentState = state as PesanTiketLoaded;
      emit(currentState.copyWith(
        selectedAgency: agency,
        clearClass: true,
      ));
    }
  }

  void selectDate(DateTime date) {
    if (state is PesanTiketLoaded) {
      final currentState = state as PesanTiketLoaded;
      emit(currentState.copyWith(
        selectedDate: date,
        clearClass: true,
      ));
    }
  }

  void selectTime(Time time) {
    if (state is PesanTiketLoaded) {
      final currentState = state as PesanTiketLoaded;
      emit(currentState.copyWith(
        selectedTime: time,
        clearClass: true,
      ));
    }
  }

  void selectClass(FleetClass fleetClass) {
    if (state is PesanTiketLoaded) {
      final currentState = state as PesanTiketLoaded;
      emit(currentState.copyWith(selectedClass: fleetClass));
    }
  }

  Future<void> loadAvailableFleetClasses() async {
    if (state is! PesanTiketLoaded) return;

    final currentState = state as PesanTiketLoaded;

    if (currentState.selectedAgency == null ||
        currentState.selectedTime == null ||
        currentState.selectedDate == null ||
        currentState.selectedDepartureCity == null) {
      print('Missing required parameters for fleet classes');
      return;
    }

    try {
      emit(currentState.copyWith(isLoadingFleetClasses: true));

      final formattedDate = DateFormat('yyyy-MM-dd').format(currentState.selectedDate!);

      final availableClasses = await _repository.getAvailableFleetClasses(
        agencyId: currentState.selectedAgency!.id,
        timeClassificationId: currentState.selectedTime!.id,
        date: formattedDate,
        agencyDepartureId: currentState.selectedDepartureCity!.id,
        destinationCityId: currentState.selectedDestinationCity?.id,
      );

      print('Available fleet classes loaded: ${availableClasses.length}');

      if (availableClasses.isEmpty) {
        emit(currentState.copyWith(
          fleetClasses: [],
          isLoadingFleetClasses: false,
          clearClass: true,
        ));
        return;
      }

      final convertedClasses = availableClasses.map((availableClass) {
        return FleetClass(
          id: availableClass.id,
          name: availableClass.name,
          seatCapacity: availableClass.seatCapacity,
          priceFood: availableClass.priceFood,
          code: '',
          fleetsCount: 0,
          priceFleetClass1: int.tryParse(availableClass.priceFood) ?? 0,
          priceFleetClass2: 0,
        );
      }).toList();

      emit(currentState.copyWith(
        fleetClasses: convertedClasses,
        isLoadingFleetClasses: false,
        clearClass: true,
      ));
    } catch (e) {
      print('Error loading available fleet classes: $e');
      emit(currentState.copyWith(
        fleetClasses: [],
        isLoadingFleetClasses: false,
        clearClass: true,
      ));
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
      print('Agency: ${currentState.selectedAgency?.agencyName}'); // ✅ GANTI DARI .name
      print('Destination City: ${currentState.selectedDestinationCity?.name}');
      print('Date: ${currentState.selectedDate}');
      print('Time: ${currentState.selectedTime?.name} (${currentState.selectedTime?.timeStart} - ${currentState.selectedTime?.timeEnd})');
      print('Class: ${currentState.selectedClass?.name}');
    } catch (e) {
      emit(PesanTiketError('Terjadi kesalahan: ${e.toString()}'));
      emit(currentState);
    }
  }
}