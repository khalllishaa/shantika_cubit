import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:shantika_cubit/features/assignment/cubit/history_assignment_cubit.dart';
import 'package:shantika_cubit/features/authentication/login/cubit/login_phone_cubit.dart';
import 'package:shantika_cubit/features/home/cubit/artikel_cubit.dart';
import 'package:shantika_cubit/splash_screen.dart';
import 'package:shantika_cubit/ui/theme.dart';

import 'config/service_locator.dart';
import 'features/assignment/cubit/assignment_review_cubit.dart';
// import 'features/authentication/login/cubit/login_apple_cubit.dart';
// import 'features/authentication/login/cubit/login_email_cubit.dart';
// import 'features/authentication/login/cubit/login_google_cubit.dart';
import 'features/authentication/password/cubit/change_password_cubit.dart';
import 'features/authentication/password/cubit/send_to_email_cubit.dart';
import 'features/authentication/password/cubit/validate_reset_token_cubit.dart';
import 'features/authentication/register/cubit/register_cubit.dart';
import 'features/home/cubit/detail_slider_cubit.dart';
import 'features/home/cubit/home_cubit.dart';
import 'features/navigation/cubit/update_fcm_token_cubit.dart';
import 'features/profile/cubit/logout_cubit.dart';
import 'features/profile/cubit/profile_cubit.dart';
import 'features/profile/cubit/update_profile_cubit.dart';
import 'features/terms_conditions/cubit/terms_conditions_cubit.dart';
import 'features/transaction/cubit/history_transaction_cubit.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  await setUpLocator();
  Jiffy.setLocale('id');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [

        BlocProvider(create: (context) => RegisterCubit()),
        BlocProvider(create: (context) => SendToEmailCubit()),
        BlocProvider(create: (context) => ValidateResetTokenCubit()),
        BlocProvider(create: (context) => ChangePasswordCubit()),
        BlocProvider(create: (context) => LoginPhoneCubit()),
        BlocProvider(create: (context) => RegisterCubit()),

        BlocProvider(create: (context) => TermsConditionsCubit()),
        BlocProvider(create: (context) => HistoryAssignmentCubit()),
        BlocProvider(create: (context) => HistoryTransactionCubit()),

        BlocProvider(create: (context) => ProfileCubit()),
        BlocProvider(create: (context) => UpdateProfileCubit()),

        /// HOME
        BlocProvider(create: (context) => HomeCubit()),
        BlocProvider(create: (context) => DetailSliderCubit()),
        BlocProvider(create: (context) => ArtikelCubit()),
        BlocProvider(create: (context) => LogoutCubit()..init()),

        BlocProvider(create: (context) => UpdateFcmTokenCubit()),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'New Shantika',
        theme: AppTheme.light,
        home: const SplashScreen(),
      ),
    );
  }
}