import 'package:flutter/material.dart' hide Route;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:shantika_cubit/features/home/books_ticket/cubit/detail_pesanan_screen.dart';
import 'package:shantika_cubit/features/home/books_ticket/cubit/pesan_tiket_cubit.dart';
import 'package:shantika_cubit/features/home/books_ticket/cubit/pesan_tiket_state.dart';
import 'package:shantika_cubit/model/routes_available_model.dart';
import 'package:shantika_cubit/model/seat_layout_model.dart';
import 'package:shantika_cubit/ui/shared_widget/custom_button.dart';
import 'package:shantika_cubit/ui/typography.dart';
import '../../../ui/color.dart';
import '../../../ui/dimension.dart';

class PilihKursiScreen extends StatefulWidget {
  final Route route;
  final DateTime selectedDate;
  final int departureAgencyId;
  final int destinationAgencyId;
  final int timeClassificationId;

  const PilihKursiScreen({
    Key? key,
    required this.route,
    required this.selectedDate,
    required this.departureAgencyId,
    required this.destinationAgencyId,
    required this.timeClassificationId,
  }) : super(key: key);

  @override
  State<PilihKursiScreen> createState() => _PilihKursiScreenState();
}

class _PilihKursiScreenState extends State<PilihKursiScreen> {
  bool isLantaiBawah = true;
  bool showDetail = false;
  final Set<int> selectedSeats = {};

  final String svgAvailable = 'assets/icons/regular_avai_grey.svg';
  final String svgSelected = 'assets/icons/regular_available.svg';
  final String svgUnavailable = 'assets/icons/regular_filled.svg';
  final String svgVipUnavailable = 'assets/icons/vip_filled.svg';
  final String svgVipSelected = 'assets/icons/vip_available.svg';
  final String svgVipAvailable = 'assets/icons/vip_avai_grey.svg';

  @override
  void initState() {
    super.initState();
    _loadSeatLayout();
  }

  Future<void> _loadSeatLayout() async {
    final dateString = DateFormat('yyyy-MM-dd').format(widget.selectedDate);

    await context.read<PesanTiketCubit>().getSeatLayout(
      fleetRouteId: widget.route.id,
      timeClassificationId: widget.timeClassificationId,
      date: dateString,
      departureAgencyId: widget.departureAgencyId,
      destinationAgencyId: widget.destinationAgencyId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PesanTiketCubit, PesanTiketState>(
      builder: (context, state) {
        if (state is SeatLayoutLoading) {
          return Scaffold(
            backgroundColor: black00,
            appBar: _buildAppBar(null),
            body: Center(
              child: CircularProgressIndicator(color: primaryColor),
            ),
          );
        }

        if (state is SeatLayoutError) {
          return Scaffold(
            backgroundColor: black00,
            appBar: _buildAppBar(null),
            body: Center(
              child: Padding(
                padding: EdgeInsets.all(padding20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 64, color: red100),
                    SizedBox(height: spacing5),
                    Text('Gagal Memuat Layout Kursi', style: lgSemiBold, textAlign: TextAlign.center),
                    SizedBox(height: spacing4),
                    Text(state.message, style: smRegular.copyWith(color: black700_70), textAlign: TextAlign.center),
                    SizedBox(height: spacing6),
                    CustomButton(
                      onPressed: _loadSeatLayout,
                      backgroundColor: primaryColor,
                      padding: EdgeInsets.symmetric(horizontal: padding20, vertical: padding12),
                      child: Text('Coba Lagi'),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        if (state is SeatLayoutLoaded) {
          final currentLayout = isLantaiBawah ? state.layoutBawah : state.layoutAtas;

          if (currentLayout.chairs.isEmpty && currentLayout.upperChairs.isEmpty) {
            return Scaffold(
              backgroundColor: black00,
              appBar: _buildAppBar(state),
              body: Center(
                child: Text('Tidak ada data kursi tersedia', style: smRegular),
              ),
            );
          }

          final hasUpperDeck = currentLayout.upperRow > 0 && currentLayout.upperCol > 0;

          return Scaffold(
            backgroundColor: black00,
            appBar: _buildAppBar(state, showToggle: hasUpperDeck),
            body: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(spacing4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLegend(currentLayout),
                        SizedBox(height: spacing4),
                        _buildSeatCard(currentLayout),
                      ],
                    ),
                  ),
                ),
                _buildPriceDetail(currentLayout),
                _buildPesanButton(),
              ],
            ),
          );
        }

        return Scaffold(
          backgroundColor: black00,
          body: Center(child: Text('Memuat...')),
        );
      },
    );
  }

  AppBar _buildAppBar(SeatLayoutLoaded? state, {bool showToggle = false}) {
    return AppBar(
      backgroundColor: black00,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: black950),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text('Pilih Kursi', style: xlMedium),
      actions: showToggle && state != null
          ? [
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
            constraints: BoxConstraints(minHeight: 32, minWidth: 70),
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
      ]
          : null,
    );
  }

