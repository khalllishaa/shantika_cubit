import 'package:shantika_cubit/model/fleet_classes_model.dart';
import 'package:shantika_cubit/model/pesan_tiket_model.dart';
import 'package:shantika_cubit/model/city_depature_model.dart' as departure;
import 'package:shantika_cubit/model/agency_model.dart';
import 'package:shantika_cubit/model/time_model.dart';

abstract class PesanTiketState {}

class PesanTiketInitial extends PesanTiketState {}

class PesanTiketLoading extends PesanTiketState {}

class PesanTiketLoaded extends PesanTiketState {
  final List<City> cities;
  final List<departure.City> departureCities;
  final List<AgencyCity> agencies;
  final List<Time> timeSlots;
  final List<FleetClass> fleetClasses;
  final departure.City? selectedDepartureCity;
  final City? selectedDestinationCity;
  final AgencyCity? selectedAgency;
  final DateTime? selectedDate;
  final Time? selectedTime;
  final FleetClass? selectedClass;

  PesanTiketLoaded({
    required this.cities,
    required this.departureCities,
    required this.agencies,
    required this.timeSlots,
    required this.fleetClasses,
    this.selectedDepartureCity,
    this.selectedDestinationCity,
    this.selectedAgency,
    this.selectedDate,
    this.selectedTime,
    this.selectedClass,
  });

  PesanTiketLoaded copyWith({
    List<City>? cities,
    List<departure.City>? departureCities,
    List<AgencyCity>? agencies,
    List<Time>? timeSlots,
    List<FleetClass>? fleetClasses,
    departure.City? selectedDepartureCity,
    City? selectedDestinationCity,
    AgencyCity? selectedAgency,
    DateTime? selectedDate,
    Time? selectedTime,
    FleetClass? selectedClass,
    bool clearAgency = false,
  }) {
    return PesanTiketLoaded(
      cities: cities ?? this.cities,
      departureCities: departureCities ?? this.departureCities,
      agencies: agencies ?? this.agencies,
      timeSlots: timeSlots ?? this.timeSlots,
      fleetClasses: fleetClasses ?? this.fleetClasses,
      selectedDepartureCity: selectedDepartureCity ?? this.selectedDepartureCity,
      selectedDestinationCity: selectedDestinationCity ?? this.selectedDestinationCity,
      selectedAgency: clearAgency ? null : (selectedAgency ?? this.selectedAgency),
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