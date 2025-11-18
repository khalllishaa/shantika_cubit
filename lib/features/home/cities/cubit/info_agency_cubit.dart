import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shantika_cubit/features/home/cities/cubit/info_agency_state.dart';
import 'package:shantika_cubit/model/info_agency_model.dart';
import 'package:shantika_cubit/repository/info_agency_repository.dart';

class InfoAgencyCubit extends Cubit<InfoAgencyState> {
  final InfoAgencyRepository _repository;

  InfoAgencyCubit(this._repository) : super(InfoAgencyInitial());

  Future<void> loadInfoAgency(int cityId) async {
    try {
      emit(InfoAgencyLoading());
      final agencies = await _repository.getInfoAgency(cityId);
      emit(InfoAgencyLoaded(
        agencies: agencies,
        filteredAgencies: agencies,
      ));
    } catch (e) {
      emit(InfoAgencyError(e.toString()));
    }
  }

  void searchAgencies(String query) {
    final s = state;
    if (s is InfoAgencyLoaded) {
      final filtered = s.agencies.where((a) {
        return a.agencyName.toLowerCase().contains(query.toLowerCase());
      }).toList();

      emit(s.copyWith(
        filteredAgencies: query.isEmpty ? s.agencies : filtered,
        searchQuery: query,
      ));
    }
  }
}
