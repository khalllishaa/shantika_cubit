import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:path/path.dart';
import 'package:shantika_cubit/features/transaction/payment_webview_screen.dart';
import 'package:shantika_cubit/features/transaction/order_detail_screen.dart';
import 'package:shantika_cubit/utility/extensions/date_time_extensions.dart';
import 'package:shantika_cubit/utility/extensions/int_extension.dart';
import 'package:with_space_between/with_space_between.dart';

import '../../config/constant.dart';
import '../../model/transaction_model.dart';
import '../../ui/color.dart';
import '../../ui/dimension.dart';
import '../../ui/shared_widget/custom_appbar.dart';
import '../../ui/shared_widget/custom_button.dart';
import '../../ui/shared_widget/custom_card_container.dart';
import '../../ui/shared_widget/empty_state_view.dart';
import '../../ui/shared_widget/error_view.dart';
import '../../ui/typography.dart';
import 'cubit/history_transaction_cubit.dart';

// ignore: must_be_immutable
class PesananScreen extends StatelessWidget {
  PesananScreen({super.key});

  late HistoryTransactionCubit _historyTransactionCubit;

  @override
  // Widget build(BuildContext context) {
  //   _historyTransactionCubit = context.read();
  //   _historyTransactionCubit.init();
  //   _historyTransactionCubit.historyTransaction();
  //
  //   return DefaultTabController(
  //     length: 3,
  //     child: Scaffold(
  //       appBar: CustomAppBar(
  //         leading: false,
  //         title: "Transaksi",
  //         img: 'assets/images/ic_transaction_nav.svg',
  //       ),
  //       body: Column(
  //         children: [
  //           // _buildTabBar(),
  //           // Expanded(
  //           //   child: TabBarView(
  //           //     children: [
  //           //       _buildActiveInvoice(),
  //           //       _buildSuccessInvoice(),
  //           //       _buildCancelledInvoice(),
  //           //     ],
  //           //   ),
  //           // )
  //         ],
  //             // .withSpaceBetween(height: space300),
  //       ),
  //     ),
  //   );
  // }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black00,
      appBar: _header(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: _riwayats(context),
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
            "Pesanan",
            style: xlMedium,
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: EdgeInsets.only(right: paddingL),
              child: IconButton(
                icon: Icon(
                  Icons.history_outlined,
                  color: black600,
                  size: iconL,
                ),
                onPressed: () {
                  // Navigator.push(context, Ri)
                  // Get.to(() => RiwayatPage());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _riwayats(BuildContext context) {
    // dummy data pesanan
    final List<Map<String, dynamic>> pesanan = [
      {
        "title": "Pesanan 1",
        "status": "Selesai",
        "date": "25 Oktober 2025",
        "from": "Jakarta",
        "depart_time": "08:00",
        "to": "Bandung",
        "arrive_time": "10:30",
        "price": "150.000"
      },
      {
        "title": "Pesanan 2",
        "status": "Proses",
        "date": "26 Oktober 2025",
        "from": "Surabaya",
        "depart_time": "09:15",
        "to": "Malang",
        "arrive_time": "11:00",
        "price": "120.000"
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
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => DetailPesananScreen(
                        pesananData: item,
                      ),
                    ),
                  );
                },
                child: CustomCardContainer(
                  margin: EdgeInsets.symmetric(vertical: space600),
                  padding: EdgeInsets.all(paddingM),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              child: Text(item["status"]),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: space600 / 2),
                      Text(item["date"] ?? "", style: smMedium),
                      SizedBox(height: space600),

                      // from
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.location_pin, color: black700_20),
                          SizedBox(width: spacing4),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${item["from"]}",
                                  style: smMedium.copyWith(fontWeight: FontWeight.w700)),
                              Text("${item["depart_time"]}", style: sMedium),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: space600),

                      // to
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.location_pin, color: primaryColor700),
                          SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${item["to"]}",
                                  style: smRegular.copyWith(fontWeight: FontWeight.w600)),
                              Text("${item["arrive_time"]}", style: smMedium),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: space600),

                      // harga
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Rp ${item["price"]}",
                          style: smMedium.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
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
