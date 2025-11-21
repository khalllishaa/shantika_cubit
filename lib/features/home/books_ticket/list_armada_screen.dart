import 'package:flutter/material.dart' hide Route;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:shantika_cubit/features/home/books_ticket/pilh_kursi_screen.dart';
import 'package:shantika_cubit/model/routes_available_model.dart';
import '../../../ui/color.dart';
import '../../../ui/dimension.dart';
import '../../../ui/typography.dart';
import '../../../ui/shared_widget/custom_card_container.dart';

class ListArmadaScreen extends StatefulWidget {
  final List<Route> routes;
  final DateTime selectedDate;
  final String departureCity;
  final String destinationAgency;

  const ListArmadaScreen({
    super.key,
    required this.routes,
    required this.selectedDate,
    required this.departureCity,
    required this.destinationAgency,
  });

  @override
  State<ListArmadaScreen> createState() => _ListArmadaScreenState();
}

class _ListArmadaScreenState extends State<ListArmadaScreen> {
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
              child: widget.routes.isEmpty
                  ? _emptyState()
                  : ListView.separated(
                padding: EdgeInsets.all(paddingL),
                itemCount: widget.routes.length,
                separatorBuilder: (_, __) => SizedBox(height: spacing4),
                itemBuilder: (context, index) {
                  return _armadaCard(widget.routes[index]);
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
    final formattedDate = DateFormat('dd MMMM', 'id_ID').format(widget.selectedDate);

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
            padding: EdgeInsets.only(
              left: padding16,
              top: padding16,
              right: padding16,
            ),
            child: Row(
              children: [
                Icon(Icons.location_on_outlined, color: black700_70, size: iconM),
                SizedBox(width: space200),
                Expanded(
                  child: Text(
                    widget.destinationAgency,
                    style: smRegular.copyWith(color: black950),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: paddingL,
              vertical: padding12,
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: padding12,
                    vertical: space200,
                  ),
                  decoration: BoxDecoration(
                    color: black00,
                    border: Border.all(color: black950.withOpacity(0.2)),
                    borderRadius: BorderRadius.circular(borderRadius300),
                  ),
                  child: Text(
                    formattedDate,
                    style: smRegular.copyWith(color: black950),
                  ),
                ),
                SizedBox(width: space300),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: padding12,
                    vertical: space200,
                  ),
                  decoration: BoxDecoration(
                    color: black00,
                    border: Border.all(color: black950.withOpacity(0.2)),
                    borderRadius: BorderRadius.circular(borderRadius300),
                  ),
                  child: Text(
                    '${widget.routes.length} Armada',
                    style: smRegular.copyWith(color: black950),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: space100),
        ],
      ),
    );
  }

  Widget _emptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(paddingXL),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.directions_bus_outlined,
              size: 80,
              color: black700_70,
            ),
            SizedBox(height: spacing5),
            Text(
              'Tidak Ada Armada Tersedia',
              style: lgSemiBold.copyWith(color: black950),
            ),
            SizedBox(height: space200),
            Text(
              'Maaf, tidak ada armada yang tersedia untuk rute dan jadwal yang Anda pilih.',
              style: smRegular.copyWith(color: black700_70),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _armadaCard(Route route) {
    final formattedPrice = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    ).format(route.price);

    return GestureDetector(
      onTap: () {
        _showArmadaBottomSheet(context, route);
      },
      child: CustomCardContainer(
        borderRadius: borderRadius300,
        padding: EdgeInsets.all(padding20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bus Info
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
                              "${route.fleetName} • ${route.fleetClass}",
                              style: smMedium.copyWith(color: black950),
                            ),
                            SizedBox(height: space150),
                            Text(
                              route.routeName,
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
                        "Sisa ${route.chairsAvailable}",
                        style: xxsMedium.copyWith(color: orange600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: spacing6),

            // Departure Time
            Row(
              children: [
                Icon(Icons.schedule, color: black700_70, size: iconM),
                SizedBox(width: space200),
                Text(
                  route.fleetDetailTime,
                  style: xsMedium.copyWith(color: black950),
                ),
              ],
            ),
            SizedBox(height: spacing4),

            // Locations
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
                              route.checkpoints.start.agencyName,
                              style: xsMedium.copyWith(color: black950),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              route.checkpoints.start.cityName,
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
                              route.checkpoints.destination.agencyName,
                              style: xsMedium.copyWith(color: black950),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              route.checkpoints.destination.cityName,
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

            // Price
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

  Future<void> _showArmadaBottomSheet(BuildContext context, Route selectedRoute) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _ArmadaBottomSheetContent(route: selectedRoute),
    );
  }

  Widget _ArmadaBottomSheetContent({required Route route}) {
    return StatefulBuilder(
      builder: (context, setState) {
        String searchQuery = "";

        // Extract all checkpoints from the route
        final List<Map<String, dynamic>> allCheckpoints = [
          {
            "agency": route.checkpoints.start,
            "label": "Keberangkatan",
          },
          {
            "agency": route.checkpoints.destination,
            "label": "Tujuan",
          },
          {
            "agency": route.checkpoints.end,
            "label": "Akhir",
          },
        ];

        List<Map<String, dynamic>> getFilteredCheckpoints() {
          if (searchQuery.isEmpty) {
            return allCheckpoints;
          }
          return allCheckpoints.where((checkpoint) {
            final agency = checkpoint['agency'] as Destination;
            final agencyName = agency.agencyName.toLowerCase();
            final cityName = agency.cityName.toLowerCase();
            final query = searchQuery.toLowerCase();
            return agencyName.contains(query) || cityName.contains(query);
          }).toList();
        }

        final filteredCheckpoints = getFilteredCheckpoints();

        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.7,
            ),
            decoration: BoxDecoration(
              color: black00,
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
                    color: black700_70.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(borderRadius100),
                  ),
                ),
                SizedBox(height: spacing5),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: padding16),
                  child: Text(
                    "Detail Rute - ${route.fleetClass}",
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
                    style: smRegular,
                    decoration: InputDecoration(
                      hintText: "Cari Lokasi",
                      hintStyle: smRegular.copyWith(color: black700_70),
                      prefixIcon: Icon(Icons.search, size: iconM, color: black700_70),
                      filled: true,
                      fillColor: black250,
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

                Flexible(
                  child: filteredCheckpoints.isEmpty
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
                            style: smMedium.copyWith(color: black700_70),
                          ),
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
                    itemCount: filteredCheckpoints.length,
                    separatorBuilder: (_, __) => SizedBox(height: spacing4),
                    itemBuilder: (context, index) {
                      final checkpoint = filteredCheckpoints[index];
                      final agency = checkpoint['agency'] as Destination;
                      final label = checkpoint['label'] as String;

                      return _buildCheckpointItem(
                        context: context,
                        agency: agency,
                        label: label,
                        onTap: () {
                          // Navigate to seat selection
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PilihKursiScreen(
                                // route: route,
                                // selectedDate: widget.selectedDate,
                                // departureAgencyId: route.checkpoints.start.agencyId,
                                // destinationAgencyId: agency.agencyId,
                              ),
                            ),
                          );
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

  Widget _buildCheckpointItem({
    required BuildContext context,
    required Destination agency,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(padding12),
      child: Container(
        padding: EdgeInsets.all(padding16),
        decoration: BoxDecoration(
          color: black250,
          borderRadius: BorderRadius.circular(borderRadius300),
        ),
        child: Row(
          children: [
            Icon(
              Icons.location_on_outlined,
              color: navy400,
              size: iconL,
            ),
            SizedBox(width: spacing4),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: space200,
                          vertical: space100,
                        ),
                        decoration: BoxDecoration(
                          color: navy600.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(borderRadius200),
                        ),
                        child: Text(
                          label,
                          style: xxsRegular.copyWith(color: navy600),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: space150),
                  Text(
                    agency.agencyName,
                    style: smSemiBold.copyWith(color: black950),
                  ),
                  SizedBox(height: space100),
                  Text(
                    agency.cityName,
                    style: xsRegular.copyWith(color: black700_70),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: iconS,
              color: black700_70,
            ),
          ],
        ),
      ),
    );
  }
}