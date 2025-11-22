import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:shantika_cubit/features/home/books_ticket/cubit/pesan_tiket_cubit.dart';
import 'package:shantika_cubit/features/home/books_ticket/cubit/pesan_tiket_state.dart';
import 'package:shantika_cubit/features/home/books_ticket/list_armada_screen.dart';
import 'package:shantika_cubit/model/city_depature_model.dart' as departure;
import 'package:shantika_cubit/model/pesan_tiket_model.dart';
import 'package:shantika_cubit/model/agency_model.dart';
import 'package:shantika_cubit/ui/shared_widget/custom_button.dart';

import '../../../model/agency_by_id_model.dart' as byId;
import '../../../model/fleet_available_model.dart' as available;
import '../../../ui/color.dart';
import '../../../ui/dimension.dart';
import '../../../ui/typography.dart';

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
              onPrimary: black00,
              surface: black00,
              onSurface: black950,
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

  void _showTimeBottomSheet(BuildContext context) {
    final cubit = context.read<PesanTiketCubit>();
    final state = cubit.state;

    if (state is! PesanTiketLoaded) return;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (modalContext) => Container(
        height: MediaQuery.of(context).size.height * 0.5,
        decoration: BoxDecoration(
          color: black00,
          borderRadius: BorderRadius.vertical(top: Radius.circular(borderRadius500)),
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: padding12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: black700_70.withOpacity(0.3),
                borderRadius: BorderRadius.circular(borderRadius500),
              ),
            ),
            SizedBox(height: spacing4),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: padding20),
              child: Text("Pilih Waktu", style: lgSemiBold),
            ),
            SizedBox(height: spacing5),
            Expanded(
              child: state.timeSlots.isEmpty
                  ? Center(
                child: Text(
                  'Tidak ada waktu tersedia',
                  style: smRegular.copyWith(color: black700_70),
                ),
              )
                  : ListView.builder(
                itemCount: state.timeSlots.length,
                padding: EdgeInsets.symmetric(horizontal: padding20),
                itemBuilder: (context, index) {
                  final item = state.timeSlots[index];
                  final isSelected = item.id == state.selectedTime?.id;

                  return InkWell(
                    onTap: () {
                      Navigator.pop(modalContext);
                      cubit.selectTime(item);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: paddingM,
                        vertical: padding16,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? navy600.withOpacity(0.1)
                            : Colors.transparent,
                        borderRadius:
                        BorderRadius.circular(borderRadius500),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.name,
                                  style: smMedium.copyWith(
                                    color: isSelected
                                        ? navy600
                                        : black950,
                                  ),
                                ),
                                SizedBox(height: space100),
                                Text(
                                  '${item.timeStart} - ${item.timeEnd}',
                                  style: xsRegular.copyWith(
                                    color: black700_70,
                                  ),
                                ),
                              ],
                            ),
                          ),
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
      ),
    );
  }

  void _showDepartureCityBottomSheet(BuildContext context) {
    final cubit = context.read<PesanTiketCubit>();
    final state = cubit.state;

    if (state is! PesanTiketLoaded) return;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (modalContext) {
        List<departure.City> filteredItems = state.departureCities;
        final FocusNode searchFocusNode = FocusNode();
        final ScrollController scrollController = ScrollController();

        searchFocusNode.addListener(() {
          if (searchFocusNode.hasFocus) {
            Future.delayed(Duration(milliseconds: 300), () {
              if (scrollController.hasClients) {
                scrollController.animateTo(
                  0,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                );
              }
            });
          }
        });

        return StatefulBuilder(
          builder: (context, setModalState) => GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.75,
              decoration: BoxDecoration(
                color: black00,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(borderRadius500),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: padding12),
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: black700_70.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(borderRadius500),
                    ),
                  ),
                  SizedBox(height: spacing4),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: padding20),
                    child: Text("Pilih Kota Keberangkatan", style: lgSemiBold),
                  ),
                  SizedBox(height: spacing5),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: padding20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: black00,
                        borderRadius: BorderRadius.circular(borderRadius350),
                      ),
                      child: TextField(
                        focusNode: searchFocusNode,
                        onChanged: (query) {
                          setModalState(() {
                            filteredItems = query.isEmpty
                                ? state.departureCities
                                : state.departureCities
                                .where((item) => item.name
                                .toLowerCase()
                                .contains(query.toLowerCase()))
                                .toList();
                          });
                        },
                        style: smRegular,
                        decoration: InputDecoration(
                          hintText: 'Cari Kota',
                          hintStyle: smRegular.copyWith(color: black700_70),
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(padding12),
                            child: SvgPicture.asset(
                              "assets/icons/ic_search.svg",
                              width: 16,
                              height: 16,
                              colorFilter: ColorFilter.mode(black700_70, BlendMode.srcIn),
                            ),
                          ),
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
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: filteredItems.length,
                      padding: EdgeInsets.symmetric(horizontal: padding20),
                      itemBuilder: (context, index) {
                        final item = filteredItems[index];
                        final bool isSelected =
                            item.id == state.selectedDepartureCity?.id;

                        return InkWell(
                          onTap: () async {
                            Navigator.pop(modalContext);
                            await cubit.selectDepartureCity(item);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: paddingM,
                              vertical: padding16,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected ? navy600 : Colors.transparent,
                              borderRadius:
                              BorderRadius.circular(borderRadius300),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    item.name,
                                    style: smMedium.copyWith(
                                      color:
                                      isSelected ? black00 : black950,
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
            ),
          ),
        );
      },
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
      builder: (modalContext) {
        List<byId.Agency> filteredItems = state.destinationAgencies;
        final FocusNode searchFocusNode = FocusNode();
        final ScrollController scrollController = ScrollController();

        searchFocusNode.addListener(() {
          if (searchFocusNode.hasFocus) {
            Future.delayed(Duration(milliseconds: 300), () {
              if (scrollController.hasClients) {
                scrollController.animateTo(
                  0,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                );
              }
            });
          }
        });

        return StatefulBuilder(
          builder: (context, setModalState) => GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.75,
              decoration: BoxDecoration(
                color: black00,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(borderRadius500),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: padding12),
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: black700_70.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(borderRadius500),
                    ),
                  ),
                  SizedBox(height: spacing4),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: padding20),
                    child: Text("Pilih Tujuan", style: lgSemiBold),
                  ),
                  SizedBox(height: spacing5),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: padding20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: black00,
                        borderRadius: BorderRadius.circular(borderRadius350),
                      ),
                      child: TextField(
                        focusNode: searchFocusNode,
                        onChanged: (query) {
                          setModalState(() {
                            filteredItems = query.isEmpty
                                ? state.destinationAgencies
                                : state.destinationAgencies
                                .where((item) {
                              final searchText = '${item.agencyName} - ${item.cityName}'.toLowerCase();
                              return searchText.contains(query.toLowerCase());
                            })
                                .toList();
                          });
                        },
                        style: smRegular,
                        decoration: InputDecoration(
                          hintText: 'Cari Tujuan',
                          hintStyle: smRegular.copyWith(color: black700_70),
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(padding12),
                            child: SvgPicture.asset(
                              "assets/icons/ic_search.svg",
                              width: 16,
                              height: 16,
                              colorFilter: ColorFilter.mode(black700_70, BlendMode.srcIn),
                            ),
                          ),
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
                    child: filteredItems.isEmpty
                        ? Center(
                      child: Text(
                        'Tidak ada tujuan tersedia',
                        style: smRegular.copyWith(color: black700_70),
                      ),
                    )
                        : ListView.builder(
                      controller: scrollController,
                      itemCount: filteredItems.length,
                      padding: EdgeInsets.symmetric(horizontal: padding20),
                      itemBuilder: (context, index) {
                        final item = filteredItems[index];
                        final bool isSelected =
                            item.id == state.selectedDestinationAgency?.id;

                        return InkWell(
                          onTap: () {
                            Navigator.pop(modalContext);
                            cubit.selectDestinationAgency(item);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: paddingM,
                              vertical: padding16,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected ? navy600 : Colors.transparent,
                              borderRadius:
                              BorderRadius.circular(borderRadius300),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '${item.agencyName} - ${item.cityName}',
                                    style: smMedium.copyWith(
                                      color:
                                      isSelected ? black00 : black950,
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
            ),
          ),
        );
      },
    );
  }

  void _showAgencyBottomSheet(BuildContext context) {
    final cubit = context.read<PesanTiketCubit>();
    final state = cubit.state;

    if (state is! PesanTiketLoaded) return;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (modalContext) {
        List<AgencyCity> filteredItems = state.agencies;
        final FocusNode searchFocusNode = FocusNode();
        final ScrollController scrollController = ScrollController();

        searchFocusNode.addListener(() {
          if (searchFocusNode.hasFocus) {
            Future.delayed(Duration(milliseconds: 300), () {
              if (scrollController.hasClients) {
                scrollController.animateTo(
                  0,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                );
              }
            });
          }
        });

        return StatefulBuilder(
          builder: (context, setModalState) => GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.75,
              decoration: BoxDecoration(
                color: black00,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(borderRadius500),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: padding12),
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: black700_70.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(borderRadius500),
                    ),
                  ),
                  SizedBox(height: spacing4),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: padding20),
                    child: Text("Pilih Agen Keberangkatan", style: lgSemiBold),
                  ),
                  SizedBox(height: spacing5),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: padding20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: black00,
                        borderRadius: BorderRadius.circular(borderRadius350),
                      ),
                      child: TextField(
                        focusNode: searchFocusNode,
                        onChanged: (query) {
                          setModalState(() {
                            filteredItems = query.isEmpty
                                ? state.agencies
                                : state.agencies
                                .where((item) => item.name
                                .toLowerCase()
                                .contains(query.toLowerCase()))
                                .toList();
                          });
                        },
                        style: smRegular,
                        decoration: InputDecoration(
                          hintText: 'Cari Agen',
                          hintStyle: smRegular.copyWith(color: black700_70),
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(padding12),
                            child: SvgPicture.asset(
                              "assets/icons/ic_search.svg",
                              width: 16,
                              height: 16,
                              colorFilter: ColorFilter.mode(black700_70, BlendMode.srcIn),
                            ),
                          ),
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
                    child: BlocBuilder<PesanTiketCubit, PesanTiketState>(
                      builder: (context, currentState) {
                        if (currentState is! PesanTiketLoaded) {
                          return Center(
                            child: CircularProgressIndicator(color: primaryColor),
                          );
                        }

                        final isLoadingAgencies = currentState.selectedDepartureCity != null &&
                            currentState.agencies.isEmpty;

                        if (isLoadingAgencies) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(color: primaryColor),
                                SizedBox(height: spacing4),
                                Text(
                                  'Memuat data agen...',
                                  style: smRegular.copyWith(color: black700_70),
                                ),
                              ],
                            ),
                          );
                        }

                        if (filteredItems.length != currentState.agencies.length) {
                          filteredItems = currentState.agencies;
                        }

                        if (filteredItems.isEmpty) {
                          return Center(
                            child: Text(
                              'Tidak ada agen tersedia',
                              style: smRegular.copyWith(color: black700_70),
                            ),
                          );
                        }

                        return ListView.builder(
                          controller: scrollController,
                          itemCount: filteredItems.length,
                          padding: EdgeInsets.symmetric(horizontal: padding20),
                          itemBuilder: (context, index) {
                            final item = filteredItems[index];
                            final bool isSelected =
                                item.id == currentState.selectedAgency?.id;

                            return InkWell(
                              onTap: () {
                                Navigator.pop(modalContext);
                                cubit.selectAgency(item);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: paddingM,
                                  vertical: padding16,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected ? navy600 : Colors.transparent,
                                  borderRadius:
                                  BorderRadius.circular(borderRadius300),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        item.name,
                                        style: smMedium.copyWith(
                                          color:
                                          isSelected ? black00 : black950,
                                        ),
                                      ),
                                    ),
                                  ],
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
          ),
        );
      },
    );
  }

  void _showFleetClassBottomSheet(BuildContext context) async {
    final cubit = context.read<PesanTiketCubit>();
    final state = cubit.state;

    if (state is! PesanTiketLoaded) return;

    if (state.selectedAgency == null ||
        state.selectedDestinationAgency == null ||
        state.selectedDate == null ||
        state.selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Mohon lengkapi data keberangkatan, tujuan, tanggal, dan waktu terlebih dahulu'),
          backgroundColor: red100,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: CircularProgressIndicator(color: primaryColor),
      ),
    );

    await cubit.loadAvailableFleetClasses();

    Navigator.pop(context);

    final updatedState = cubit.state;
    if (updatedState is! PesanTiketLoaded) return;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (modalContext) {
        List<available.FleetClass> filteredItems = updatedState.availableFleetClasses;
        final FocusNode searchFocusNode = FocusNode();
        final ScrollController scrollController = ScrollController();

        searchFocusNode.addListener(() {
          if (searchFocusNode.hasFocus) {
            Future.delayed(Duration(milliseconds: 300), () {
              if (scrollController.hasClients) {
                scrollController.animateTo(
                  0,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                );
              }
            });
          }
        });

        return StatefulBuilder(
          builder: (context, setModalState) => GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.65,
              decoration: BoxDecoration(
                color: black00,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(borderRadius500),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: padding12),
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: black700_70.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(borderRadius500),
                    ),
                  ),
                  SizedBox(height: spacing4),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: padding20),
                    child: Text("Pilih Kelas Armada", style: lgSemiBold),
                  ),
                  SizedBox(height: spacing5),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: padding20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: black00,
                        borderRadius: BorderRadius.circular(borderRadius350),
                      ),
                      child: TextField(
                        focusNode: searchFocusNode,
                        onChanged: (query) {
                          setModalState(() {
                            filteredItems = query.isEmpty
                                ? updatedState.availableFleetClasses
                                : updatedState.availableFleetClasses
                                .where((item) => item.name
                                .toLowerCase()
                                .contains(query.toLowerCase()))
                                .toList();
                          });
                        },
                        style: smRegular,
                        decoration: InputDecoration(
                          hintText: 'Cari Kelas',
                          hintStyle: smRegular.copyWith(color: black700_70),
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(padding12),
                            child: SvgPicture.asset(
                              "assets/icons/ic_search.svg",
                              width: 16,
                              height: 16,
                              colorFilter: ColorFilter.mode(
                                black700_70,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
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
                    child: filteredItems.isEmpty
                        ? Center(
                      child: Text(
                        updatedState.availableFleetClasses.isEmpty
                            ? 'Tidak ada armada tersedia untuk jadwal ini'
                            : 'Tidak ada hasil',
                        style: smRegular.copyWith(color: black700_70),
                      ),
                    )
                        : ListView.builder(
                      controller: scrollController,
                      itemCount: filteredItems.length,
                      padding: EdgeInsets.symmetric(horizontal: padding20),
                      itemBuilder: (context, index) {
                        final item = filteredItems[index];
                        final isSelected = item.id == updatedState.selectedClass?.id;

                        return InkWell(
                          onTap: () {
                            Navigator.pop(modalContext);
                            cubit.selectClass(item);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: paddingM,
                              vertical: padding16,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? navy600
                                  : Colors.transparent,
                              borderRadius:
                              BorderRadius.circular(borderRadius300),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.name,
                                        style: smMedium.copyWith(
                                          color: isSelected
                                              ? black00
                                              : black950,
                                        ),
                                      ),
                                      SizedBox(height: space100),
                                      Text(
                                        '${item.seatCapacity} kursi',
                                        style: xsRegular.copyWith(
                                          color: isSelected
                                              ? black00.withOpacity(0.8)
                                              : black700_70,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
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
            ),
          ),
        );
      },
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
            final isFormComplete = state.selectedDepartureCity != null &&
                state.selectedAgency != null &&
                state.selectedDestinationAgency != null &&
                state.selectedDate != null &&
                state.selectedTime != null &&
                state.selectedClass != null;

            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(padding20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildField(
                          label: "Kota Keberangkatan",
                          iconPath: "assets/icons/ic_build.svg",
                          text: state.selectedDepartureCity?.name ??
                              "Pilih Kota",
                          onTap: () => _showDepartureCityBottomSheet(context),
                        ),
                        SizedBox(height: spacing6),
                        _buildField(
                          label: "Agen Keberangkatan",
                          iconPath: "assets/icons/ic_destination.svg",
                          text: state.selectedAgency?.name ?? "Pilih Agen",
                          onTap: () => _showAgencyBottomSheet(context),
                        ),
                        SizedBox(height: spacing6),
                        _buildField(
                          label: "Tujuan",
                          iconPath: "assets/icons/ic_location.svg",
                          text: state.selectedDestinationAgency != null
                              ? '${state.selectedDestinationAgency!.agencyName} - ${state.selectedDestinationAgency!.cityName}'
                              : "Pilih Tujuan",
                          onTap: () => _showDestinationCityBottomSheet(context),
                        ),
                        SizedBox(height: spacing6),
                        Row(
                          children: [
                            Expanded(
                              child: _buildField(
                                label: "Tanggal Berangkat",
                                iconPath: "assets/icons/ic_calendar.svg",
                                text: state.selectedDate != null
                                    ? DateFormat('EEE, dd MMM yyyy', 'id_ID')
                                    .format(state.selectedDate!)
                                    : "Pilih Tanggal",
                                onTap: () => _pickDate(context),
                              ),
                            ),
                            SizedBox(width: spacing2),
                            Expanded(
                              child: _buildField(
                                label: "Waktu Berangkat",
                                iconPath: "assets/icons/ic_clock.svg",
                                text: state.selectedTime?.name ?? "Pilih Waktu",
                                onTap: () => _showTimeBottomSheet(context),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spacing6),
                        _buildField(
                          label: "Kelas Keberangkatan",
                          iconPath: "assets/icons/ic_fleet.svg",
                          text: state.selectedClass?.name ?? "Pilih Kelas Armada",
                          onTap: () => _showFleetClassBottomSheet(context),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(padding20),
                  child: SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: CustomButton(
                      onPressed: isFormComplete
                          ? () async {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => Center(
                            child: CircularProgressIndicator(color: primaryColor),
                          ),
                        );
                        final routes = await context.read<PesanTiketCubit>().searchTickets();
                        Navigator.pop(context);
                        if (routes != null) {
                          final cubit = context.read<PesanTiketCubit>();
                          final state = cubit.state as PesanTiketLoaded;

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ListArmadaScreen(
                                routes: routes,
                                selectedDate: state.selectedDate!,
                                departureCity: state.selectedDepartureCity!.name,
                                destinationAgency:
                                '${state.selectedDestinationAgency!.agencyName} - ${state.selectedDestinationAgency!.cityName}',
                                timeClassificationId: state.selectedTime!.id,
                              ),
                            ),
                          );
                        }
                      }
                          : null,
                      padding: EdgeInsets.symmetric(vertical: padding12),
                      backgroundColor: isFormComplete ? primaryColor : black650,
                      child: Text('Cari Tiket'),
                    ),
                  ),
                ),
              ],
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
    required String iconPath,
    String? text,
    required VoidCallback onTap,
  }) {
    final bool isEmpty = text == null || text.isEmpty || text.contains("Pilih");
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
                SvgPicture.asset(
                  iconPath,
                  width: iconM,
                  height: iconM,
                  colorFilter: ColorFilter.mode(black750, BlendMode.srcIn),
                ),
                SizedBox(width: space250),
                Expanded(
                  child: Text(
                    text ?? "",
                    style: mdRegular.copyWith(
                      color: isEmpty ? black700_70 : black950,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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