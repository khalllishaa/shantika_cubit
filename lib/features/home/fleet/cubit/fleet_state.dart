import 'package:shantika_cubit/model/fleet_classes_model.dart';
import 'package:shantika_cubit/model/fleet_detail_model.dart';

abstract class FleetClassesState {}

class FleetClassesInitial extends FleetClassesState {}

class FleetClassesLoading extends FleetClassesState {}

class FleetClassesLoaded extends FleetClassesState {
  final List<FleetClass> fleetClasses;

  FleetClassesLoaded(this.fleetClasses);
}

class FleetClassesError extends FleetClassesState {
  final String message;

  FleetClassesError(this.message);
}

class FleetDetailLoading extends FleetClassesState {
  final List<FleetClass>? cachedFleetClasses;

  FleetDetailLoading({this.cachedFleetClasses});
}

class FleetDetailLoaded extends FleetClassesState {
  final FleetDetail fleetDetail;
  final List<FleetClass>? cachedFleetClasses;

  FleetDetailLoaded(this.fleetDetail, {this.cachedFleetClasses});
}

class FleetDetailError extends FleetClassesState {
  final String message;
  final List<FleetClass>? cachedFleetClasses;

  FleetDetailError(this.message, {this.cachedFleetClasses});
}