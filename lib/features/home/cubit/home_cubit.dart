import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shantika_cubit/repository/home_repository.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository _repository;

  HomeCubit(this._repository) : super(HomeInitial());

  // Future<void> fetchHomeData() async {
  //   try {
  //     emit(HomeLoading());
  //
  //     final response = await _repository.getHome();
  //
  //     if (response.success) {
  //       emit(HomeLoaded(response));
  //     } else {
  //       emit(HomeError(response.message));
  //     }
  //   } catch (e) {
  //     emit(HomeError(e.toString()));
  //   }
  // }

  Future<void> fetchHomeData() async {
    emit(HomeLoading());
    try {
      print('🔄 Fetching home data...');
      final data = await _repository.getHome();
      print('✅ Home data loaded successfully');
      emit(HomeLoaded(data));
    } catch (e) {
      print('❌ Error loading home: $e');
      emit(HomeError(e.toString()));
    }
  }

  Future<void> refreshHomeData() async {
    await fetchHomeData();
  }
}
