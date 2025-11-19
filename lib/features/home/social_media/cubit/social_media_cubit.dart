import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shantika_cubit/features/home/social_media/cubit/social_media_state.dart';
import 'package:shantika_cubit/repository/social_media_repository.dart';

class SocialMediaCubit extends Cubit<SocialMediaState> {
  final SocialMediaRepository _repository;

  SocialMediaCubit(this._repository) : super (SocialMediaInitial());

  Future<void> loadSocialMedia() async {
    try {
      print('SocialMediaCubit: Starting loadSocialMedia()');
      emit(SocialMediaLoading());
      print('SocialMediaCubit: Emitted SocialMediaLoading');

      final cities = await _repository.getSocialMedia();
      print('SocialMediaCubit: Got ${cities.length} social media from repository');

      emit(SocialMediaLoaded(cities));
      print('SocialMediaCubit: Emitted SocialMediaLoaded');
    } catch (e) {
      print('SocialMediaCubit: Error - $e');
      emit(SocialMediaError(e.toString()));
    }
  }

  Future<void> refreshSocialMedia() async {
    await loadSocialMedia();
  }
}