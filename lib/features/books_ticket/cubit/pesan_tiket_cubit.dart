import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shantika_cubit/model/pesan_tiket_model.dart';
import 'package:shantika_cubit/repository/pesan_tiket_repository.dart';
import 'pesan_tiket_state.dart';

class PesanTiketCubit extends Cubit<PesanTiketState> {
  final TicketRepository _repository;

  PesanTiketCubit(this._repository) : super(PesanTiketInitial());

  Future<void> loadInitialData() async {
    try {
      emit(PesanTiketLoading());

      // Fetch cities dari API
      final cities = await _repository.getCities();

      emit(PesanTiketLoaded(cities: cities));
    } catch (e) {
      emit(PesanTiketError('Terjadi kesalahan: ${e.toString()}'));
    }
  }

  void selectDepartureCity(City city) {
    if (state is PesanTiketLoaded) {
      final currentState = state as PesanTiketLoaded;

      // Reset agency kalau ganti kota
      emit(currentState.copyWith(
        selectedDepartureCity: city,
        selectedAgency: null,
      ));
    }
  }

  void selectDestinationCity(City city) {
    if (state is PesanTiketLoaded) {
      final currentState = state as PesanTiketLoaded;
      emit(currentState.copyWith(selectedDestinationCity: city));
    }
  }

  void selectAgency(String agency) {
    if (state is PesanTiketLoaded) {
      final currentState = state as PesanTiketLoaded;
      emit(currentState.copyWith(selectedAgency: agency));
    }
  }

  void selectDate(DateTime date) {
    if (state is PesanTiketLoaded) {
      final currentState = state as PesanTiketLoaded;
      emit(currentState.copyWith(selectedDate: date));
    }
  }

  void selectTime(String time) {
    if (state is PesanTiketLoaded) {
      final currentState = state as PesanTiketLoaded;
      emit(currentState.copyWith(selectedTime: time));
    }
  }

  void selectClass(String fleetClass) {
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
      // Emit kembali ke loaded state
      emit(currentState);
      return;
    }

    try {
      // TODO: Call API untuk search tiket
      print('Searching tickets with:');
      print('Departure City: ${currentState.selectedDepartureCity?.name}');
      print('Agency: ${currentState.selectedAgency}');
      print('Destination City: ${currentState.selectedDestinationCity?.name}');
      print('Date: ${currentState.selectedDate}');
      print('Time: ${currentState.selectedTime}');
      print('Class: ${currentState.selectedClass}');
    } catch (e) {
      emit(PesanTiketError('Terjadi kesalahan: ${e.toString()}'));
      emit(currentState);
    }
  }

  // Dummy data untuk Agency & Class (sementara sampai ada API-nya)
  List<String> getAgenciesByCity(int cityId) {
    return [
      'Agen Terminal ${cityId}',
      'Agen Pusat ${cityId}',
      'Agen Timur ${cityId}',
      'Agen Barat ${cityId}',
    ];
  }

  List<String> getFleetClasses() {
    return [
      'Ekonomi',
      'Eksekutif',
      'Super Eksekutif',
      'Sleeper',
    ];
  }
}
