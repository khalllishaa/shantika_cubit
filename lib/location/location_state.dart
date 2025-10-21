part of 'location_cubit.dart';

@immutable
sealed class LocationState {}

final class LocationInitial extends LocationState {}

final class LocationStateLoading extends LocationState {}

final class LocationStateError extends LocationState {
  final String message;
  LocationStateError({required this.message});
}

final class LocationStateGetLocation extends LocationState {
  final LatLng latLng;
  final String? address;
  LocationStateGetLocation({required this.latLng, required this.address});
}
