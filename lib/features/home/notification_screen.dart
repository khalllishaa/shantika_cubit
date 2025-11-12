import 'package:flutter/material.dart';
import 'package:shantika_cubit/features/home/cubit/notifications_cubit.dart';
import 'package:shantika_cubit/ui/color.dart';
import 'package:shantika_cubit/ui/dimension.dart';
import 'package:shantika_cubit/ui/typography.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shantika_cubit/repository/notification_repository.dart';
import 'package:shantika_cubit/config/service_locator.dart';
import 'package:shantika_cubit/ui/color.dart';
import 'package:shantika_cubit/ui/dimension.dart';
import 'package:shantika_cubit/ui/typography.dart';
import 'package:shantika_cubit/utility/resource/data_state.dart';
import 'package:shantika_cubit/model/notification_model.dart';

class NoticationsPage extends StatelessWidget {
  const NoticationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final notificationRepo = serviceLocator<NotificationRepository>();

    return BlocProvider(
      create: (context) => NotificationListCubit(notificationRepo)..getNotifications(page: 1),
      child: const _NotificationPageView(),
    );
  }
}

class _NotificationPageView extends StatelessWidget {
  const _NotificationPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: black00,
        appBar: _header(context),
        body: TabBarView(
          children: [
            _NotificationList(isUnreadTab: false),
            _NotificationList(isUnreadTab: true),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _header(BuildContext context) {
    return AppBar(
      leadingWidth: spacing10,
      backgroundColor: black00,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_rounded, size: iconL, color: black950),
        color: black950,
        onPressed: () => Navigator.pop(context),
      ),
      title: Text("Notifikasi", style: xlMedium),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(spacing10),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: padding16),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey, width: 0.3)),
          ),
          child: TabBar(
            labelColor: navy400,
            unselectedLabelColor: black700_70,
            indicatorColor: navy400,
            indicatorWeight: 2,
            labelStyle: smMedium,
            unselectedLabelStyle: smMedium.copyWith(color: navy400),
            tabs: const [
              Tab(text: 'Semua'),
              Tab(text: 'Belum Dibaca'),
            ],
          ),
        ),
      ),
    );
  }
}

class _NotificationList extends StatelessWidget {
  final bool isUnreadTab;
  const _NotificationList({super.key, required this.isUnreadTab});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationListCubit, DataState<NotificationModel>>(
      builder: (context, state) {
        if (state is DataStateLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is DataStateError) {
          return Center(child: Text('Gagal memuat notifikasi'));
        }

        if (state is DataStateSuccess<NotificationModel>) {
          final allNotifs = state.data?.notifications ?? [];
          final notifications = isUnreadTab
              ? allNotifs.where((n) => !n.isSeen).toList()
              : allNotifs;

          if (notifications.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/img_no_notif.png',
                    height: 300,
                  ),
                  SizedBox(height: spacing4),
                  Text(
                    'Tidak ada notifikasi',
                    style: smMedium.copyWith(color: black750),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notif = notifications[index];
              return NotificationItem(
                icon: notif.isSeen
                    ? Icons.notifications_none
                    : Icons.notifications_active,
                title: notif.title,
                subtitle: notif.message,
                time: _formatTime(notif.createdAt),
              );
            },
          );
        }

        return const SizedBox();
      },
    );
  }

  String _formatTime(DateTime dateTime) {
    return "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
  }
}

class NotificationItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String time;

  const NotificationItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: black700_70, width: 0.6),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: navy400, size: 26),
          SizedBox(width: spacing4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: smMedium),
                SizedBox(height: spacing4),
                Text(subtitle, style: smMedium.copyWith(color: black700_70)),
              ],
            ),
          ),
          Text(time, style: smMedium),
        ],
      ),
    );
  }
}
