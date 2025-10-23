import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shantika_cubit/utility/extensions/date_time_extensions.dart';
import 'package:shantika_cubit/utility/extensions/show_toast.dart';
import 'package:shantika_cubit/utility/extensions/widget_extensions.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:with_space_between/with_space_between.dart';

import '../../config/constant.dart';
import '../../model/user_model.dart';
import '../../ui/color.dart';
import '../../ui/dimension.dart';
import '../../ui/shared_widget/circle_image_view.dart';
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
              SizedBox(height: space050),

              // Profile Picture
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/img_profil_default.jpg'),
                backgroundColor: black500,
              ),
              SizedBox(height: space050),

              // Name
              Text(
                "Anastasya Carolina",
                style: xlSemiBold,
              ),
              SizedBox(height: space050),

              // Phone Number
              Text(
                "087374543899",
                style: xlSemiBold,
              ),
              SizedBox(height: space050),

              // Menu Items
              Padding(
                padding: EdgeInsets.symmetric(horizontal: padding16),
                child: Column(
                  children: [
                    _menuItem(
                      svgIcon: 'assets/images/ic_calendar.svg',
                      text: "Informasi Pribadi",
                      onTap: () {
                        // Get.to(() => InformasiPribadiPage());
                      },
                    ),
                    SizedBox(height: space050),

                    _menuItem(
                      svgIcon: 'assets/images/ic_calendar.svg',
                      text: "Notifikasi",
                      onTap: () {
                        // Get.to(() => NotifikasiPage());
                      },
                    ),
                    SizedBox(height: space050),

                    _menuItem(
                      svgIcon: 'assets/images/ic_calendar.svg',
                      text: "Tentang Kami",
                      onTap: () {
                        // Get.to(() => TentangKamiPage());
                      },
                    ),
                    SizedBox(height: space050),

                    _menuItem(
                      svgIcon: 'assets/images/ic_calendar.svg',
                      text: "Kebijakan Privasi",
                      onTap: () {
                        // Get.to(() => KebijakanPrivasiPage());
                      },
                    ),
                    SizedBox(height: space050),

                    _menuItem(
                      svgIcon: 'assets/images/ic_calendar.svg',
                      text: "Syarat dan Ketentuan",
                      onTap: () {
                        // Get.to(() => SnkPage());
                      },
                    ),
                    SizedBox(height: space050),

                    _menuItem(
                      svgIcon: 'assets/images/ic_calendar.svg',
                      text: "FAQ",
                      onTap: () {
                        // Get.to(() => FAQPage());
                      },
                    ),
                    SizedBox(height: space050),

                    _menuItem(
                      svgIcon: 'assets/images/ic_calendar.svg',
                      text: "Beri Nilai App Kami",
                      trailing: Text(
                        "Versi 1.20.5",
                        style: xlSemiBold,
                      ),
                      onTap: () {
                        // Launch app store or play store
                      },
                    ),
                    SizedBox(height: space050),

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
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "Profil",
            style: xlSemiBold,
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
      borderRadius: BorderRadius.circular(borderRadius050),
      color: black50,
      padding: EdgeInsets.symmetric(
        horizontal: paddingXL,
        vertical: paddingXL,
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            svgIcon,
            width: 24,
            height: 24,
            colorFilter: const ColorFilter.mode(
              Colors.black,
              BlendMode.srcIn,
            ),
          ),
          SizedBox(width: space050), // ⬅️ ini height diganti width
          Expanded(
            child: Text(
              text,
              style: xlSemiBold,
            ),
          ),
          if (trailing != null) ...[
            trailing,
            SizedBox(width: space050),
          ],
          Icon(
            Icons.chevron_right,
            color: black500,
            size: 24,
          ),
        ],
      ),
    );
  }

}