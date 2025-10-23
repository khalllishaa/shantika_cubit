import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shantika_cubit/features/profile/informasi_pribadi_screen.dart';
import 'package:shantika_cubit/utility/extensions/date_time_extensions.dart';
import 'package:shantika_cubit/utility/extensions/show_toast.dart';
import 'package:shantika_cubit/utility/extensions/widget_extensions.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:with_space_between/with_space_between.dart';

import '../../config/constant.dart';
import '../../config/service_locator.dart';
import '../../config/user_preference.dart';
import '../../model/user_model.dart';
import '../../ui/color.dart';
import '../../ui/dimension.dart';
import '../../ui/shared_widget/circle_image_view.dart';
import '../../ui/shared_widget/custom_button.dart';
import '../../ui/shared_widget/custom_card.dart';
import '../../ui/shared_widget/error_view.dart';
import '../../ui/shared_widget/reuse_menu_profile.dart';
import '../../ui/typography.dart';
import '../../utility/loading_overlay.dart';
// import '../article/article_screen.dart';
import '../authentication/login/login_screen.dart';
// import '../notification/notification_screen.dart';
// import '../promo/promo_screen.dart';
import 'cubit/logout_cubit.dart';
import 'cubit/profile_cubit.dart';
import 'my_profile_screen.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black00,
      appBar: _header(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: space800),
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/img_profil_default.jpg'),
                backgroundColor: black500,
              ),
              SizedBox(height: spacing5),
              Text(
                "Anastasya Carolina",
                style: mdBold,
              ),
              SizedBox(height: space150),
              Text(
                "087374543899",
                style: smMedium.copyWith(color: black400),
              ),
              SizedBox(height: spacing7),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: padding20),
                child: Column(
                  children: [
                    _menuItem(
                      svgIcon: 'assets/icons/profile_outline.svg',
                      text: "Informasi Pribadi",
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => InformasiPribadiPage(),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: spacing4),

                    _menuItem(
                      svgIcon: 'assets/icons/notif.svg',
                      text: "Notifikasi",
                      onTap: () {
                        // Get.to(() => NotifikasiPage());
                      },
                    ),
                    SizedBox(height: spacing4),

                    _menuItem(
                      svgIcon: 'assets/icons/info.svg',
                      text: "Tentang Kami",
                      onTap: () {
                        // Get.to(() => TentangKamiPage());
                      },
                    ),
                    SizedBox(height: spacing4),

                    _menuItem(
                      svgIcon: 'assets/icons/check.svg',
                      text: "Kebijakan Privasi",
                      onTap: () {
                        // Get.to(() => KebijakanPrivasiPage());
                      },
                    ),
                    SizedBox(height: spacing4),

                    _menuItem(
                      svgIcon: 'assets/icons/note.svg',
                      text: "Syarat dan Ketentuan",
                      onTap: () {
                        // Get.to(() => SnkPage());
                      },
                    ),
                    SizedBox(height: spacing4),

                    _menuItem(
                      svgIcon: 'assets/icons/faq.svg',
                      text: "FAQ",
                      onTap: () {
                        // Get.to(() => FAQPage());
                      },
                    ),
                    SizedBox(height: spacing4),

                    _menuItem(
                      svgIcon: 'assets/icons/stars.svg',
                      text: "Beri Nilai App Kami",
                      trailing: Text(
                        "Versi 1.20.5",
                        style: xxsMedium,
                      ),
                      onTap: () {
                        // Launch app store or play store
                      },
                    ),
                    SizedBox(height: spacing5),

                    CustomButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                        // UserPreference userPreference = serviceLocator.get<UserPreference>();
                            // userPreference.clearData();
                            // _logoutCubit.logout();
                      },
                      child: Text('Keluar Akun'),
                    ),
                    SizedBox(height: spacing5),

                    // Logout Button
                    // ReuseButton(
                    //   text: "Keluar Akun",
                    //   onPressed: () {
                    //     controller.logout();
                    //     // Logout logic here
                    //   },
                    //   backgroundColor: AppStyles.logout,
                    //   radius: AppStyles.radiusL,
                    // ),
                    SizedBox(height: space050),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _header() {
    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight + 4),
      child: Container(
        decoration: BoxDecoration(
          color:black00,
          boxShadow: [
            BoxShadow(
              color: black950.withOpacity(0.08),
              blurRadius: 8,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            "Profil",
            style: xlBold,
          ),
          centerTitle: true,
        ),
      ),
    );
  }

  Widget _menuItem({
    required String svgIcon,
    required String text,
    Widget? trailing,
    required VoidCallback onTap,
  }) {
    return CustomCard(
      onTap: onTap,
      color: navy200.withOpacity(0.6),
      borderRadius: BorderRadius.circular(borderRadius300),
      padding: EdgeInsets.symmetric(
        horizontal: paddingM,
        vertical: paddingM,
      ),
      child: ClipRRect(
        child: Row(
          children: [
            SvgPicture.asset(
              svgIcon,
              height: 24,
              colorFilter: const ColorFilter.mode(
                black950,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(width: spacing4),
            Expanded(
              child: Text(
                text,
                style: smSemiBold,
              ),
            ),
            if (trailing != null) ...[
              trailing,
              SizedBox(width: space050),
            ],
            Icon(
              Icons.chevron_right,
              color: black800,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }

}