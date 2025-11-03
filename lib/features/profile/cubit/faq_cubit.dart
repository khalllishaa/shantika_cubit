import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shantika_cubit/features/profile/cubit/faq_state.dart';

import '../../../model/faq_model.dart';
import '../../../repository/app_settings_repository.dart';
import '../../../utility/resource/data_state.dart';

class FAQCubit extends Cubit<FAQState> {
  final AppSettingsRepository repository;

  FAQCubit(this.repository) : super(FAQInitial());

  // Future<void> fetchFAQs() async {
  //   emit(FAQLoading());
  //   final result = await repository.faq();
  //
  //   if (result is DataStateSuccess<List<FaqModel>>) {
  //     emit(FAQLoaded(result.data));
  //   } else if (result is DataStateError<List<FaqModel>>) {
  //     emit(FAQError(result.exception ?? "Unknown error"));
  //   }
  //
  // }
}
