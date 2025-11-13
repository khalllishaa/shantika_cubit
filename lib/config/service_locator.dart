import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shantika_cubit/config/user_preference.dart';
import 'package:shantika_cubit/repository/app_settings_repository.dart';
import 'package:shantika_cubit/repository/chat_repository.dart';
import 'package:shantika_cubit/repository/home_repository.dart';
import 'package:shantika_cubit/repository/notification_repository.dart';
import 'package:shantika_cubit/repository/pesan_tiket_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/api/api_service.dart';
import 'constant.dart';
import 'env/env.dart';

/// Global [GetIt.instance].
final GetIt serviceLocator = GetIt.instance;

/// Set up [GetIt] locator.
Future<void> setUpLocator() async {
  final prefs = await SharedPreferences.getInstance();
  serviceLocator.registerSingleton<UserPreference>(UserPreference(prefs));

  serviceLocator.registerFactory<Dio>(() {
    final dio = Dio();
    kDebugMode ? dio.interceptors.add(AwesomeDioInterceptor()) : null;
    dio.options = BaseOptions(
      connectTimeout: const Duration(seconds: timeOutDuration),
      receiveTimeout: const Duration(seconds: timeOutDuration),
      persistentConnection: false,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        "x-api-key": Env.apiKey,
        'Authorization': 'Bearer ${serviceLocator.get<UserPreference>().getToken()}'
      },
    );

    return dio;
  });

  serviceLocator.registerFactory<ApiService>(
    () => ApiService(
      serviceLocator.get<Dio>(),
      baseUrl: baseApi,
    ),
  );

  serviceLocator.registerLazySingleton<AppSettingsRepository>(
        () => AppSettingsRepository(serviceLocator<ApiService>()),
  );

  serviceLocator.registerLazySingleton<NotificationRepository>(
        () => NotificationRepository(serviceLocator<ApiService>()),
  );

  serviceLocator.registerLazySingleton<ChatRepository>(
        () => ChatRepository(serviceLocator<ApiService>()),
  );

  serviceLocator.registerLazySingleton<HomeRepository>(
        () => HomeRepository(serviceLocator<ApiService>()),
  );

  serviceLocator.registerLazySingleton<TicketRepository>(
        () => TicketRepository(serviceLocator<ApiService>()),
  );

  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  serviceLocator.registerSingleton<PackageInfo>(packageInfo);
}
