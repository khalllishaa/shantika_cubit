import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../ui/color.dart';
import '../../ui/dimension.dart';
import '../../ui/shared_widget/custom_button.dart';
import '../../ui/shared_widget/custom_card_container.dart';
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
      padding: EdgeInsets.all(paddingXS),
      child: Column(
        children: [
          CustomCardContainer(
            borderRadius: 12,
            padding: EdgeInsets.all(paddingM),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(12),
                  child: SvgPicture.asset(
                    'assets/icons/bus.svg',
                    width: 32,
                    height: 32,
                  ),
                ),
                SizedBox(width: spacing6),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pesananData["title"]?.split("•")[0].trim() ?? "Bus 10",
                        style: smMedium,
                      ),
                      SizedBox(height: space150),
                      Text(
                        "Executive",
                        style: xsRegular,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: navy300,
                    borderRadius: BorderRadius.circular(borderRadius200),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/car_seat.svg',
                        width: 14,
                        height: 14,
                      ),
                      SizedBox(width: space050),
                      Text(
                        "${pesananData["jumlah_penumpang"] ?? 2} Penumpang",
                        style: xxsMedium.copyWith(color: navy400),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spacing3),

          // Informasi Perjalanan
          CustomCardContainer(
            borderRadius: borderRadius300,
            padding: EdgeInsets.all(paddingM),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Informasi Perjalanan",
                    style: smSemiBold),
                SizedBox(height: spacing5),
                _infoRow(Icons.location_pin, "Agen Keberangkatan",
                    pesananData["from"] ?? "Krapyak - Semarang",
                    pesananData["depart_time"] ?? "07:30", black700_70),
                SizedBox(height: spacing5),
                _infoRow(Icons.location_pin, "Agen Tujuan",
                    pesananData["to"] ?? "Gejayan - Sleman",
                    pesananData["arrive_time"] ?? "15:30", black700_70),
                SizedBox(height: spacing5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.calendar_today_outlined, color: black600, size: iconS),
                        SizedBox(width: spacing4),
                        Text("Tanggal Keberangkatan", style: xsRegular),
                      ],
                    ),
                    SizedBox(height: space100),
                    Text(
                      "${pesananData["date"] ?? "12 Mei 2025"} ${pesananData["depart_time"] ?? "07:30"}",
                      style: smMedium,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: spacing3),
          if (isSudahReview) ...[
            _reviewCard(),
            SizedBox(height: spacing4),
          ],

          // Informasi Pembayaran
          CustomCardContainer(
            borderRadius: borderRadius300,
            padding: EdgeInsets.all(paddingM),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Informasi Pembayaran",
                    style: smMedium),
                SizedBox(height: spacing5),
                _paymentRow(Icons.confirmation_num, "Total Harga Tiket",
                    "Rp${pesananData["price"] ?? "400.000"}"),
                SizedBox(height: spacing5),
                _paymentRow(Icons.person, "ID Membership",
                    pesananData["id_membership"] ?? "SHNTK00127"),
                SizedBox(height: spacing5),
                _paymentRow(Icons.discount, "Potongan Membership 5%",
                    "Rp${pesananData["potongan"] ?? "20.000"}"),
                SizedBox(height: spacing5),
                _paymentRow(Icons.wallet, "Metode Pembayaran",
                    pesananData["metode_pembayaran"] ?? "Pembayaran Instant"),
                SizedBox(height: spacing5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info, color: black600),
                        SizedBox(width: space100),
                        Text("Status", style: smMedium),
                      ],
                    ),
                    SizedBox(height: space100),
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
          ),
        ],
      ),
    );
  }

  Widget _infoRow(
      IconData icon, String label, String title, String time, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: iconM),
            SizedBox(width: space100),
            Text(label, style: xsRegular),
            Text(label, style: xsRegular),
          ],
        ),
        SizedBox(height: space100),
        Text("$title • $time",
            style: smMedium),
      ],
    );
  }

  Widget _paymentRow(IconData icon, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: black700_70, size: iconM),
            SizedBox(width: space100),
            Text(label, style: xsRegular.copyWith(color: black700_70)),
          ],
        ),
        SizedBox(height: space100),
        Text(value,
            style: smMedium),
      ],
    );
  }

  Widget _reviewCard() {
    return CustomCardContainer(
      borderRadius: 12,
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
    );
  }

  Widget _bottomSection() {
    final status = pesananData["status"]?.toLowerCase() ?? "";
    final bool showButton = status != "sudah review";

    return Container(
      padding: EdgeInsets.all(padding16),
      decoration: BoxDecoration(
        color: black00,
        boxShadow: [
          BoxShadow(
            color: black950.withOpacity(0.08),
            blurRadius: 8,
            offset: Offset(0, -3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total Pembayaran", style: xsRegular),
              Text("Rp${pesananData["price"] ?? "400.000"}",
                  style: mdSemiBold),
            ],
          ),
          if (showButton) ...[
            SizedBox(height: spacing4),
            SizedBox(
              height: iconXL, // tinggi button
              width: double.infinity, // biar button full width
              child: CustomButton(
                child: Text("Lihat Tiket"),
                onPressed: () {
                  // aksi button
                },
              ),
            ),
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
        return "Sudah Direview";
      default:
        return "Lunas";
    }
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case "lunas":
        return green400;
      case "sudah ditukarkan":
        return secondaryColor;
      case "sudah review":
        return secondaryColor;
      default:
        return secondaryColor_60;
    }
  }
}
