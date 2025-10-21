import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? appVersion;

  late LogoutCubit _logoutCubit;

  late ProfileCubit _profileCubit;

  LoadingOverlay _overlay = LoadingOverlay();

  @override
  void initState() {
    getVersionInfo().then((e) {
      setState(() {
        appVersion = e;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _logoutCubit = context.read();
    _logoutCubit.init();

    _profileCubit = context.read();
    _profileCubit.init();
    _profileCubit.profile();

    return Theme(
      data: Theme.of(context).copyWith(
        dividerTheme: const DividerThemeData(
          color: Colors.transparent,
        ),
      ),
      child: Scaffold(
        backgroundColor: bgLight,
        body: BlocListener<LogoutCubit, LogoutState>(
          listener: (context, state) {
            if (state is LogoutStateSuccess) {
              _overlay.hide();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                  (route) => false);
            } else if (state is LogoutStateError) {
              _overlay.hide();
              context.showCustomToast(
                title: "Oopss",
                message: state.message,
                isSuccess: false,
              );
            } else {
              _overlay.show(context);
            }
          },
          child: RefreshIndicator(
            onRefresh: () async {
              await _profileCubit.profile();
            },
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: space400, vertical: space800),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // _buildProfileView(),
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     BlocBuilder<ProfileCubit, ProfileState>(
                      //       builder: (context, state) {
                      //         UserModel? user = state is ProfileStateSuccess ? state.user : null;
                      //         return ReuseMenuProfile(
                      //           icon: "assets/images/ic_profile.svg",
                      //           title: "Profile Saya",
                      //           onTap: () {
                      //             Navigator.push(
                      //               context,
                      //               MaterialPageRoute(
                      //                 builder: (context) => MyProfileScreen(user: user ?? UserModel()),
                      //               ),
                      //             );
                      //           },
                      //         );
                      //       },
                      //     ),
                      //     ReuseMenuProfile(
                      //         icon: "assets/images/ic_notification.svg",
                      //         title: "Notifikasi",
                      //         onTap: () {
                      //           Navigator.push(
                      //             context,
                      //             MaterialPageRoute(
                      //               builder: (context) => NotificationScreen(),
                      //             ),
                      //           );
                      //         }),
                      //     ReuseMenuProfile(
                      //         icon: "assets/images/ic_note.svg",
                      //         title: "Artikel Informasi",
                      //         onTap: () {
                      //           Navigator.push(
                      //             context,
                      //             MaterialPageRoute(
                      //               builder: (context) => const ArticleScreen(),
                      //             ),
                      //           );
                      //         }),
                      //     ReuseMenuProfile(
                      //         icon: "assets/images/ic_discount.svg",
                      //         title: "Diskon & Voucher",
                      //         onTap: () {
                      //           Navigator.push(
                      //             context,
                      //             MaterialPageRoute(
                      //               builder: (context) => PromoScreen(),
                      //             ),
                      //           );
                      //         }),
                      //     // ReuseMenuProfile(
                      //     //     icon: "assets/images/ic_verify.svg",
                      //     //     title: "Syarat & Ketentuan",
                      //     //     onTap: () {
                      //     //       Navigator.push(
                      //     //         context,
                      //     //         MaterialPageRoute(
                      //     //           builder: (context) => TermsConditionsScreen(),
                      //     //         ),
                      //     //       );
                      //     //     }),
                      //     // ReuseMenuProfile(
                      //     //     icon: "assets/images/ic_shield.svg",
                      //     //     title: "Kebijakan Privasi",
                      //     //     onTap: () {
                      //     //       Navigator.push(
                      //     //         context,
                      //     //         MaterialPageRoute(
                      //     //           builder: (context) => PrivacyPolicyScreen(),
                      //     //         ),
                      //     //       );
                      //     //     }),
                      //     // ReuseMenuProfile(
                      //     //     icon: "assets/images/ic_message.svg",
                      //     //     title: "FAQ",
                      //     //     onTap: () {
                      //     //       Navigator.push(
                      //     //         context,
                      //     //         MaterialPageRoute(
                      //     //           builder: (context) => FaqScreen(),
                      //     //         ),
                      //     //       );
                      //     //     }),
                      //   ].withSpaceBetween(height: space300),
                      // ),
                      // SizedBox(height: space400),
                      // ReuseMenuProfile(
                      //   icon: "assets/images/ic_logout.svg",
                      //   title: "Logout",
                      //   isLogout: true,
                      //   onTap: () {
                      //     // UserPreference userPreference = serviceLocator.get<UserPreference>();
                      //     // userPreference.clearData();
                      //     _logoutCubit.logout();
                      //   },
                      // ),
                      // ReuseMenuProfile(
                      //   icon: "assets/images/ic_trash.svg",
                      //   title: "Hapus Akun",
                      //   isLogout: true,
                      //   onTap: () {
                      //     launchUrl(Uri.parse('${deleteAccountUrl}'), mode: LaunchMode.externalApplication);
                      //   },
                      // )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        // persistentFooterButtons: [
        //   Align(
        //     alignment: Alignment.center,
        //     child: Text(
        //       'V${appVersion}',
        //       style: mdMedium.copyWith(color: textDarkTertiary),
        //     ),
        //   ),
        // ],
      ),
    );
  }

  BlocBuilder<ProfileCubit, ProfileState> _buildProfileView() {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileStateSuccess) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 80,
                width: 80,
                child: CircleImageView(
                  url: '${baseImage}/${state.user.avatar}',
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.user.name ?? "-",
                      style: mSemiBold.copyWith(color: textDarkPrimary),
                    ),
                    Text(
                      "Bergabung sejak ${state.user.createdAt?.convert(format: "yyyy") ?? "-"}",
                      style: smRegular.copyWith(color: textDarkSecondary),
                    ),
                  ].withSpaceBetween(height: space100),
                ),
              )
            ].withSpaceBetween(width: space300),
          );
        } else if (state is ProfileStateError) {
          return ErrorView(title: "Terjadi Kesalahan", desc: state.message);
        } else {
          return _buildProfileSectionLoadingView();
        }
      },
    );
  }

  Row _buildProfileSectionLoadingView() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius400),
          child: SizedBox(
            height: 80,
            width: 80,
            child: CircleImageView(url: 'https://avatar.iran.liara.run/public').addShimmer(block: true),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "John Doe",
                style: mSemiBold.copyWith(color: textDarkPrimary),
              ).addShimmer(block: true),
              Text(
                "Bergabung sejak 2021",
                style: smRegular.copyWith(color: textDarkSecondary),
              ).addShimmer(block: true),
            ].withSpaceBetween(height: space100),
          ),
        )
      ].withSpaceBetween(width: space300),
    );
  }

  Future<String> getVersionInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    return version;
  }
}
