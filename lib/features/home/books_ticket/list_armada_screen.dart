import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:shantika_cubit/features/home/books_ticket/pilh_kursi_screen.dart';
import '../../../ui/color.dart';
import '../../../ui/dimension.dart';
import '../../../ui/typography.dart';
import '../../../ui/shared_widget/custom_card_container.dart';

class ListArmadaScreen extends StatefulWidget {
  const ListArmadaScreen({super.key});

  @override
  State<ListArmadaScreen> createState() => _ListArmadaScreenState();
}

class _ListArmadaScreenState extends State<ListArmadaScreen> {
  String selectedDate = "17 Januari";
  String selectedTime = "Pagi 08:00 WIB";
  String selectedClass = "Super Exe";

  final List<Map<String, dynamic>> armadaList = [
    {
      "bus_number": "Bus 10",
      "class": "Executive",
      "route": "Cikarang - Bekasi - Klari - Cibitung - Sumaracon",
      "departure": "Cileunyi Didin",
      "departure_city": "Bandung",
      "arrival": "Batangan",
      "arrival_city": "Pati",
      "price": 230000,
      "seats_available": 4,
    },
    {
      "bus_number": "Bus 10",
      "class": "Executive",
      "route": "Cikarang - Bekasi - Klari - Cibitung - Sumaracon",
      "departure": "Cileunyi Didin",
      "departure_city": "Bandung",
      "arrival": "Batangan",
      "arrival_city": "Pati",
      "price": 230000,
      "seats_available": 4,
    },
    {
      "bus_number": "Bus 10",
      "class": "Executive",
      "route": "Cikarang - Bekasi - Klari - Cibitung - Sumaracon",
      "departure": "Cileunyi Didin",
      "departure_city": "Bandung",
      "arrival": "Batangan",
      "arrival_city": "Pati",
      "price": 230000,
      "seats_available": 4,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black00,
      appBar: _header(context),
      body: SafeArea(
        child: Column(
          children: [
            _routeHeader(),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.all(paddingL),
                itemCount: armadaList.length,
                separatorBuilder: (_, __) => SizedBox(height: spacing4),
                itemBuilder: (context, index) {
                  return _armadaCard(armadaList[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _header(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
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
            onPressed: () => Navigator.pop(context),
          ),
          title: Text("List Armada", style: xlMedium),
        ),
      ),
    );
  }

  Widget _routeHeader() {
    return Container(
      decoration: BoxDecoration(
        color: black00,
        border: Border(
          bottom: BorderSide(
            color: black950.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: padding16, top: padding16, right: padding16),
            child:Row(
              children: [
                Icon(Icons.location_on_outlined, color: black700_70, size: iconM),
                SizedBox(width: space200),
                Text(
                  "Amsaliti - Jepara",
                  style: smRegular.copyWith(color: black950),
                ),
              ],
            ),
          ),
          _filterChips(),
          SizedBox(height: space100),
        ],
      ),
    );
  }

  Widget _filterChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(
        horizontal: paddingL,
        vertical: padding12,
      ),
      child: Row(
        children: [
          _filterChip(
            label: selectedDate,
            icon: Icons.keyboard_arrow_down,
          ),
          SizedBox(width: space300),
          _filterChip(
            label: selectedTime,
            icon: Icons.keyboard_arrow_down,
          ),
          SizedBox(width: space300),
          _filterChip(
            label: selectedClass,
            icon: null,
          ),
        ],
      ),
    );
  }

  Widget _filterChip({
    required String label,
    IconData? icon,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: padding12,
        vertical: space200,
      ),
      decoration: BoxDecoration(
        color: black00,
        border: Border.all(color: black950.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(borderRadius300),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: smRegular.copyWith(color: black950),
          ),
          if (icon != null) ...[
            SizedBox(width: space100),
            Icon(icon, size: iconS, color: black950),
          ],
        ],
      ),
    );
  }

  Widget _armadaCard(Map<String, dynamic> armada) {
    final formattedPrice = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    ).format(armada['price']);

    return GestureDetector(
      onTap: () {
        _showArmadaBottomSheet(context);
      },
      child: CustomCardContainer(
        borderRadius: borderRadius300,
        padding: EdgeInsets.all(padding20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/icons/bus.svg'),
                      SizedBox(width: space300),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${armada['bus_number']} . ${armada['class']}",
                              style: smMedium.copyWith(color: black950),
                            ),
                            SizedBox(height: space150),
                            Text(
                              armada['route'],
                              style: xxsRegular.copyWith(color: black400),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: space300),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: space300,
                    vertical: space150,
                  ),
                  decoration: BoxDecoration(
                    color: orange500,
                    borderRadius: BorderRadius.circular(borderRadius200),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PilihKursiScreen(),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/car_seat.svg',
                          colorFilter: ColorFilter.mode(
                            orange600,
                            BlendMode.srcIn,
                          ),
                        ),
                        SizedBox(width: space100),
                        Text(
                          "Sisa ${armada['seats_available']}",
                          style: xxsMedium.copyWith(color: orange600),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spacing6),

            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: navy400,
                        size: iconL,
                      ),
                      SizedBox(width: space200),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              armada['departure'],
                              style: xsMedium.copyWith(color: black950),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              armada['departure_city'],
                              style: xxsRegular.copyWith(color: black400),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: space300),
                Expanded(
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: black700_70,
                        size: iconL,
                      ),
                      SizedBox(width: space200),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              armada['arrival'],
                              style: xsMedium.copyWith(color: black950),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              armada['arrival_city'],
                              style: xxsRegular.copyWith(color: black400),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: spacing6),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Mulai Dari",
                  style: smRegular.copyWith(color: black400),
                ),
                Expanded(
                  child: Text(
                    formattedPrice,
                    style: mdSemiBold.copyWith(color: navy400),
                    textAlign: TextAlign.right,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<Map<String, dynamic>?> _showArmadaBottomSheet(BuildContext context) {
    return showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _ArmadaBottomSheetContent(),
    );
  }

  Widget _ArmadaBottomSheetContent() {
    return StatefulBuilder(
      builder: (context, setState) {
        String searchQuery = "";
        int? selectedIndex;

        final List<Map<String, dynamic>> armadaSchedules = [
          {
            "city": "Semarang",
            "terminal": "Krapyak",
            "time": "05:30",
          },
          {
            "city": "Semarang",
            "terminal": "Ungaran",
            "time": "05:30",
          },
          {
            "city": "Semarang",
            "terminal": "Terminal Bawen",
            "time": "05:30",
          },
          {
            "city": "Magelang",
            "terminal": "Muntilan",
            "time": "05:30",
          },
          {
            "city": "Magelang",
            "terminal": "Terminal Magelang",
            "time": "05:30",
          },
        ];

        List<Map<String, dynamic>> getFilteredSchedules() {
          if (searchQuery.isEmpty) {
            return armadaSchedules;
          }
          return armadaSchedules.where((schedule) {
            final terminal = schedule['terminal'].toString().toLowerCase();
            final city = schedule['city'].toString().toLowerCase();
            final query = searchQuery.toLowerCase();
            return terminal.contains(query) || city.contains(query);
          }).toList();
        }

        final filteredSchedules = getFilteredSchedules();

        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.8,
            ),
            decoration: BoxDecoration(
              color:black00,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(borderRadius500),
                topRight: Radius.circular(borderRadius500),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Handle bar
                Container(
                  margin: EdgeInsets.only(top: padding12),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: black00,
                    borderRadius: BorderRadius.circular(borderRadius100),
                  ),
                ),
                SizedBox(height: spacing5),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: padding16),
                  child: Text(
                    "Pilih Armada",
                    style: mdMedium,
                  ),
                ),
                SizedBox(height: spacing5),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: padding16),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "Cari Armada",
                      hintStyle: smRegular.copyWith(color: black700_70),
                      prefixIcon: Icon(Icons.search, size: iconM),
                      filled: true,
                      fillColor: black00,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(borderRadius300),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: padding16,
                        vertical: padding12,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: spacing5),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: padding16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Super Executive",
                      style: smRegular,
                    ),
                  ),
                ),
                SizedBox(height: spacing4),

                Flexible(
                  child: filteredSchedules.isEmpty
                      ? Center(
                    child: Padding(
                      padding: EdgeInsets.all(paddingXL),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 48,
                            color: black700_70,
                          ),
                          SizedBox(height: padding12),
                          Text(
                            'Tidak ada hasil untuk "$searchQuery"',
                            style: smMedium),
                        ],
                      ),
                    ),
                  )
                      : ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(
                      left: padding16,
                      right: padding16,
                      bottom: padding20,
                    ),
                    itemCount: filteredSchedules.length,
                    separatorBuilder: (_, __) => SizedBox(height: spacing4),
                    itemBuilder: (context, index) {
                      final schedule = filteredSchedules[index];
                      final originalIndex = armadaSchedules.indexOf(schedule);
                      final isSelected = selectedIndex == originalIndex;

                      return _buildScheduleItem(
                        context: context,
                        schedule: schedule,
                        isSelected: isSelected,
                        onTap: () {
                          setState(() {
                            selectedIndex = originalIndex;
                          });

                          Navigator.pop(context, schedule);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildScheduleItem({
    required BuildContext context,
    required Map<String, dynamic> schedule,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(padding12),
      child: Container(
        padding: EdgeInsets.all(padding16),
        decoration: BoxDecoration(
          color: isSelected ? black250 : black250,
          border: Border.all(
            color: isSelected ? black300 : black00!,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(borderRadius300),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.check_circle : Icons.location_on_outlined,
              color: isSelected ? black00 : black700_70,
              size: iconL,
            ),
            SizedBox(width: spacing4),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    schedule['terminal'],
                    style: smRegular,
                  ),
                  SizedBox(height: space100),
                  Text(
                    schedule['city'],
                    style: smSemiBold,
                  ),
                ],
              ),
            ),

            Text(
              schedule['time'],
              style: smRegular,
            ),
          ],
        ),
      ),
    );
  }
}