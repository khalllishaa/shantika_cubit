import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shantika_cubit/features/profile/cubit/about_us_state.dart';
import 'package:shantika_cubit/model/about_us_model.dart';
import '../../../repository/app_settings_repository.dart';
import '../../../utility/resource/data_state.dart';

class AboutCubit extends Cubit<AboutState> {
  final AppSettingsRepository repo;

  AboutCubit(this.repo) : super(AboutInitial());

  Future<void> fetchAbout() async {
    emit(AboutLoading());
    final result = await repo.about();

    if (result is DataStateSuccess) {
      emit(AboutLoaded(result.data!));
    } else {
      emit(AboutError(result.exception.toString()));
    }
  }

}
