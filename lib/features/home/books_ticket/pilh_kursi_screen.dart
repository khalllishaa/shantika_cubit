import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shantika_cubit/features/home/books_ticket/cubit/detail_pesanan_screen.dart';
import 'package:shantika_cubit/ui/shared_widget/custom_button.dart';
import 'package:shantika_cubit/ui/typography.dart';
import '../../../ui/color.dart';
import '../../../ui/dimension.dart';

class PilihKursiScreen extends StatefulWidget {
  const PilihKursiScreen({Key? key}) : super(key: key);

  @override
  State<PilihKursiScreen> createState() => _PilihKursiScreenState();
}

class _PilihKursiScreenState extends State<PilihKursiScreen> {
  bool isLantaiBawah = true;
  bool showDetail = false;

  final Set<int> selectedSeats = {};

  final Map<int, String> seatStatusBawah = {
    7: 'booked',
    23: 'booked',
    24: 'booked',
    41: 'booked',
  };

  final Map<int, String> seatStatusAtas = {
    5: 'booked',
    12: 'booked',
  };

  final int totalBawah = 28;
  final int totalAtas = 14;

  final String svgAvailable = 'assets/icons/regular_avai_grey.svg';
  final String svgSelected = 'assets/icons/regular_available.svg';
  final String svgUnavailable = 'assets/icons/regular_filled.svg';
  final String svgVipUnavailable = 'assets/icons/vip_filled.svg';
  final String svgVipSelected = 'assets/icons/vip_available.svg';
  final String svgVipAvailable = 'assets/icons/vip_avai_grey.svg';

