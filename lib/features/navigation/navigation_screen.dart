import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../ui/color.dart';
import '../../ui/typography.dart';
import '../assignment/assignment_screen.dart';
import '../home/home_screen.dart';
import '../profile/profile_screen.dart';
import '../transaction/transaction_screen.dart';
import 'cubit/update_fcm_token_cubit.dart';

// ignore: must_be_immutable
class NavigationScreen extends StatefulWidget {
  NavigationScreen({super.key, this.goToHistoryTransaction = false});

  final bool? goToHistoryTransaction;

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _initialIndex = 0;
  late UpdateFcmTokenCubit _updateFcmTokenCubit;

  final List<Widget> screens = [
    HomeScreen(),
    // AllBottomSheet(),
    AssignmentScreen(),
    TransactionScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    _updateFcmTokenCubit = context.read();
    _updateFcmTokenCubit.init();
    _updateFcmTokenCubit.updateFcmToken();

    if (widget.goToHistoryTransaction ?? false) {
      _initialIndex = 2;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_initialIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: bgLight,
        elevation: 1,
        selectedLabelStyle: xxsRegular,
        unselectedLabelStyle: xxsRegular,
        iconSize: 25,
        currentIndex: _initialIndex,
        enableFeedback: false,
        selectedItemColor: textPrimary,
        unselectedItemColor: textDarkSecondary,
        onTap: (index) {
          setState(() {
            _initialIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: 'Beranda',
            icon: SvgPicture.asset(
              'assets/images/ic_home_nav.svg',
              color: _initialIndex == 0 ? iconPrimary : iconDarkSecondary,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Penugasan',
            icon: SvgPicture.asset(
              'assets/images/ic_briefcase_nav.svg',
              color: _initialIndex == 1 ? iconPrimary : iconDarkSecondary,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Transaksi',
            icon: SvgPicture.asset(
              'assets/images/ic_transaction_nav.svg',
              color: _initialIndex == 2 ? iconPrimary : iconDarkSecondary,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: SvgPicture.asset(
              'assets/images/ic_profile.svg',
              color: _initialIndex == 3 ? iconPrimary : iconDarkSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
