import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shantika_cubit/features/profile/cubit/notification/notification_state.dart';
import 'package:shantika_cubit/ui/color.dart';
import 'package:shantika_cubit/ui/dimension.dart';
import 'package:shantika_cubit/ui/typography.dart';

import 'cubit/notification/notification_cubit.dart';

class NotifikasiPage extends StatelessWidget {
  const NotifikasiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationCubit(),
      child: const NotifikasiPageView(),
    );
  }
}

class NotifikasiPageView extends StatelessWidget {
  const NotifikasiPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black00,
      appBar: _header(context),
      body: Stack(
        children: [
          _content(context),
        ],
      ),
    );
  }

  PreferredSizeWidget _header(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight + 4),
      child: Container(
        decoration: BoxDecoration(
          color: black00,
          boxShadow: [
            BoxShadow(
              color: black950,
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: black950),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            "Notifikasi",
            style: xlMedium,
          ),
        ),
      ),
    );
  }

  Widget _content(BuildContext context) {
    return BlocBuilder<NotificationCubit, NotificationState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.all(padding16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: iconS),
              _notificationSection(
                context: context,
                title: "Aktivitas",
                description:
                "Pastikan akunmu aman dengan memantau aktivitas login, register hingga notifikasi OTP.",
                value: state.isAktivitasEnabled,
                onChanged: (value) =>
                    context.read<NotificationCubit>().toggleAktivitas(value),
              ),
              SizedBox(height:iconS),
              _notificationSection(
                context: context,
                title: "Spesial Untukmu",
                description:
                "Kesempatan mendapat diskon terbatas, penawaran, tips, dan info fitur terbaru.",
                value: state.isSpesialEnabled,
                onChanged: (value) =>
                    context.read<NotificationCubit>().toggleSpesial(value),
              ),
              SizedBox(height: iconS),
              _notificationSection(
                context: context,
                title: "Pengingat",
                description:
                "Dapatkan berita dan info perjalanan penting, pengingat pembayaran, booking, dan lainnya.",
                value: state.isPengingatEnabled,
                onChanged: (value) =>
                    context.read<NotificationCubit>().togglePengingat(value),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _notificationSection({
    required BuildContext context,
    required String title,
    required String description,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: smMedium,
        ),
        SizedBox(height: spacing4),
        Text(
          description,
          style: smMedium,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Push notification",
              style: smMedium,
            ),
            Transform.scale(
              scale: 0.7,
              child: Switch(
                value: value,
                onChanged: onChanged,
                activeColor: black00,
                activeTrackColor: primaryColor,
                inactiveThumbColor: black00,
                inactiveTrackColor: black700_70,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ],
        ),
      ],
    );
  }
}