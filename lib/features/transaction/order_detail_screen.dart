import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../ui/color.dart';
import '../../ui/dimension.dart';
import '../../ui/shared_widget/custom_button.dart';
import '../../ui/typography.dart';

class DetailPesananScreen extends StatelessWidget {
  final Map<String, dynamic> pesananData;

  const DetailPesananScreen({super.key, required this.pesananData});

  @override
  Widget build(BuildContext context) {
    bool isSudahReview = pesananData["status"]?.toLowerCase() == "sudah review";

    return Scaffold(
      backgroundColor: black00,
      appBar: _header(context),
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: isSudahReview ? 80 : 120),
              child: _detailContent(),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _bottomSection(),
          ),
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
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: black600),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            "Detail Pesanan",
            style: xlMedium,
          ),
        ),
      ),
    );
  }

  Widget _detailContent() {
    bool isSudahReview = pesananData["status"]?.toLowerCase() == "sudah review";

    return Padding(
      padding: EdgeInsets.all(paddingL),
      child: Column(
        children: [
          // Informasi Bus
          Card(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 2,
            child: Padding(
              padding: EdgeInsets.all(paddingM),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(12),
                    child: SvgPicture.asset(
                      'images/icons/bus.svg',
                      width: 32,
                      height: 32,
                      colorFilter: ColorFilter.mode(
                        primaryColor700,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  SizedBox(width: space600),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          pesananData["title"]?.split("•")[0].trim() ?? "Bus 10",
                          style: xlMedium.copyWith(fontSize: 18),
                        ),
                        Text(
                          pesananData["title"]?.split("•").length > 1
                              ? pesananData["title"].split("•")[1].trim()
                              : "Executive",
                          style: xlMedium.copyWith(fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: primaryColor700.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          'images/icons/car_seat.svg',
                          width: 14,
                          height: 14,
                          colorFilter: ColorFilter.mode(
                            primaryColor700,
                            BlendMode.srcIn,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "${pesananData["jumlah_penumpang"] ?? 2} Penumpang",
                          style: smMedium.copyWith(
                            color: primaryColor700,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: spacing4),

          // Informasi Perjalanan
          Card(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 2,
            child: Padding(
              padding: EdgeInsets.all(paddingM),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Informasi Perjalanan",
                      style: xlMedium.copyWith(fontSize: 16)),
                  SizedBox(height: spacing4),
                  _infoRow(Icons.location_on, "Agen Keberangkatan",
                      pesananData["from"] ?? "Krapyak - Semarang",
                      pesananData["depart_time"] ?? "07:30", black700_70),
                  SizedBox(height: spacing4),
                  _infoRow(Icons.flag, "Agen Tujuan",
                      pesananData["to"] ?? "Gejayan - Sleman",
                      pesananData["arrive_time"] ?? "15:30",
                      primaryColor700),
                  SizedBox(height: spacing4),
                  Row(
                    children: [
                      Icon(Icons.calendar_month, color: black600),
                      SizedBox(height: spacing4),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Tanggal Keberangkatan",
                              style: smMedium),
                          Text(
                            "${pesananData["date"] ?? "12 Mei 2025"} ${pesananData["depart_time"] ?? "07:30"}",
                            style: smMedium.copyWith(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: spacing4),

          if (isSudahReview) ...[
            _reviewCard(),
            SizedBox(height: spacing4),
          ],

          // Informasi Pembayaran
          Card(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 2,
            child: Padding(
              padding: EdgeInsets.all(paddingM),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Informasi Pembayaran",
                      style: xlMedium.copyWith(fontSize: 16)),
                  SizedBox(height: spacing4),
                  _paymentRow(Icons.confirmation_num, "Total Harga Tiket",
                      "Rp${pesananData["price"] ?? "400.000"}"),
                  SizedBox(height: spacing4),
                  _paymentRow(Icons.person, "ID Membership",
                      pesananData["id_membership"] ?? "SHNTK00127"),
                  SizedBox(height: spacing4),
                  _paymentRow(Icons.discount, "Potongan Membership 5%",
                      "Rp${pesananData["potongan"] ?? "20.000"}"),
                  SizedBox(height: spacing4),
                  _paymentRow(Icons.wallet, "Metode Pembayaran",
                      pesananData["metode_pembayaran"] ?? "Pembayaran Instant"),
                  SizedBox(height: spacing4),
                  Row(
                    children: [
                      Icon(Icons.info, color: black600),
                      SizedBox(height: spacing4),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Status", style: smMedium),
                          Text(
                            _getStatusText(pesananData["status"]),
                            style: smMedium.copyWith(
                              fontWeight: FontWeight.w600,
                              color: _getStatusColor(pesananData["status"]),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(
      IconData icon, String label, String title, String time, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 20),
        SizedBox(height: spacing4),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: smMedium),
              Text("$title • $time",
                  style: smMedium.copyWith(fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _paymentRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: black600, size: 20),
        SizedBox(height: spacing4),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: smMedium),
              Text(value,
                  style: smMedium.copyWith(fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _reviewCard() {
    return Card(
      shape:
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(paddingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Review", style: xlMedium.copyWith(fontSize: 16)),
            SizedBox(height: spacing4),
            Row(
              children: List.generate(5, (index) {
                return Icon(Icons.star, color: primaryColor700, size: 20);
              }),
            ),
            SizedBox(height: spacing4),
            Text(
              pesananData["review_text"] ??
                  "Perjalanan sangat nyaman, supir ramah, AC dingin!",
              style: smMedium.copyWith(fontSize: 13, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bottomSection() {
    bool isSudahReview = pesananData["status"]?.toLowerCase() == "sudah review";

    return Container(
      padding: EdgeInsets.all(paddingL),
      decoration: BoxDecoration(
        color: black00,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: Offset(0, -3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total Pembayaran", style: smMedium),
              Text("Rp${pesananData["price"] ?? "400.000"}",
                  style: xlMedium.copyWith(fontSize: 18)),
            ],
          ),
          if (!isSudahReview) ...[
            SizedBox(height: spacing4),
            // ReuseButton(
            //   text: "Lihat Tiket",
            //   height: 50,
            //   fontSize: 16,
            //   radius: 12,
            //   backgroundColor: AppStyles.primary,
            //   textColor: AppStyles.light,
            //   onPressed: () {},
            // ),
            CustomButton(
              onPressed: () {},
              child: Text('Lihat Tiket'),
            )
          ],
        ],
      ),
    );
  }

  String _getStatusText(String? status) {
    switch (status?.toLowerCase()) {
      case "lunas":
        return "Lunas";
      case "sudah ditukarkan":
        return "Sudah Ditukarkan";
      case "sudah review":
        return "Sudah Review";
      default:
        return "Lunas";
    }
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case "lunas":
        return primaryColor700;
      case "sudah ditukarkan":
        return primaryColor;
      case "sudah review":
        return secondaryColor;
      default:
        return secondaryColor_60;
    }
  }
}
