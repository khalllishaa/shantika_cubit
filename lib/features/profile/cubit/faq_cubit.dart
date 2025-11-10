import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shantika_cubit/features/profile/cubit/faq_state.dart';

import '../../../model/faq_model.dart';
import '../../../repository/app_settings_repository.dart';
import '../../../utility/resource/data_state.dart';

class FAQCubit extends Cubit<FAQState> {
  final AppSettingsRepository repository;

  FAQCubit(this.repository) : super(FAQInitial());

  Future<void> fetchFAQs() async {
    emit(FAQLoading());

    try {
      final result = await repository.faq();

      if (result is DataStateSuccess<List<FaqModel>>) {
        if (result.data != null && result.data!.isNotEmpty) {
          emit(FAQLoaded(result.data!));
        } else {
          emit(const FAQError("Tidak ada data FAQ"));
        }
      } else if (result is DataStateError) {
        final errorMessage = result.exception?.response?.data['message']
            ?? result.exception?.message
            ?? "Terjadi kesalahan saat mengambil data FAQ";
        emit(FAQError(errorMessage));
      }
    } catch (e) {
      emit(FAQError("Error tidak terduga: ${e.toString()}"));
    }
  }
}
