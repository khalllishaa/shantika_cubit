import 'package:equatable/equatable.dart';
import 'package:shantika_cubit/model/all_cities_model.dart';

abstract class AllCitiesState extends Equatable {
  const AllCitiesState();

  @override
  List<Object?> get props => [];
}

class AllCitiesInitial extends AllCitiesState {}

class AllCitiesLoading extends AllCitiesState {}

class AllCitiesLoaded extends AllCitiesState {
  final List<City> cities;

  const AllCitiesLoaded(this.cities);

  @override
  List<Object?> get props => [cities];
}

class AllCitiesError extends AllCitiesState {
  final String message;

  const AllCitiesError(this.message);

  @override
  List<Object?> get props => [message];
}
