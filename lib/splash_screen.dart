import 'package:flutter/material.dart';
import 'package:shantika_cubit/config/service_locator.dart';
import 'package:shantika_cubit/config/user_preference.dart';
import 'package:shantika_cubit/features/navigation/navigation_screen.dart';

import 'features/onboarding/onboarding_screen.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        isLogin()
            ? Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => NavigationScreen(),
                ),
                (route) => false)
            : Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => OnboardingScreen(),
                ),
                (route) => false);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildMainView();
  }

  bool isLogin() {
    final userPreference = serviceLocator.get<UserPreference>();
    return userPreference.getToken() != null;
  }

  Widget _buildMainView() {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/images/img_splash_screen.png'),
      ),
    );
  }
}
