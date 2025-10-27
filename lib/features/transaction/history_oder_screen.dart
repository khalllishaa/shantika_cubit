import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:shantika_cubit/features/transaction/order_detail_screen.dart';
import 'package:shantika_cubit/ui/color.dart';
import 'package:shantika_cubit/ui/typography.dart';

import '../../ui/dimension.dart';
import '../../ui/shared_widget/custom_button.dart';
import '../../ui/shared_widget/custom_card_container.dart';

class HistoryOderScreen extends StatelessWidget {
  const HistoryOderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black00,
      appBar: _header(context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: _riwayats(context),
        ),
      ),
    );
  }

  PreferredSizeWidget _header(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight + 4),
      child: Container(
        decoration: BoxDecoration(
          color: black00,
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
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: black950),
            onPressed: () {
              Navigator.pop(context);
            },
            // onPressed: () => Get.back(),
          ),
          title: Text(
            "Riwayat",
            style: xlSemiBold,
          ),
          centerTitle: true,
        ),
      ),
    );
  }

  Widget _riwayats(BuildContext context) {
    final List<Map<String, dynamic>> pesanan = [
      {
        "title": "Bus 10 • Executive Big Top",
        "status": "Lunas",
        "date": "11 Februari 2025  • 20:30",
        "from": "Krapyak - Semarang",
        "to": "Gejayan - Sleman",
        "depart_time": "08:00",
        "arrive_time": "10:30",
        "price": "230.000"
      },
      {
        "title": "Bus 10 • Executive Big Top",
        "status": "Sudah Ditukarkan",
        "date": "11 Februari 2025  • 20:30",
        "from": "Krapyak - Semarang",
        "to": "Gejayan - Sleman",
        "depart_time": "08:00",
        "arrive_time": "10:30",
        "price": "230.000"
      },
      {
        "title": "Bus 10 • Executive Big Top",
        "status": "Sudah Direview",
        "date": "11 Februari 2025  • 20:30",
        "from": "Krapyak - Semarang",
        "to": "Gejayan - Sleman",
        "depart_time": "08:00",
        "arrive_time": "10:30",
        "price": "230.000"
      },
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: space600),
          Column(
            children: pesanan.map((item) {
              Color buttonColor;
              switch (item["status"]) {
                case "Lunas":
                  buttonColor = green400;
                  break;
                case "Sudah Ditukarkan":
                  buttonColor = navy500;
                  break;
                case "Sudah Direview":
                  buttonColor = navy600;
                  break;
                default:
                  buttonColor = black400;
              }

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailPesananScreen(pesananData: item),
                    ),
                  );
                },
                child: CustomCardContainer(
                  borderRadius: borderRadius300,
                  margin: EdgeInsets.symmetric(vertical: paddingS),
                  padding: EdgeInsets.all(padding12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              item["title"] ?? "",
                              style: smMedium,
                            ),
                          ),
                          IntrinsicWidth(
                            child: CustomButton(
                              onPressed: () {},
                              borderRadius: borderRadius750,
                              backgroundColor: buttonColor,
                              padding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              child: Text(
                                item["status"],
                                style: xsMedium.copyWith(color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: space100),
                      Text(
                        item["date"] ?? "",
                        style: xsRegular.copyWith(color: black400),
                      ),
                      SizedBox(height: spacing4),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.location_pin, color: black700_70),
                          SizedBox(width: space200),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${item["from"]}", style: xsMedium),
                              SizedBox(height: space150),
                              Text("05:30", style: xxsRegular),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: spacing4),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.location_pin, color: navy400),
                          SizedBox(width: space200),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${item["to"]}", style: xsMedium),
                              SizedBox(height: space150),
                              Text("09:30", style: xxsRegular),
                            ],
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Rp ${item["price"]}",
                          style: mdSemiBold.copyWith(color: navy400),
                        ),
                      ),
                      SizedBox(height: spacing5),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

}
