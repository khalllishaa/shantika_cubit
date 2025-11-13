import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shantika_cubit/features/books_ticket/cubit/pesan_tiket_cubit.dart';
import 'package:shantika_cubit/features/books_ticket/cubit/pesan_tiket_state.dart';
import 'package:shantika_cubit/model/city_depature_model.dart' as departure;
import 'package:shantika_cubit/model/pesan_tiket_model.dart';
import 'package:shantika_cubit/model/agency_model.dart';
import 'package:shantika_cubit/ui/shared_widget/custom_button.dart';
import '../../ui/color.dart';
import '../../ui/dimension.dart';
import '../../ui/typography.dart';

class PesanTiketScreen extends StatelessWidget {
  const PesanTiketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PesanTiketPage();
  }
}

class PesanTiketPage extends StatefulWidget {
  const PesanTiketPage({super.key});

  @override
  State<PesanTiketPage> createState() => _PesanTiketPageState();
}

class _PesanTiketPageState extends State<PesanTiketPage> {
  @override
  void initState() {
    super.initState();
    context.read<PesanTiketCubit>().loadInitialData();
  }

  Future<void> _pickDate(BuildContext context) async {
    final state = context.read<PesanTiketCubit>().state;
    DateTime initialDate = DateTime.now();

    if (state is PesanTiketLoaded && state.selectedDate != null) {
      initialDate = state.selectedDate!;
    }

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: primaryColor,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      context.read<PesanTiketCubit>().selectDate(pickedDate);
    }
  }

  Future<void> _pickTime(BuildContext context) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: primaryColor,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      final formattedTime = pickedTime.format(context);
      context.read<PesanTiketCubit>().selectTime(formattedTime);
    }
  }

  void _showDepartureCityBottomSheet(BuildContext context) {
    final cubit = context.read<PesanTiketCubit>();
    final state = cubit.state;

    if (state is! PesanTiketLoaded) return;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (modalContext) => _DepartureCityBottomSheet(
        title: "Pilih Kota Keberangkatan",
        items: state.departureCities,
        selectedItem: state.selectedDepartureCity,
        onItemSelected: (city) async {
          Navigator.pop(modalContext);
          await cubit.selectDepartureCity(city);
        },
      ),
    );
  }

  void _showDestinationCityBottomSheet(BuildContext context) {
    final cubit = context.read<PesanTiketCubit>();
    final state = cubit.state;

    if (state is! PesanTiketLoaded) return;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (modalContext) => _DestinationCityBottomSheet(
        title: "Pilih Tujuan",
        items: state.cities,
        selectedItem: state.selectedDestinationCity,
        onItemSelected: (city) {
          Navigator.pop(modalContext);
          cubit.selectDestinationCity(city);
        },
      ),
    );
  }

  void _showAgencyBottomSheet(BuildContext context) {
    final cubit = context.read<PesanTiketCubit>();
    final state = cubit.state;

    if (state is! PesanTiketLoaded) return;

    if (state.selectedDepartureCity == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Pilih kota keberangkatan terlebih dahulu'),
          backgroundColor: red100,
        ),
      );
      return;
    }

    if (state.agencies.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Tidak ada agen tersedia'),
          backgroundColor: red100,
        ),
      );
      return;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (modalContext) => _AgencyBottomSheet(
        title: "Pilih Agen",
        items: state.agencies,
        selectedItem: state.selectedAgency,
        onItemSelected: (agency) {
          Navigator.pop(modalContext);
          cubit.selectAgency(agency);
        },
      ),
    );
  }

  void _showFleetClassBottomSheet(BuildContext context) {
    final cubit = context.read<PesanTiketCubit>();
    final state = cubit.state;

    if (state is! PesanTiketLoaded) return;

    final fleetClasses = cubit.getFleetClasses();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (modalContext) => _SimpleStringBottomSheet(
        title: "Pilih Kelas Armada",
        items: fleetClasses,
        selectedItem: state.selectedClass,
        onItemSelected: (fleetClass) {
          Navigator.pop(modalContext);
          cubit.selectClass(fleetClass);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black00,
      appBar: _header(context),
      body: BlocConsumer<PesanTiketCubit, PesanTiketState>(
        listener: (context, state) {
          if (state is PesanTiketError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: red100,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is PesanTiketLoading) {
            return Center(
              child: CircularProgressIndicator(color: primaryColor),
            );
          }

          if (state is PesanTiketLoaded) {
            return SingleChildScrollView(
              padding: EdgeInsets.all(padding20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildField(
                    label: "Kota Keberangkatan",
                    icon: Icons.location_city_rounded,
                    text: state.selectedDepartureCity?.name ?? "Pilih Kota",
                    onTap: () => _showDepartureCityBottomSheet(context),
                  ),
                  SizedBox(height: spacing6),
                  _buildField(
                    label: "Agen Keberangkatan",
                    icon: Icons.store_rounded,
                    text: state.selectedAgency?.agencyName ?? "Pilih Agen",
                    onTap: () => _showAgencyBottomSheet(context),
                  ),
                  SizedBox(height: spacing6),
                  _buildField(
                    label: "Tujuan",
                    icon: Icons.location_on_outlined,
                    text: state.selectedDestinationCity?.name ??
                        "Pilih Tempat Tujuan",
                    onTap: () => _showDestinationCityBottomSheet(context),
                  ),
                  SizedBox(height: spacing6),
                  Row(
                    children: [
                      Expanded(
                        child: _buildField(
                          label: "Tanggal Berangkat",
                          icon: Icons.calendar_today,
                          text: state.selectedDate != null
                              ? DateFormat('dd MMMM yyyy', 'id_ID')
                              .format(state.selectedDate!)
                              : "Pilih Tanggal",
                          onTap: () => _pickDate(context),
                        ),
                      ),
                      SizedBox(width: spacing2),
                      Expanded(
                        child: _buildField(
                          label: "Waktu Berangkat",
                          icon: Icons.access_time,
                          text: state.selectedTime ?? "Pilih Waktu",
                          onTap: () => _pickTime(context),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spacing6),
                  _buildField(
                    label: "Kelas Keberangkatan",
                    icon: Icons.directions_bus_filled,
                    text: state.selectedClass ?? "Pilih Kelas Armada",
                    onTap: () => _showFleetClassBottomSheet(context),
                  ),
                  SizedBox(height: spacing6),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: CustomButton(
                      onPressed: () {
                        context.read<PesanTiketCubit>().searchTickets();
                      },
                      padding: EdgeInsets.symmetric(vertical: padding12),
                      backgroundColor: primaryColor,
                      child: Text('Cari Tiket'),
                    ),
                  ),
                ],
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  PreferredSizeWidget _header(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight),
      child: Container(
        decoration: BoxDecoration(
          color: black00,
          boxShadow: [
            BoxShadow(
              color: black950.withOpacity(0.08),
              blurRadius: borderRadius200,
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
          title: Text("Pesan Tiket", style: xlMedium),
        ),
      ),
    );
  }

  Widget _buildField({
    required String label,
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: smMedium.copyWith(color: black950)),
        SizedBox(height: space150),
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: paddingM, vertical: 12),
            decoration: BoxDecoration(
              color: black00,
              borderRadius: BorderRadius.circular(borderRadius300),
              border: Border.all(color: black700_70.withOpacity(0.2)),
            ),
            child: Row(
              children: [
                Icon(icon, size: iconM, color: black750),
                SizedBox(width: spacing2),
                Expanded(
                  child: Text(
                    text,
                    style: mdRegular.copyWith(
                      color: text.contains("Pilih") ? black700_70 : black950,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// Bottom Sheet untuk Departure Cities
class _DepartureCityBottomSheet extends StatefulWidget {
  final String title;
  final List<departure.City> items;
  final departure.City? selectedItem;
  final Function(departure.City) onItemSelected;

  const _DepartureCityBottomSheet({
    required this.title,
    required this.items,
    required this.selectedItem,
    required this.onItemSelected,
  });

  @override
  State<_DepartureCityBottomSheet> createState() =>
      _DepartureCityBottomSheetState();
}

class _DepartureCityBottomSheetState extends State<_DepartureCityBottomSheet> {
  List<departure.City> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.items;
  }

  void _filterItems(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredItems = widget.items;
      } else {
        _filteredItems = widget.items
            .where((item) =>
            item.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: BoxDecoration(
        color: black00,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: black700_70.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(height: spacing4),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: padding20),
            child: Text(widget.title, style: lgSemiBold),
          ),
          SizedBox(height: spacing5),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: padding20),
            child: Container(
              decoration: BoxDecoration(
                color: black700_70.withOpacity(0.1),
                borderRadius: BorderRadius.circular(borderRadius300),
              ),
              child: TextField(
                onChanged: _filterItems,
                style: smRegular,
                decoration: InputDecoration(
                  hintText: 'Cari Kota',
                  hintStyle: smRegular.copyWith(color: black700_70),
                  prefixIcon: Icon(Icons.search, color: black700_70),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: paddingM,
                    vertical: padding12,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: spacing4),
          Expanded(
            child: _filteredItems.isEmpty
                ? Center(
              child: Text(
                'Tidak ada hasil',
                style: smRegular.copyWith(color: black700_70),
              ),
            )
                : ListView.builder(
              itemCount: _filteredItems.length,
              padding: EdgeInsets.symmetric(horizontal: padding20),
              itemBuilder: (context, index) {
                final item = _filteredItems[index];
                final isSelected = item.id == widget.selectedItem?.id;

                return InkWell(
                  onTap: () => widget.onItemSelected(item),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: paddingM,
                      vertical: padding16,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? navy600.withOpacity(0.1)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(borderRadius300),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            item.name,
                            style: smMedium.copyWith(
                              color: isSelected ? navy600 : black950,
                            ),
                          ),
                        ),
                        if (item.agentCount > 0)
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: navy600.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '${item.agentCount} agen',
                              style: xxsRegular.copyWith(
                                color: navy600,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Bottom Sheet untuk Destination Cities
class _DestinationCityBottomSheet extends StatefulWidget {
  final String title;
  final List<City> items;
  final City? selectedItem;
  final Function(City) onItemSelected;

  const _DestinationCityBottomSheet({
    required this.title,
    required this.items,
    required this.selectedItem,
    required this.onItemSelected,
  });

  @override
  State<_DestinationCityBottomSheet> createState() =>
      _DestinationCityBottomSheetState();
}

class _DestinationCityBottomSheetState
    extends State<_DestinationCityBottomSheet> {
  List<City> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.items;
  }

  void _filterItems(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredItems = widget.items;
      } else {
        _filteredItems = widget.items
            .where((item) =>
            item.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: BoxDecoration(
        color: black00,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: black700_70.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(height: spacing4),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: padding20),
            child: Text(widget.title, style: lgSemiBold),
          ),
          SizedBox(height: spacing5),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: padding20),
            child: Container(
              decoration: BoxDecoration(
                color: black700_70.withOpacity(0.1),
                borderRadius: BorderRadius.circular(borderRadius300),
              ),
              child: TextField(
                onChanged: _filterItems,
                style: smRegular,
                decoration: InputDecoration(
                  hintText: 'Cari Kota',
                  hintStyle: smRegular.copyWith(color: black700_70),
                  prefixIcon: Icon(Icons.search, color: black700_70),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: paddingM,
                    vertical: padding12,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: spacing4),
          Expanded(
            child: _filteredItems.isEmpty
                ? Center(
              child: Text(
                'Tidak ada hasil',
                style: smRegular.copyWith(color: black700_70),
              ),
            )
                : ListView.builder(
              itemCount: _filteredItems.length,
              padding: EdgeInsets.symmetric(horizontal: padding20),
              itemBuilder: (context, index) {
                final item = _filteredItems[index];
                final isSelected = item.id == widget.selectedItem?.id;

                return InkWell(
                  onTap: () => widget.onItemSelected(item),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: paddingM,
                      vertical: padding16,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? navy600.withOpacity(0.1)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(borderRadius300),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            item.name,
                            style: smMedium.copyWith(
                              color: isSelected ? navy600 : black950,
                            ),
                          ),
                        ),
                        if (item.agentCount > 0)
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: navy600.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '${item.agentCount} agen',
                              style: xxsRegular.copyWith(
                                color: navy600,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Bottom Sheet untuk Agency
class _AgencyBottomSheet extends StatefulWidget {
  final String title;
  final List<Agency> items;
  final Agency? selectedItem;
  final Function(Agency) onItemSelected;

  const _AgencyBottomSheet({
    required this.title,
    required this.items,
    required this.selectedItem,
    required this.onItemSelected,
  });

  @override
  State<_AgencyBottomSheet> createState() => _AgencyBottomSheetState();
}

class _AgencyBottomSheetState extends State<_AgencyBottomSheet> {
  List<Agency> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.items;
  }

  void _filterItems(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredItems = widget.items;
      } else {
        _filteredItems = widget.items
            .where((item) => (item.agencyName ?? '')
            .toLowerCase()
            .contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: BoxDecoration(
        color: black00,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: black700_70.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(height: spacing4),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: padding20),
            child: Text(widget.title, style: lgSemiBold),
          ),
          SizedBox(height: spacing5),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: padding20),
            child: Container(
              decoration: BoxDecoration(
                color: black700_70.withOpacity(0.1),
                borderRadius: BorderRadius.circular(borderRadius300),
              ),
              child: TextField(
                onChanged: _filterItems,
                style: smRegular,
                decoration: InputDecoration(
                  hintText: 'Cari Agen',
                  hintStyle: smRegular.copyWith(color: black700_70),
                  prefixIcon: Icon(Icons.search, color: black700_70),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: paddingM,
                    vertical: padding12,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: spacing4),
          Expanded(
            child: _filteredItems.isEmpty
                ? Center(
              child: Text(
                'Tidak ada hasil',
                style: smRegular.copyWith(color: black700_70),
              ),
            )
                : ListView.builder(
              itemCount: _filteredItems.length,
              padding: EdgeInsets.symmetric(horizontal: padding20),
              itemBuilder: (context, index) {
                final item = _filteredItems[index];
                final isSelected = item.id == widget.selectedItem?.id;

                return InkWell(
                  onTap: () => widget.onItemSelected(item),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: paddingM,
                      vertical: padding16,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? navy600.withOpacity(0.1)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(borderRadius300),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.agencyName ?? 'Nama Agen',
                          style: smMedium.copyWith(
                            color: isSelected ? navy600 : black950,
                          ),
                        ),
                        if (item.agencyAddress != null) ...[
                          SizedBox(height: 4),
                          Text(
                            item.agencyAddress!,
                            style: xxsRegular.copyWith(
                              color: black700_70,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: spacing5),
        ],
      ),
    );
  }
}

// Bottom Sheet untuk String items (Fleet Class)
class _SimpleStringBottomSheet extends StatefulWidget {
  final String title;
  final List<String> items;
  final String? selectedItem;
  final Function(String) onItemSelected;

  const _SimpleStringBottomSheet({
    required this.title,
    required this.items,
    required this.selectedItem,
    required this.onItemSelected,
  });

  @override
  State<_SimpleStringBottomSheet> createState() =>
      _SimpleStringBottomSheetState();
}

class _SimpleStringBottomSheetState extends State<_SimpleStringBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: BoxDecoration(
        color: black00,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: black700_70.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(height: spacing4),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: padding20),
            child: Text(widget.title, style: lgSemiBold),
          ),
          SizedBox(height: spacing5),
          Expanded(
            child: ListView.builder(
              itemCount: widget.items.length,
              padding: EdgeInsets.symmetric(horizontal: padding20),
              itemBuilder: (context, index) {
                final item = widget.items[index];
                final isSelected = item == widget.selectedItem;

                return InkWell(
                  onTap: () => widget.onItemSelected(item),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: paddingM,
                      vertical: padding16,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? navy600.withOpacity(0.1)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(borderRadius300),
                    ),
                    child: Text(
                      item,
                      style: smMedium.copyWith(
                        color: isSelected ? navy600 : black950,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: spacing5),
        ],
      ),
    );
  }
}