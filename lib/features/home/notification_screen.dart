import 'package:flutter/material.dart';
import 'package:shantika_cubit/ui/color.dart';
import 'package:shantika_cubit/ui/dimension.dart';
import 'package:shantika_cubit/ui/typography.dart';

class NoticationsPage extends StatelessWidget {
  const NoticationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: black00,
        appBar: _header(context),
        body: TabBarView(
          children: [
            NotificationList(),
            NotificationList(),
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
      title: Text(
        "Notifikasi",
        style: xlMedium,
      ),
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
            tabs: [
              Tab(text: 'Semua 16'),
              Tab(text: 'Belum Dibaca 7'),
            ],
          ),
        ),
      ),
    );
  }
}

class NotificationList extends StatelessWidget {
  const NotificationList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: paddingS, vertical: padding12),
            child: Column(
              children: [
                _buildDateSection('8 Februari 2024'),
                NotificationItem(
                  icon: Icons.airplane_ticket_outlined,
                  title: 'Promo Tiket Murah Mudik 2025',
                  subtitle:
                  'Yuk segera amankan tiket mudik mu sekarang juga sebelum kehabisan...',
                  time: '10:00',
                ),
                NotificationItem(
                  icon: Icons.check_circle_outline,
                  title: 'Tiket anda sudah dibayar lunas',
                  subtitle:
                  'Terimakasih sudah membeli tiket di new shantika nikmati perjalanannya.',
                  time: '10:00',
                ),
                NotificationItem(
                  icon: Icons.airplane_ticket_outlined,
                  title: 'Segera Bayar Tiket yang sudah anda pesan',
                  subtitle:
                  'Bayar tiket anda dan nikmati perjalanan bus new shantika',
                  time: '10:00',
                ),
                _buildDateSection('8 Februari 2024'),
                NotificationItem(
                  icon: Icons.money,
                  title: 'Segera Bayar Tiket yang sudah anda pesan',
                  subtitle:
                  'Bayar tiket anda dan nikmati perjalanan bus new shantika',
                  time: '10:00',
                ),
              ],
            ),
        ),
      ],
    );
  }

  Widget _buildDateSection(String date) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding16, vertical: padding12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(date, style: smMedium),
          Text('Baca Semua', style: smMedium.copyWith(color: navy400)),
        ],
      ),
    );
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
