import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shantika_cubit/ui/shared_widget/custom_button.dart';
import 'package:shantika_cubit/ui/shared_widget/custom_card_container.dart';

import '../../../../ui/color.dart';
import '../../../../ui/dimension.dart';
import '../../../../ui/typography.dart';

class DetailPesananScreen extends StatefulWidget {
  final Map<String, dynamic> pesananData;

  const DetailPesananScreen({super.key, required this.pesananData});

  @override
  State<DetailPesananScreen> createState() => _DetailPesananScreenState();
}

class _DetailPesananScreenState extends State<DetailPesananScreen> {
  bool isSeatExpanded = false;

  @override
  Widget build(BuildContext context) {
    final pesananData = widget.pesananData;
    bool isSudahReview = pesananData["status"]?.toLowerCase() == "sudah review";

    return Scaffold(
      backgroundColor: black00,
      appBar: _header(context),
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: isSudahReview ? 80 : 120),
              child: _detailContent(context),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _bottomSection(context),
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

  Widget _detailContent(BuildContext context) {
    final pesananData = widget.pesananData;
    bool isSudahReview = pesananData["status"]?.toLowerCase() == "sudah review";

    return Padding(
      padding: EdgeInsets.all(paddingXS),
      child: Column(
        children: [
          CustomCardContainer(
            borderRadius: borderRadius300,
            padding: EdgeInsets.all(paddingM),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(padding12),
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
                  padding: EdgeInsets.symmetric(horizontal: padding12, vertical: padding6),
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

          CustomCardContainer(
            borderRadius: borderRadius300,
            padding: EdgeInsets.all(paddingM),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Informasi Perjalanan", style: smSemiBold),
                SizedBox(height: spacing5),
                _infoRow(
                  Icons.location_pin,
                  "Agen Keberangkatan",
                  pesananData["from"] ?? "Krapyak - Semarang",
                  pesananData["depart_time"] ?? "07:30",
                  black700_70,
                ),
                SizedBox(height: spacing5),
                _infoRow(
                  Icons.location_pin,
                  "Agen Tujuan",
                  pesananData["to"] ?? "Gejayan - Sleman",
                  pesananData["arrive_time"] ?? "15:30",
                  black700_70,
                ),
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
          CustomCardContainer(
            borderRadius: borderRadius300,
            padding: EdgeInsets.all(paddingM),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Data Pemesanan", style: smSemiBold),
                SizedBox(height: spacing5),

                Text('Shin Eunsoo', style: smMedium),
                SizedBox(height: space100),
                Text('+62 888-1918-291', style: xsRegular),
                SizedBox(height: spacing5),

                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    setState(() {
                      isSeatExpanded = !isSeatExpanded;
                    });
                  },
                  child: Row(
                    children: [
                      Text('Jumlah Seat (2)', style: smMedium),
                      Spacer(),
                      Icon(
                        isSeatExpanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: black700_70,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: space100),
                Text('12,23', style: xsRegular),

                if (isSeatExpanded) ...[
                  SizedBox(height: space150),
                  Column(
                    children: [
                      SizedBox(height: space200),
                      Row(
                        children: [
                          Text(
                            "Rp120.000",
                            style: smMedium,
                          ),
                          Spacer(),
                          Text(
                            "x1 Default",
                            style: xsRegular.copyWith(color: black700_70),
                          ),
                        ],
                      ),
                      SizedBox(height: space200),
                      Row(
                        children: [
                          Text(
                            "Rp200.000",
                            style: smMedium,
                          ),
                          Spacer(),
                          Text(
                            "x1 First Class",
                            style: xsRegular.copyWith(color: black700_70),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          SizedBox(height: spacing4),
          CustomCardContainer(
            borderRadius: borderRadius300,
            padding: EdgeInsets.all(paddingM),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Informasi Pembayaran", style: smSemiBold),
                SizedBox(height: spacing5),
                _paymentRow(
                  Icons.confirmation_num,
                  "Total Harga Tiket",
                  "Rp${pesananData["price"] ?? "400.000"}",
                ),
                SizedBox(height: spacing5),
                _paymentRow(
                  Icons.person,
                  "ID Membership",
                  pesananData["id_membership"] ?? "SHNTK00127",
                ),
                SizedBox(height: spacing5),
                _paymentRow(
                  Icons.discount,
                  "Potongan Membership 5%",
                  "Rp${pesananData["potongan"] ?? "20.000"}",
                ),
                SizedBox(height: spacing5),
                _paymentRow(
                  Icons.wallet,
                  "Metode Pembayaran",
                  pesananData["metode_pembayaran"] ?? "Pembayaran Instant",
                  onTap: () => _showPaymentBottomSheet(context),
                ),
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
          SizedBox(height: spacing5),
          CustomCardContainer(
            borderRadius: borderRadius300,
            padding: EdgeInsets.all(paddingM),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Metode Pembayaran", style: smSemiBold),
                SizedBox(height: spacing5),
                Text('Pembayaran Otomatis', style: smMedium),
                SizedBox(height: space100),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => _showChoosePaymentBottomSheet(context),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Lakukan pembayaran dengan berbagai bank hanya dengan klik saja tanpa bukti transfer',
                          style: xsRegular,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward_ios_rounded, size: iconS, color: black700_70),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showChoosePaymentBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: black00,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(padding20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(padding20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: EdgeInsets.only(bottom: padding16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(borderRadius350),
                  ),
                ),
              ),

              Text("Pilih Metode Pembayaran", style: xlMedium),
              SizedBox(height: spacing6),
              _paymentOptionItem(Icons.account_balance, "Bank Transfer"),
              _paymentOptionItem(Icons.qr_code_rounded, "QRIS"),
              _paymentOptionItem(Icons.wallet, "E-Wallet"),
              _paymentOptionItem(Icons.money, "Bayar di Agen"),
            ],
          ),
        );
      },
    );
  }

  Widget _paymentOptionItem(IconData icon, String label) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: padding12),
        child: Row(
          children: [
            Icon(icon, size: iconM, color: black700_70),
            SizedBox(width: spacing4),
            Text(label, style: smMedium),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(
      IconData icon,
      String label,
      String title,
      String time,
      Color color,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: iconM),
            SizedBox(width: space100),
            Text(label, style: xsRegular),
          ],
        ),
        SizedBox(height: space100),
        Text("$title • $time", style: smMedium),
      ],
    );
  }

  Widget _paymentRow(IconData icon, String label, String value, {VoidCallback? onTap}) {
    final row = Column(
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
        Text(value, style: smMedium),
      ],
    );

    if (onTap == null) {
      return row;
    } else {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: row,
      );
    }
  }

  Widget _reviewCard() {
    final pesananData = widget.pesananData;
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
            pesananData["review_text"] ?? "Perjalanan sangat nyaman, supir ramah, AC dingin!",
            style: smMedium.copyWith(fontSize: 13, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _bottomSection(BuildContext context) {
    final pesananData = widget.pesananData;
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
              Text("Rp${pesananData["price"] ?? "400.000"}", style: mdSemiBold),
            ],
          ),
          if (showButton) ...[
            SizedBox(height: spacing4),
            CustomButton(
              backgroundColor: primaryColor,
              padding: EdgeInsets.symmetric(vertical: padding12),
              child: Text("Bayar"),
              onPressed: () {
                _showPaymentBottomSheet(context);
              },
            ),
          ],
        ],
      ),
    );
  }

  void _showPaymentBottomSheet(BuildContext context) {
    final pesananData = widget.pesananData;
    final price = pesananData["price"] ?? "400.000";
    final potongan = pesananData["potongan"] ?? "20.000";

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 12,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Text("Detail Pembayaran", style: xlMedium),
              SizedBox(height: 16),
              _bottomSheetRow("Harga Tiket", "Rp$price"),
              _bottomSheetRow("Potongan Member", "Rp$potongan"),
              _bottomSheetRow("Biaya Layanan", "Rp3.000"),
              Divider(height: 32),
              _bottomSheetRow("Total Akhir", "Rp383.000", bold: true),
              SizedBox(height: 20),
              CustomButton(
                backgroundColor: primaryColor,
                padding: EdgeInsets.symmetric(vertical: 14),
                child: Text("Lanjut Bayar", style: mdSemiBold),
                onPressed: () {
                  // aksi lanjut bayar
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _bottomSheetRow(String title, String value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: bold ? mdSemiBold : xsRegular.copyWith(color: black700_70)),
          Text(value, style: bold ? mdSemiBold : smMedium),
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