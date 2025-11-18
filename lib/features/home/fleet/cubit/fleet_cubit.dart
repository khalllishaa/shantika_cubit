import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shantika_cubit/features/home/fleet/cubit/fleet_state.dart';
import 'package:shantika_cubit/model/fleet_classes_model.dart';
import 'package:shantika_cubit/repository/pesan_tiket_repository.dart';

class FleetClassesCubit extends Cubit<FleetClassesState> {
  final TicketRepository _repository;
  List<FleetClass>? _cachedFleetClasses;

  FleetClassesCubit(this._repository) : super(FleetClassesInitial());

  Future<void> loadFleetClasses() async {
    try {
      emit(FleetClassesLoading());
      print('Loading fleet classes...');

      final fleetClasses = await _repository.getFleetClasses();

      print('Fleet classes loaded: ${fleetClasses.length}');
      fleetClasses.forEach((fleet) {
        print('${fleet.name} (${fleet.code})');
      });

      _cachedFleetClasses = fleetClasses;
      emit(FleetClassesLoaded(fleetClasses));
    } catch (e) {
      print('Error loading fleet classes: $e');
      emit(FleetClassesError('Gagal memuat data kelas armada: ${e.toString()}'));
    }
  }

  Future<void> loadFleetDetail(int fleetClassId) async {
    try {
      emit(FleetDetailLoading(cachedFleetClasses: _cachedFleetClasses));
      print('Loading fleet detail for class ID: $fleetClassId');

      final fleetDetail = await _repository.getFleetDetail(fleetClassId);

      print('Fleet detail loaded: ${fleetDetail.name}');
      print('Class: ${fleetDetail.fleetClass}');
      print('Total Chairs: ${fleetDetail.totalChair}');
      print('Facilities: ${fleetDetail.facilities.length}');
      print('Images: ${fleetDetail.images.length}');

      emit(FleetDetailLoaded(
        fleetDetail,
        cachedFleetClasses: _cachedFleetClasses,
      ));
    } catch (e) {
      print('Error loading fleet detail: $e');
      emit(FleetDetailError(
        'Gagal memuat informasi armada: ${e.toString()}',
        cachedFleetClasses: _cachedFleetClasses, // ✅ Pass cache
      ));
    }
  }

  void backToFleetClasses() {
    if (_cachedFleetClasses != null) {
      print('🔙 Restoring fleet classes from cache');
      emit(FleetClassesLoaded(_cachedFleetClasses!));
    } else {
      print('⚠️ No cached data, reloading...');
      loadFleetClasses();
    }
  }
}