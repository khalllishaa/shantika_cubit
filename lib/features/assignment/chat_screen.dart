import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../config/constant.dart';
import '../../ui/color.dart';
import '../../ui/dimension.dart';
import '../../ui/shared_widget/custom_card_container.dart';
import '../../ui/typography.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  final List<Map<String, dynamic>> contacts = [
    {
      "title": "Customer Service",
      "iconPath": "assets/icons/whatsapp.svg",
      "link": "https://wa.me/6281234567890",
    },
    {
      "title": "Driver Support",
      "iconPath": "assets/icons/whatsapp.svg",
      "link": "https://wa.me/6289876543210",
    },
    {
      "title": "Admin",
      "iconPath": "assets/icons/facebook.svg",
      "link": "https://wa.me/6281111111111",
    },
  ];

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    print("Refreshed!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black00,
      appBar: _header(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(paddingL),
          child: RefreshIndicator(
            onRefresh: _onRefresh,
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: contacts.length,
              separatorBuilder: (_, __) => SizedBox(height: space600),
              itemBuilder: (context, index) {
                final item = contacts[index];
                return _chatCard(item);
              },
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _header() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight + 4),
      child: Container(
        decoration: BoxDecoration(
          color: black00,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "Chat",
            style: xlMedium,
          ),
          centerTitle: true,
        ),
      ),
    );
  }

  Widget _chatCard(Map<String, dynamic> item) {
    return GestureDetector(
      onTap: () {
        // dummy: print aja dulu
        print("Opening link: ${item["link"]}");
      },
      child: CustomCardContainer(
        padding: EdgeInsets.symmetric(
          horizontal: paddingL,
          vertical: paddingM,
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(paddingS),
              child: SvgPicture.asset(
                item["iconPath"],
                width: iconL,
                height: iconL,
              ),
            ),
            SizedBox(width: space600),
            Expanded(
              child: Text(
                item["title"],
                style: smMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
