import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shantika_cubit/model/pesan_tiket_model.dart';
import 'package:shantika_cubit/model/city_depature_model.dart' as departure;
import 'package:shantika_cubit/model/agency_model.dart';
import 'package:shantika_cubit/repository/pesan_tiket_repository.dart';
import 'pesan_tiket_state.dart';

class PesanTiketCubit extends Cubit<PesanTiketState> {
  final TicketRepository _repository;

  PesanTiketCubit(this._repository) : super(PesanTiketInitial());

  /// 🔹 Load data awal: cuma city aja, biar ringan
  Future<void> loadInitialData() async {
    try {
      emit(PesanTiketLoading());
      print('🔄 Loading cities only...');

      final destinationCities = await _repository.getCities();
      final departureCities = await _repository.getDepartureCities();

      print('✅ Destination cities: ${destinationCities.length}');
      print('✅ Departure cities: ${departureCities.length}');

      emit(PesanTiketLoaded(
        cities: destinationCities,
        departureCities: departureCities,
        agencies: [], // belum di-load
      ));
    } catch (e) {
      print('❌ Error loading cities: $e');
      emit(PesanTiketError('Gagal memuat data kota: ${e.toString()}'));
    }
  }

  /// 🔹 Load agency saat pilih departure city aja
  Future<void> selectDepartureCity(departure.City city) async {
    if (state is! PesanTiketLoaded) return;
    final currentState = state as PesanTiketLoaded;

    // tampilkan dulu city-nya biar UI langsung update
    emit(currentState.copyWith(
      selectedDepartureCity: city,
      selectedAgency: null,
      agencies: [],
    ));

    try {
      print('🔎 Fetching agencies for city_id: ${city.id}');
      final agencies = await _repository.getAgencies(city.id.toString());
      print('✅ Agencies loaded: ${agencies.length}');

      emit(currentState.copyWith(
        selectedDepartureCity: city,
        agencies: agencies,
        selectedAgency: null,
      ));
    } catch (e) {
      print('❌ Error fetching agencies: $e');
      emit(PesanTiketError('Gagal memuat data agen: ${e.toString()}'));
      emit(currentState.copyWith(
        selectedDepartureCity: city,
        agencies: [],
      ));
    }
  }

  /// 🔹 Select destination city
  void selectDestinationCity(City city) {
    if (state is PesanTiketLoaded) {
      final currentState = state as PesanTiketLoaded;
      emit(currentState.copyWith(selectedDestinationCity: city));
    }
  }

  /// 🔹 Select agency
  void selectAgency(Agency agency) {
    if (state is PesanTiketLoaded) {
      final currentState = state as PesanTiketLoaded;
      emit(currentState.copyWith(selectedAgency: agency));
    }
  }

  /// 🔹 Select date
  void selectDate(DateTime date) {
    if (state is PesanTiketLoaded) {
      final currentState = state as PesanTiketLoaded;
      emit(currentState.copyWith(selectedDate: date));
    }
  }

  /// 🔹 Select time
  void selectTime(String time) {
    if (state is PesanTiketLoaded) {
      final currentState = state as PesanTiketLoaded;
      emit(currentState.copyWith(selectedTime: time));
    }
  }

  /// 🔹 Select class
  void selectClass(String fleetClass) {
    if (state is PesanTiketLoaded) {
      final currentState = state as PesanTiketLoaded;
      emit(currentState.copyWith(selectedClass: fleetClass));
    }
  }

  /// 🔹 Search tickets (belum ke API)
  Future<void> searchTickets() async {
    if (state is! PesanTiketLoaded) return;
    final currentState = state as PesanTiketLoaded;

    if (!currentState.isValid) {
      emit(PesanTiketError('Mohon lengkapi semua data'));
      emit(currentState);
      return;
    }

    try {
      print('🚀 Searching tickets...');
      print('Departure City: ${currentState.selectedDepartureCity?.name}');
      print('Agency: ${currentState.selectedAgency?.agencyName}');
      print('Destination City: ${currentState.selectedDestinationCity?.name}');
      print('Date: ${currentState.selectedDate}');
      print('Time: ${currentState.selectedTime}');
      print('Class: ${currentState.selectedClass}');
    } catch (e) {
      emit(PesanTiketError('Terjadi kesalahan: ${e.toString()}'));
      emit(currentState);
    }
  }

  /// 🔹 Fleet class dummy list
  List<String> getFleetClasses() {
    return [
      'Ekonomi',
      'Eksekutif',
      'Super Eksekutif',
      'Sleeper',
    ];
  }
}
