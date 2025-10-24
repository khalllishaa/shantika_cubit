import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shantika_cubit/features/profile/informasi_pribadi_screen.dart';
import 'package:shantika_cubit/utility/extensions/show_toast.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../config/constant.dart';
import '../../config/service_locator.dart';
import '../../config/user_preference.dart';
import '../../ui/color.dart';
import '../../ui/dimension.dart';
import '../../ui/shared_widget/circle_image_view.dart';
import '../../ui/shared_widget/custom_button.dart';
import '../../ui/shared_widget/custom_card.dart';
import '../../ui/typography.dart';
import '../../utility/loading_overlay.dart';
import '../authentication/login/login_screen.dart';
import 'cubit/profile_cubit.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final loadingOverlay = LoadingOverlay();

  @override
  Widget build(BuildContext context) {
    final profileCubit = context.read<ProfileCubit>();
    profileCubit.init();
    profileCubit.profile();

    return Scaffold(
      backgroundColor: black00,
      appBar: _header(),
      body: SafeArea(
        child: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is ProfileStateLoading) {
              loadingOverlay.show(context);
            } else {
              loadingOverlay.hide();
            }

            if (state is ProfileStateError) {
              context.showCustomToast(
                position: SnackBarPosition.top,
                title: "Error",
                message: state.message,
                isSuccess: false,
              );
            }
          },
          builder: (context, state) {
            // ✅ Default value jika data belum ada
            String name = "User";
            String phone = "-";
            String? avatarUrl;

            // ✅ Update data jika berhasil load
            if (state is ProfileStateSuccess) {
              name = state.user.name ?? "User";
              phone = state.user.phone ?? "-";
              avatarUrl = state.user.avatarUrl;
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: spacing4),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: avatarUrl != null && avatarUrl.isNotEmpty
                        ? NetworkImage(avatarUrl)
                        : AssetImage('assets/images/img_profil_default.jpg')
                    as ImageProvider,
                    backgroundColor: black500,
                  ),
                  SizedBox(height: spacing5),
                  Text(name, style: mdBold),
                  SizedBox(height: space150),
                  Text(phone, style: smMedium.copyWith(color: black400)),
                  SizedBox(height: spacing7),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: padding20),
                    child: Column(
                      children: [
                        _menuItem(
                          svgIcon: 'assets/icons/profile_outline.svg',
                          text: "Informasi Pribadi",
                          onTap: () {
                            Navigator.push(
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
                          onTap: () {},
                        ),
                        SizedBox(height: spacing4),
                        _menuItem(
                          svgIcon: 'assets/icons/info.svg',
                          text: "Tentang Kami",
                          onTap: () {},
                        ),
                        SizedBox(height: spacing4),
                        _menuItem(
                          svgIcon: 'assets/icons/check.svg',
                          text: "Kebijakan Privasi",
                          onTap: () {},
                        ),
                        SizedBox(height: spacing4),
                        _menuItem(
                          svgIcon: 'assets/icons/note.svg',
                          text: "Syarat dan Ketentuan",
                          onTap: () {},
                        ),
                        SizedBox(height: spacing4),
                        _menuItem(
                          svgIcon: 'assets/icons/faq.svg',
                          text: "FAQ",
                          onTap: () {},
                        ),
                        SizedBox(height: spacing4),
                        _menuItem(
                          svgIcon: 'assets/icons/stars.svg',
                          text: "Beri Nilai App Kami",
                          trailing: Text("Versi 1.20.5", style: xxsMedium),
                          onTap: () {},
                        ),
                        SizedBox(height: spacing5),
                        CustomButton(
                          onPressed: () => _showLogoutDialog(context),
                          child: Text('Keluar Akun'),
                        ),
                        SizedBox(height: spacing5),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  PreferredSizeWidget _header() {
    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight + 4),
      child: Container(
        decoration: BoxDecoration(
          color: black00,
          boxShadow: [
            BoxShadow(
              color: black950.withOpacity(0.09),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: AppBar(
          backgroundColor: Colors.transparent,
          title: Text("Profil", style: xlBold),
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
      color: navy200,
      borderRadius: BorderRadius.circular(borderRadius300),
      padding: EdgeInsets.symmetric(
        horizontal: paddingM,
        vertical: paddingM,
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            svgIcon,
            height: iconL,
            colorFilter: ColorFilter.mode(
              black950,
              BlendMode.srcIn,
            ),
          ),
          SizedBox(width: spacing4),
          Expanded(
            child: Text(text, style: smSemiBold),
          ),
          if (trailing != null) ...[
            trailing,
            SizedBox(width: space050),
          ],
          Icon(Icons.arrow_forward_ios_rounded, color: black800, size: iconL),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    // ✅ Get nama user dari Cubit state
    final state = context.read<ProfileCubit>().state;
    String userName = "User";

    if (state is ProfileStateSuccess) {
      userName = state.user.name ?? "User";
    }

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(padding20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Icon(Icons.logout, color: Colors.red, size: 28),
                ),
                SizedBox(height: 16),
                Text(
                  "Keluar Akun",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Yakin Anda akan keluar dari akun $userName?",
                  style: TextStyle(color: Colors.grey[700], fontSize: 14),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.black26),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text("Batal",
                            style: TextStyle(color: Colors.black)),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          Navigator.pop(context);

                          final userPreference =
                          serviceLocator.get<UserPreference>();
                          await userPreference.clearData();

                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                                (route) => false,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text("Keluar",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}