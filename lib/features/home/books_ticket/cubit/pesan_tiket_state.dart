import 'package:shantika_cubit/model/fleet_classes_model.dart';
import 'package:shantika_cubit/model/city_depature_model.dart' as departure;
import 'package:shantika_cubit/model/agency_model.dart';
import 'package:shantika_cubit/model/agency_by_id_model.dart' as byId;
import 'package:shantika_cubit/model/time_model.dart';
import 'package:shantika_cubit/model/fleet_available_model.dart' as available;

abstract class PesanTiketState {}

class PesanTiketInitial extends PesanTiketState {}

class PesanTiketLoading extends PesanTiketState {}

class PesanTiketLoaded extends PesanTiketState {
  final List<departure.City> departureCities;
  final List<AgencyCity> agencies;
  final List<byId.Agency> destinationAgencies;
  final List<Time> timeSlots;
  final List<FleetClass> fleetClasses; // Master data (untuk fallback)
  final List<available.FleetClass> availableFleetClasses; // ✅ Armada yang tersedia
  final departure.City? selectedDepartureCity;
  final AgencyCity? selectedAgency;
  final byId.Agency? selectedDestinationAgency;
  final DateTime? selectedDate;
  final Time? selectedTime;
  final available.FleetClass? selectedClass; // ✅ Ubah tipe ke available.FleetClass

  PesanTiketLoaded({
    required this.departureCities,
    required this.agencies,
    required this.destinationAgencies,
    required this.timeSlots,
    required this.fleetClasses,
    this.availableFleetClasses = const [], // ✅ Default kosong
    this.selectedDepartureCity,
    this.selectedAgency,
    this.selectedDestinationAgency,
    this.selectedDate,
    this.selectedTime,
    this.selectedClass,
  });

  PesanTiketLoaded copyWith({
    List<departure.City>? departureCities,
    List<AgencyCity>? agencies,
    List<byId.Agency>? destinationAgencies,
    List<Time>? timeSlots,
    List<FleetClass>? fleetClasses,
    List<available.FleetClass>? availableFleetClasses,
    departure.City? selectedDepartureCity,
    AgencyCity? selectedAgency,
    byId.Agency? selectedDestinationAgency,
    DateTime? selectedDate,
    Time? selectedTime,
    available.FleetClass? selectedClass,
    bool clearAgency = false,
    bool clearAvailableFleets = false, // ✅ Flag untuk reset available fleets
  }) {
    return PesanTiketLoaded(
      departureCities: departureCities ?? this.departureCities,
      agencies: agencies ?? this.agencies,
      destinationAgencies: destinationAgencies ?? this.destinationAgencies,
      timeSlots: timeSlots ?? this.timeSlots,
      fleetClasses: fleetClasses ?? this.fleetClasses,
      availableFleetClasses: clearAvailableFleets ? [] : (availableFleetClasses ?? this.availableFleetClasses),
      selectedDepartureCity: selectedDepartureCity ?? this.selectedDepartureCity,
      selectedAgency: clearAgency ? null : (selectedAgency ?? this.selectedAgency),
      selectedDestinationAgency: selectedDestinationAgency ?? this.selectedDestinationAgency,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedTime: selectedTime ?? this.selectedTime,
      selectedClass: selectedClass ?? this.selectedClass,
    );
  }

  bool get isValid =>
      selectedDepartureCity != null &&
          selectedAgency != null &&
          selectedDestinationAgency != null &&
          selectedDate != null &&
          selectedTime != null &&
          selectedClass != null;
}

class PesanTiketError extends PesanTiketState {
  final String message;

  PesanTiketError(this.message);
}