  Widget _buildLegend(SeatLayoutData layout) {
    final chairs = isLantaiBawah ? layout.chairs : (layout.upperChairs as List<Chair>);

    final uniquePrices = chairs
        .where((c) => !c.isSpace && !c.isDoor && !c.isToilet)
        .map((c) => c.price)
        .toSet()
        .toList()
      ..sort();

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
              ...uniquePrices.map((price) {
                final isVip = uniquePrices.length > 1 && price == uniquePrices.last;
                return Padding(
                  padding: EdgeInsets.only(right: spacing4),
                  child: _legendItem(
                    isVip ? svgVipAvailable : svgAvailable,
                    '${isVip ? "VIP" : "Regular"}\nRp${_formatCurrency(price)}',
                  ),
                );
              }).toList(),
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

  Widget _buildSeatCard(SeatLayoutData layout) {
    return Container(
      padding: EdgeInsets.all(spacing4),
      decoration: BoxDecoration(
        color: black00,
        borderRadius: BorderRadius.circular(borderRadius400),
        boxShadow: [
          BoxShadow(
            color: black950.withOpacity(0.04),
            blurRadius: 8,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              if (layout.doorIndexes.isNotEmpty)
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
          _buildSeatLayout(layout),
          SizedBox(height: spacing4),
          Row(
            children: [
              if (layout.doorIndexes.isNotEmpty)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: paddingXS, vertical: padding16),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(borderRadius150),
                  ),
                  child: Text('Pintu', style: xxsMedium.copyWith(color: black00)),
                ),
              if (layout.toiletIndexes.isNotEmpty) ...[
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
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSeatLayout(SeatLayoutData layout) {
    final chairs = isLantaiBawah ? layout.chairs : (layout.upperChairs as List<Chair>);
    final row = isLantaiBawah ? layout.row : layout.upperRow;
    final col = isLantaiBawah ? layout.col : layout.upperCol;

    if (chairs.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(padding20),
          child: Text('Tidak ada kursi tersedia', style: smRegular),
        ),
      );
    }

    List<Widget> rows = [];

    for (int r = 0; r < row; r++) {
      List<Widget> rowSeats = [];

      for (int c = 0; c < col; c++) {
        final index = (r * col) + c;
        final chair = chairs.firstWhere(
              (ch) => ch.index == index,
          orElse: () => Chair(
            id: -1,
            name: '',
            index: index,
            deletedAt: null,
            seatType: 'DEFAULT',
            position: isLantaiBawah ? 'LOWER' : 'UPPER',
            isBlocked: false,
            isBlockedOnlyAgency: false,
            isBooking: false,
            isUnavailableCustomer: false,
            isUnavailable: true,
            isUnavailableNotPaidCustomer: false,
            isUnavailableWaitingCustomer: false,
            isMine: false,
            price: 0,
            isSpace: true,
            isDoor: false,
            isToilet: false,
            layout: layout.chairs.isNotEmpty ? layout.chairs.first.layout : Layout(
              id: 0,
              name: '',
              row: 0,
              col: 0,
              spaceIndexes: [],
              toiletIndexes: [],
              doorIndexes: [],
              note: '',
              deletedAt: null,
              code: '',
              type: '',
              upperCol: 0,
              upperRow: 0,
              upperSpaceIndexes: [],
              upperToiletIndexes: [],
              upperDoorIndexes: [],
              totalIndexes: 0,
              totalChairs: 0,
              totalUpperIndexes: 0,
              totalUpperChairs: 0,
              totalLowerChairs: 0,
            ),
          ),
        );

        if (chair.isSpace || chair.isDoor || chair.isToilet) {
          rowSeats.add(SizedBox(width: 50, height: 50));
        } else {
          rowSeats.add(_seatTile(chair, layout));
        }

        if (c < col - 1) {
          rowSeats.add(SizedBox(width: spacing3));
        }
      }

      rows.add(
        Padding(
          padding: EdgeInsets.symmetric(vertical: padding6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: rowSeats,
          ),
        ),
      );
    }

    return Column(children: rows);
  }

  Widget _seatTile(Chair chair, SeatLayoutData layout) {
    final isSelected = selectedSeats.contains(chair.index);
    final isUnavailable = chair.isBlocked || chair.isBooking || chair.isUnavailable || chair.isUnavailableCustomer;

    // Determine VIP
    final chairs = isLantaiBawah ? layout.chairs : (layout.upperChairs as List<Chair>);
    final allPrices = chairs
        .where((c) => !c.isSpace && !c.isDoor && !c.isToilet)
        .map((c) => c.price)
        .toSet()
        .toList()
      ..sort();
    final isVip = allPrices.length > 1 && chair.price == allPrices.last;

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
      svg = isUnavailable ? svgVipUnavailable : isSelected ? svgVipSelected : svgVipAvailable;
    } else {
      svg = isUnavailable ? svgUnavailable : isSelected ? svgSelected : svgAvailable;
    }

    return GestureDetector(
      onTap: () {
        if (isUnavailable) return;
        setState(() {
          isSelected ? selectedSeats.remove(chair.index) : selectedSeats.add(chair.index);
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
            chair.name.isNotEmpty ? chair.name : '${chair.index + 1}',
            style: xxsMedium.copyWith(color: isUnavailable ? black400 : black950),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceDetail(SeatLayoutData layout) {
    final chairs = isLantaiBawah ? layout.chairs : (layout.upperChairs as List<Chair>);

    int totalPrice = 0;
    Map<int, int> priceBreakdown = {};

    for (int seatIndex in selectedSeats) {
      final chair = chairs.firstWhere((c) => c.index == seatIndex, orElse: () => chairs.first);
      totalPrice += chair.price;
      priceBreakdown[chair.price] = (priceBreakdown[chair.price] ?? 0) + 1;
    }

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
          BoxShadow(color: black950.withOpacity(0.01), blurRadius: 10, offset: Offset(0, -2)),
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
                    Text("Rp${_formatCurrency(totalPrice)}", style: mdSemiBold.copyWith(color: primaryColor)),
                    SizedBox(width: space150),
                    Icon(showDetail ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, color: black950),
                  ],
                )
              ],
            ),
          ),
          if (showDetail && selectedSeats.isNotEmpty) ...[
            SizedBox(height: spacing4),
            ...priceBreakdown.entries.map((entry) {
              final price = entry.key;
              final count = entry.value;
              return Padding(
                padding: EdgeInsets.only(bottom: space250),
                child: _priceRow("${count}x Kursi @ Rp${_formatCurrency(price)}", count * price),
              );
            }).toList(),
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
        Text("Rp${_formatCurrency(price)}", style: isTotal ? smSemiBold.copyWith(color: primaryColor) : smRegular),
      ],
    );
  }

  Widget _buildPesanButton() {
    return Container(
      padding: EdgeInsets.all(spacing4),
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
        child: Text('Pesan', style: mdMedium.copyWith(color: black00)),
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
          Center(child: Text("Data Pemesanan", style: lgSemiBold)),
          SizedBox(height: space1200),
          Text("Nama Lengkap", style: smMedium),
          SizedBox(height: space150),
          TextField(
            controller: namaCtrl,
            decoration: InputDecoration(
              hintText: "Masukkan nama",
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(borderRadius300)),
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
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(borderRadius300)),
            ),
          ),
          SizedBox(height: spacing5),
          Text("Email", style: smMedium),
          SizedBox(height: space150),
          TextField(
            controller: emailCtrl,
            decoration: InputDecoration(
              hintText: "email@email.com",
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(borderRadius300)),
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
                MaterialPageRoute(builder: (context) => DetailPesananScreen(pesananData: {})),
              );
            },
            child: Text('Pesan', style: mdSemiBold.copyWith(color: black00)),
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