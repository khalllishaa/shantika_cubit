import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shantika_cubit/features/terms_conditions/cubit/terms_conditions_state.dart';
import 'package:shantika_cubit/model/terms_conditions_model.dart';
import 'package:shantika_cubit/repository/app_settings_repository.dart';
import 'package:shantika_cubit/utility/resource/data_state.dart';

class TermsConditionsCubit extends Cubit<TermsConditionsState> {
  final AppSettingsRepository repository;

  TermsConditionsCubit(this.repository) : super(TermsConditionsInitial());

  Future<void> fetchTermsConditions() async {
    emit(TermsConditionsLoading());

    try {
      final result = await repository.termsConditions();

      if (result is DataStateSuccess<TermsConditionsModel>) {
        emit(TermsConditionsLoaded(result.data!));
      } else if (result is DataStateError) {
        final errorMessage = result.exception?.response?.data['message']
            ?? result.exception?.message
            ?? "Terjadi kesalahan saat mengambil data";
        emit(TermsConditionsError(errorMessage));
      }
    } catch (e) {
      emit(TermsConditionsError("Error tidak terduga: ${e.toString()}"));
    }
  }
}