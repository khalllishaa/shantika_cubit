import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shantika_cubit/utility/extensions/dio_exception_extensions.dart';

import '../../../config/service_locator.dart';
import '../../../model/terms_conditions_model.dart';
import '../../../repository/app_settings_repository.dart';
import '../../../utility/resource/data_state.dart';

part 'terms_conditions_state.dart';

class TermsConditionsCubit extends Cubit<TermsConditionsState> {
  late AppSettingsRepository _AppSettingsRepository;
  TermsConditionsCubit() : super(TermsConditionsInitial());

  init() {
    _AppSettingsRepository = AppSettingsRepository(serviceLocator.get());
  }

  termsConditions() async {
    emit(TermsConditionsLoading());
    final DataState<TermsConditionsModel> dataState = await _AppSettingsRepository.termsConditions();
    switch (dataState) {
      case DataStateSuccess<TermsConditionsModel>():
        {
          emit(TermsConditionStateData(termsConditionModel: dataState.data ?? TermsConditionsModel()));
        }
      case DataStateError<TermsConditionsModel>():
        {
          emit(TermsConditionsError(message: dataState.exception?.parseMessage() ?? ""));
        }
    }
  }
}
