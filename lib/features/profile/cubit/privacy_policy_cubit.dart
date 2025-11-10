import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shantika_cubit/features/profile/cubit/privacy_policy_state.dart';
import 'package:shantika_cubit/model/privacy_policy_model.dart';
import 'package:shantika_cubit/repository/app_settings_repository.dart';
import 'package:shantika_cubit/utility/resource/data_state.dart';

class PrivacyPolicyCubit extends Cubit<PrivacyPolicyState> {
  final AppSettingsRepository repository;

  PrivacyPolicyCubit(this.repository) : super(PrivacyPolicyInitial());

  Future<void> fetchPrivacyPolicy() async {
    emit(PrivacyPolicyLoading());

    try {
      final result = await repository.privacyPolicy();

      if (result is DataStateSuccess<PrivacyPolicyModel>) {
        emit(PrivacyPolicyLoaded(result.data!));
      } else if (result is DataStateError) {
        final errorMessage = result.exception?.response?.data['message']
            ?? result.exception?.message
            ?? "Terjadi kesalahan saat mengambil data";
        emit(PrivacyPolicyError(errorMessage));
      }
    } catch (e) {
      emit(PrivacyPolicyError("Error tidak terduga: ${e.toString()}"));
    }
  }
}