  @override
  Widget build(BuildContext context) {
    final currentStatus = isLantaiBawah ? seatStatusBawah : seatStatusAtas;

    final int vipCount = selectedSeats.where((s) {
      return isLantaiBawah
          ? s >= (totalBawah - 7)
          : s >= (totalAtas + 29 - 7);
    }).length;

    final int regularCount = selectedSeats.length - vipCount;

    final int totalPrice = (vipCount * 205000) + (regularCount * 125000);

    return Scaffold(
      backgroundColor: black00,
      appBar: AppBar(
        backgroundColor: black00,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: black950),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Pilih Kursi', style: xlMedium),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: spacing4),
            child: ToggleButtons(
              isSelected: [!isLantaiBawah, isLantaiBawah],
              onPressed: (index) {
                setState(() {
                  isLantaiBawah = index == 1;
                  selectedSeats.clear();
                  showDetail = false;
                });
              },
              borderColor: black950,
              selectedBorderColor: black950,
              borderRadius: BorderRadius.circular(borderRadius200),
              fillColor: primaryColor,
              selectedColor: black00,
              constraints: BoxConstraints(
                minHeight: 32,
                minWidth: 70,
              ),
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: padding12, vertical: paddingXS),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/arrow_line_up.svg',
                        width: iconS,
                        colorFilter: ColorFilter.mode(!isLantaiBawah ? black00 : black950, BlendMode.srcIn),
                      ),
                      SizedBox(width: space100),
                      Text('Atas', style: xsMedium),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: padding12, vertical: paddingXS),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/arrow_line_down.svg',
                        width: iconS,
                        colorFilter: ColorFilter.mode(isLantaiBawah ? black00 : black950, BlendMode.srcIn),
                      ),
                      SizedBox(width: space100),
                      Text('Bawah', style: xsMedium),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spacing4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLegend(),
                  SizedBox(height: spacing4),
                  _buildSeatCard(currentStatus),
                ],
              ),
            ),
          ),
          _buildPriceDetail(totalPrice, vipCount, regularCount),
          Container(
            padding: EdgeInsets.all(spacing4),
            color: black00,
            child: CustomButton(
              width: double.infinity,
              borderRadius: borderRadius300,
              backgroundColor: selectedSeats.isEmpty ? black700_70 : primaryColor,
              disabledColor: black700_70,
              onPressed: selectedSeats.isEmpty
                  ? null
                  : () {
                _showPemesananSheet(context);
              },
              padding: EdgeInsets.symmetric(vertical: padding16),
              child: Text(
                'Pesan',
                style: mdMedium.copyWith(color: black00),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showPemesananSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.65,
          maxChildSize: 0.9,
          minChildSize: 0.4,
          builder: (_, controller) {
            return _buildPemesananForm(controller);
          },
        );
      },
    );
  }
  Widget _buildPemesananForm(ScrollController controller) {
    final TextEditingController namaCtrl = TextEditingController();
    final TextEditingController telpCtrl = TextEditingController();
    final TextEditingController emailCtrl = TextEditingController();

    return Container(
      padding: EdgeInsets.all(padding20),
      decoration: BoxDecoration(
        color: black00,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadius500),
          topRight: Radius.circular(borderRadius500),
        ),
      ),
      child: ListView(
        controller: controller,
        children: [
          SizedBox(height: space200),
          Center(
            child: Container(
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                color: black400,
                borderRadius: BorderRadius.circular(borderRadius300),
              ),
            ),
          ),
          SizedBox(height: spacing4),
          Center(
            child: Text("Data Pemesanan", style: lgSemiBold),
          ),
          SizedBox(height: space1200),
          Text("Nama Lengkap", style: smMedium),
          SizedBox(height: space150),
          TextField(
            controller: namaCtrl,
            decoration: InputDecoration(
              hintText: "Masukkan nama",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius300),
              ),
            ),
          ),

          SizedBox(height: spacing5),
          Text("Nomor Telepon", style: smMedium),
          SizedBox(height: space150),
          TextField(
            controller: telpCtrl,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: "+628xxxx",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius300),
              ),
            ),
          ),

          SizedBox(height: spacing5),
          Text("Email", style: smMedium),
          SizedBox(height: space150),
          TextField(
            controller: emailCtrl,
            decoration: InputDecoration(
              hintText: "email@email.com",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius300),
              ),
            ),
          ),
          SizedBox(height: spacing9),

          CustomButton(
            width: double.infinity,
            borderRadius: borderRadius500,
            backgroundColor: primaryColor,
            padding: EdgeInsets.symmetric(vertical: padding16),
            onPressed: () {
              Navigator.pop(context);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPesananScreen(pesananData: {},
                  ),
                ),
              );
            },
            child: Text(
              'Pesan',
              style: mdSemiBold.copyWith(color: black00),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceDetail(int totalPrice, int vipCount, int regularCount) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      padding: EdgeInsets.symmetric(horizontal: spacing4, vertical: spacing4),
      decoration: BoxDecoration(
        color: black00,
        border: Border(
          top: BorderSide(color: black950.withOpacity(0.05), width: 5),
          left: BorderSide(color: black950.withOpacity(0.05), width: 5),
          right: BorderSide(color: black950.withOpacity(0.05), width: 5),
        ),
        boxShadow: [
          BoxShadow(
            color: black950.withOpacity(0.01),
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadius400),
          topRight: Radius.circular(borderRadius400),
        ),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => setState(() => showDetail = !showDetail),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Detail Harga", style: smRegular),
                Row(
                  children: [
                    Text(
                      "Rp${_formatCurrency(totalPrice)}",
                      style: mdSemiBold.copyWith(color: primaryColor),
                    ),
                    SizedBox(width: space150),
                    Icon(
                      showDetail ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                      color: black950,
                    ),
                  ],
                )
              ],
            ),
          ),

          if (showDetail && selectedSeats.isNotEmpty) ...[
            SizedBox(height: spacing4),

            if (vipCount > 0)
              _priceRow("${vipCount}x First Class", vipCount * 30000),
            SizedBox(height: space250),

            if (regularCount > 0)
              _priceRow("${regularCount}x Regular", regularCount * 25000),
            SizedBox(height: space250),

            _priceRow("Total Harga", totalPrice, isTotal: true),
          ]
        ],
      ),
    );
  }

  Widget _priceRow(String label, int price, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: isTotal ? xsRegular : xsRegular),
        Text(
          "Rp${_formatCurrency(price)}",
          style: isTotal
              ? smSemiBold.copyWith(color: primaryColor)
              : smRegular,
        ),
      ],
    );
  }

  Widget _buildLegend() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(width: space300),
              Icon(Icons.info_outline, color: black950, size: iconM),
              SizedBox(width: space200),
              Text('Tipe Kursi', style: smMedium),
            ],
          ),
          SizedBox(height: space250),
          Row(
            children: [
              _legendItem(svgUnavailable, 'Tidak\nTersedia'),
              SizedBox(width: spacing4),
              _legendItem(svgSelected, 'Dipilih'),
              SizedBox(width: spacing4),
              _legendItem(svgAvailable, 'Regular\nRp125.000'),
              SizedBox(width: spacing4),
              _legendItem(svgVipAvailable, 'First Class\nRp205.000'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _legendItem(String svg, String label) {
    final bool isSelectedLegend = svg == svgSelected;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding6, vertical: padding6),
      decoration: BoxDecoration(
        color: black00,
        borderRadius: BorderRadius.circular(borderRadius300),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: isSelectedLegend ? yellow400 : black00,
              borderRadius: BorderRadius.circular(borderRadius150),
            ),
            padding: EdgeInsets.all(padding6),
            child: SvgPicture.asset(svg, fit: BoxFit.contain),
          ),
          SizedBox(width: space150),
          Text(label, style: xxsRegular),
        ],
      ),
    );
  }

  Widget _buildSeatCard(Map<int, String> currentStatus) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spacing4),
      decoration: BoxDecoration(
        color: black00,
        borderRadius: BorderRadius.circular(borderRadius400),
        boxShadow: [BoxShadow(color: black950.withOpacity(0.04), blurRadius: 8, offset: Offset(0, 4))],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: paddingXL, vertical: paddingS),
                decoration: BoxDecoration(
                  color: navy400,
                  borderRadius: BorderRadius.circular(borderRadius150),
                ),
                child: Text('Pintu', style: xsMedium.copyWith(color: black00)),
              ),
              Spacer(),
              SvgPicture.asset('assets/icons/steering.svg', width: iconXL),
            ],
          ),
          SizedBox(height: spacing4),
          isLantaiBawah ? _seatLayoutBawah(currentStatus) : _seatLayoutAtas(currentStatus),
          SizedBox(height: spacing4),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: paddingXS, vertical: padding16),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(borderRadius150),
                ),
                child: Text('Pintu', style: xxsMedium.copyWith(color: black00)),
              ),
              SizedBox(width: spacing4),
              Container(
                padding: EdgeInsets.symmetric(horizontal: paddingXS, vertical: padding16),
                decoration: BoxDecoration(
                  color: yellow400,
                  borderRadius: BorderRadius.circular(borderRadius150),
                ),
                child: Text('Toilet', style: xxsMedium.copyWith(color: black950)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _seatLayoutBawah(Map<int, String> currentStatus) {
    List<Widget> rows = [];
    int seat = 1;

    for (int i = 0; i < 7; i++) {
      List<Widget> row = [];

      for (int j = 0; j < 2; j++) {
        row.add(seat <= totalBawah ? _seatTile(seat, currentStatus) : SizedBox(width: spacing11));
        seat++;
      }

      row.add(SizedBox(width: 18));

      for (int j = 0; j < 2; j++) {
        row.add(seat <= totalBawah ? _seatTile(seat, currentStatus) : SizedBox(width: spacing11));
        seat++;
      }

      rows.add(
        Padding(
          padding: EdgeInsets.symmetric(vertical: padding6),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: row),
        ),
      );
    }

    return Column(children: rows);
  }

  Widget _seatLayoutAtas(Map<int, String> currentStatus) {
    List<Widget> rows = [];
    int seat = 29;

    for (int i = 0; i < 7; i++) {
      List<Widget> row = [];

      row.add(_seatTile(seat, currentStatus));
      seat++;

      row.add(SizedBox(width: spacing6));

      row.add(_seatTile(seat, currentStatus));
      seat++;

      rows.add(
        Padding(
          padding: EdgeInsets.symmetric(vertical: padding6),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: row),
        ),
      );
    }

    return Column(children: rows);
  }

  Widget _seatTile(int seatNumber, Map<int, String> currentStatus) {
    final status = currentStatus[seatNumber] ?? 'available';
    final isSelected = selectedSeats.contains(seatNumber);
    final isUnavailable = status == 'booked';
    final bool isVip = isLantaiBawah
        ? seatNumber >= (totalBawah - 7)
        : seatNumber >= (totalAtas + 29 - 7);
    Color iconBgColor;
    if (isUnavailable) {
      iconBgColor = black450;
    } else if (isSelected) {
      iconBgColor = yellow400;
    } else {
      iconBgColor = black450;
    }
    String svg;
    if (isVip) {
      svg = isUnavailable
          ? svgVipUnavailable
          : isSelected
          ? svgVipSelected
          : svgVipAvailable;
    } else {
      svg = isUnavailable
          ? svgUnavailable
          : isSelected
          ? svgSelected
          : svgAvailable;
    }
    return GestureDetector(
      onTap: () {
        if (isUnavailable) return;
        setState(() {
          isSelected ? selectedSeats.remove(seatNumber) : selectedSeats.add(seatNumber);
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(borderRadius300),
            ),
            padding: EdgeInsets.all(8),
            child: SvgPicture.asset(svg, fit: BoxFit.contain),
          ),
          SizedBox(height: space100),
          Text(
            '$seatNumber',
            style: xxsMedium.copyWith(
              color: isUnavailable ? black400 : black950,
            ),
          ),
        ],
      ),
    );
  }
  String _formatCurrency(int value) {
    final text = value.toString();
    final reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    return text.replaceAllMapped(reg, (m) => '${m[1]}.');
  }
}