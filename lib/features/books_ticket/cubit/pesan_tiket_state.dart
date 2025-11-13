import 'package:shantika_cubit/model/pesan_tiket_model.dart';

abstract class PesanTiketState {}

class PesanTiketInitial extends PesanTiketState {}

class PesanTiketLoading extends PesanTiketState {}

class PesanTiketLoaded extends PesanTiketState {
  final List<City> cities;
  final City? selectedDepartureCity;
  final City? selectedDestinationCity;
  final String? selectedAgency;
  final DateTime? selectedDate;
  final String? selectedTime;
  final String? selectedClass;

  PesanTiketLoaded({
    required this.cities,
    this.selectedDepartureCity,
    this.selectedDestinationCity,
    this.selectedAgency,
    this.selectedDate,
    this.selectedTime,
    this.selectedClass,
  });

  PesanTiketLoaded copyWith({
    List<City>? cities,
    City? selectedDepartureCity,
    City? selectedDestinationCity,
    String? selectedAgency,
    DateTime? selectedDate,
    String? selectedTime,
    String? selectedClass,
  }) {
    return PesanTiketLoaded(
      cities: cities ?? this.cities,
      selectedDepartureCity: selectedDepartureCity ?? this.selectedDepartureCity,
      selectedDestinationCity: selectedDestinationCity ?? this.selectedDestinationCity,
      selectedAgency: selectedAgency ?? this.selectedAgency,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedTime: selectedTime ?? this.selectedTime,
      selectedClass: selectedClass ?? this.selectedClass,
    );
  }

  bool get isValid =>
      selectedDepartureCity != null &&
          selectedAgency != null &&
          selectedDestinationCity != null &&
          selectedDate != null &&
          selectedTime != null &&
          selectedClass != null;
}

class PesanTiketError extends PesanTiketState {
  final String message;

  PesanTiketError(this.message);
}