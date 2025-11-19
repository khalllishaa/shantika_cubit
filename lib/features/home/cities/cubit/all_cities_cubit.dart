import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shantika_cubit/features/home/cities/cubit/all_cities_state.dart';
import 'package:shantika_cubit/repository/info_agency_repository.dart';

class AllCitiesCubit extends Cubit<AllCitiesState> {
  final InfoAgencyRepository _repository;

  AllCitiesCubit(this._repository) : super(AllCitiesInitial());

  Future<void> loadCities() async {
    try {
      print('AllCitiesCubit: Starting loadCities()');
      emit(AllCitiesLoading());
      print('AllCitiesCubit: Emitted AllCitiesLoading');

      final cities = await _repository.getAllCities();
      print('AllCitiesCubit: Got ${cities.length} cities from repository');

      emit(AllCitiesLoaded(cities));
      print('AllCitiesCubit: Emitted AllCitiesLoaded');
    } catch (e) {
      print('AllCitiesCubit: Error - $e');
      emit(AllCitiesError(e.toString()));
    }
  }
}