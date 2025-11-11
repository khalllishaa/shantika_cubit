import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shantika_cubit/features/profile/cubit/notification/notification_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(const NotificationState()) {
    _loadSettings();
  }

  // Load settings dari SharedPreferences saat init
  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    emit(NotificationState(
      isAktivitasEnabled: prefs.getBool('aktivitas_enabled') ?? false,
      isSpesialEnabled: prefs.getBool('spesial_enabled') ?? false,
      isPengingatEnabled: prefs.getBool('pengingat_enabled') ?? false,
    ));
  }

  // Toggle Aktivitas
  Future<void> toggleAktivitas(bool value) async {
    emit(state.copyWith(isAktivitasEnabled: value));
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('aktivitas_enabled', value);
  }

  // Toggle Spesial
  Future<void> toggleSpesial(bool value) async {
    emit(state.copyWith(isSpesialEnabled: value));
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('spesial_enabled', value);
  }

  // Toggle Pengingat
  Future<void> togglePengingat(bool value) async {
    emit(state.copyWith(isPengingatEnabled: value));
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('pengingat_enabled', value);
  }
}