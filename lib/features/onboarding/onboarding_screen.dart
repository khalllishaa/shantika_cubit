import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:with_space_between/with_space_between.dart';

import '../../ui/color.dart';
import '../../ui/dimension.dart';
import '../../ui/typography.dart';
import '../authentication/login/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final pageController = PageController();
  int initialPage = 0;

  @override
  void initState() {
    getTokens();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildMainView(context);
  }

  Future<void> getTokens() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // Get FCM Token
    String? fcmToken = await messaging.getToken();
    print("🔥 FCM Token: $fcmToken");

    // Get APNs Token
    String? apnsToken = await messaging.getAPNSToken();
    print("📲 APNs Token: $apnsToken");
  }

  Widget _buildMainView(BuildContext context) {
    // double logicalPixelHeight = MediaQuery.of(context).size.height;

    // double devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    // double devicePixelHeight = logicalPixelHeight * devicePixelRatio;

    // bool isTablet = devicePixelHeight >= 600;
    final size = MediaQuery.of(context).size;
    bool isTablet = size.width > 600;

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: PageView(
                controller: pageController,
                children: [
                  _onboardingItemView(
                    image: "assets/images/img_home_onboarding.png",
                    context: context,
                    height: isTablet ? 150 : 400,
                    width: isTablet ? 150 : 400,
                    description: "Tidak perlu khawatir lagi soal keamanan rumah jika ingin berpergian",
                    title: "Keep Home\nSafe",
                  ),
                  _onboardingItemView(
                    image: "assets/images/img_event_onboarding.png",
                    context: context,
                    height: isTablet ? 150 : 400,
                    width: isTablet ? 150 : 400,
                    description: "Jalankan event secara aman dan terkendali  dengan pengamanan kami",
                    title: "Keep Event\nSmooth",
                  ),
                  _onboardingItemView(
                    image: "assets/images/img_guard_onboarding.png",
                    context: context,
                    height: isTablet ? 150 : 400,
                    width: isTablet ? 150 : 400,
                    description: "Dengan Mitra kami yang bersertifikat dan berpengalaman penuh",
                    title: "Professional Guard\nService",
                  ),
                ],
                onPageChanged: (e) {
                  setState(() {
                    initialPage = e;
                  });
                },
              ),
            ),
            _buildIndicatorView(context)
          ],
        ),
      ),
    );
  }

  Widget _buildIndicatorView(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: space400),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 800),
              height: 20,
              padding: const EdgeInsets.symmetric(horizontal: space200, vertical: space150),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(999), color: borderNeutralLight),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  for (int i = 0; i < 3; i++) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: space100, vertical: space100),
                      width: i == initialPage ? 20 : 8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(i == initialPage ? borderRadius500 : 999),
                        color: i == initialPage ? bgFillPrimary : bgLight,
                      ),
                    ),
                  ],
                ].withSpaceBetween(width: space200),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Lewati", style: sBold.copyWith(color: textDarkPrimary)),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                  )
                ].withSpaceBetween(width: space250),
              ),
            )
          ].withSpaceBetween(width: space200),
        ),
      ),
    );
  }

  Widget _onboardingItemView({
    required BuildContext context,
    required String image,
    required double height,
    required double width,
    required String title,
    required String description,
  }) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.08),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: space400),
            child: SizedBox(
              child: Image.asset(
                image,
                height: height,
                width: width,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: space400),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: lBold.copyWith(color: textDarkPrimary),
                ),
                const SizedBox(height: space300),
                Text(
                  description,
                  style: mdMedium.copyWith(color: textDarkSecondary),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
