import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shantika_cubit/features/home/fleet/cubit/fleet_cubit.dart';
import 'package:shantika_cubit/features/home/fleet/cubit/fleet_state.dart';
import 'package:shantika_cubit/features/home/fleet/info_fleet_screen.dart';
import 'package:shantika_cubit/ui/dimension.dart';
import '../../../ui/color.dart';
import '../../../ui/shared_widget/custom_card_container.dart';
import '../../../ui/typography.dart';

class InfoFleetClasses extends StatefulWidget {
  const InfoFleetClasses({super.key});

  @override
  State<InfoFleetClasses> createState() => _InfoFleetClassesState();
}

class _InfoFleetClassesState extends State<InfoFleetClasses> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    print('InfoFleetClasses initState called');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print('Loading fleet classes...');
      context.read<FleetClassesCubit>().loadFleetClasses();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black00,
      appBar: AppBar(
        backgroundColor: black00,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: black950),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Kelas Armada",
          style: xlSemiBold,
        ),
      ),
      body: Column(
        children: [
          _buildSearchBar(context),
          Expanded(
            child: BlocConsumer<FleetClassesCubit, FleetClassesState>(
              listener: (context, state) {
                if (state is FleetClassesError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: red700,
                    ),
                  );
                }
              },
              builder: (context, state) {
                print('Building UI with state: ${state.runtimeType}');

                if (state is FleetClassesLoading) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: spacing5),
                        Text(
                          'Memuat data kelas armada...',
                          style: TextStyle(color: black700_70),
                        ),
                      ],
                    ),
                  );
                }

                if (state is FleetClassesError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline, size: iconXXL, color: red700),
                        SizedBox(height: spacing5),
                        Text(
                          'Gagal memuat data',
                          style: smMedium,
                        ),
                        SizedBox(height: space200),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: paddingXL),
                          child: Text(
                            state.message,
                            style: TextStyle(color: black700_70),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: space600),
                        ElevatedButton.icon(
                          onPressed: () {
                            context.read<FleetClassesCubit>().loadFleetClasses();
                          },
                          icon: Icon(Icons.refresh),
                          label: Text('Coba Lagi'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: black950,
                            foregroundColor: black00,
                            padding: EdgeInsets.symmetric(horizontal: paddingL, vertical: padding12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(borderRadius300),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                if (state is FleetClassesLoaded) {
                  print('Loaded ${state.fleetClasses.length} fleet classes');

                  final fleetClasses = state.fleetClasses
                      .where((fleet) =>
                      fleet.name.toLowerCase().contains(_searchQuery))
                      .toList();

                  if (fleetClasses.isEmpty && _searchQuery.isNotEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/icons/bus.svg', width: 180, fit: BoxFit.contain,),
                          // Image.asset(
                          //   'assets/images/no_data.png',
                          //   width: 180,
                          //   height: 180,
                          //   fit: BoxFit.contain,
                          // ),
                          SizedBox(height: spacing6),
                          Text(
                            'Tidak ada data armada',
                            style: mdMedium,
                          ),
                        ],
                      ),
                    );
                  }

                  if (state.fleetClasses.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.inbox_outlined, size: iconXXL, color: black700_70),
                          SizedBox(height: spacing5),
                          Text(
                            'Belum ada data kelas armada',
                            style: TextStyle(color: black700_70),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: padding16),
                    itemCount: fleetClasses.length,
                    itemBuilder: (context, index) {
                      final fleetClass = fleetClasses[index];
                      return Padding(
                        padding: EdgeInsets.only(bottom: padding12),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider.value(
                                  value: context.read<FleetClassesCubit>(),
                                  child: InfoFleetDetail(
                                    fleetClassId: fleetClass.id,
                                    fleetClassName: fleetClass.name,
                                  ),
                                ),
                              ),
                            );
                          },
                          child: CustomCardContainer(
                            height: 70,
                            padding: EdgeInsets.all(padding16),
                            backgroundColor: black00,
                            borderRadius: borderRadius300,
                            boxShadow: [
                              BoxShadow(
                                color: black700_70.withOpacity(0.1),
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              )
                            ],
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    fleetClass.name.toUpperCase(),
                                    style: smSemiBold,
                                  ),
                                ),
                                Text(
                                  'Lihat Selengkapnya',
                                  style: xsRegular.copyWith(color: black700_70),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );

                }

                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: spacing5),
                      Text(
                        'Memuat data...',
                        style: smMedium,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding16),
      child: Container(
        decoration: BoxDecoration(
          color: black350,
          borderRadius: BorderRadius.circular(padding12),
        ),
        child: TextField(
          controller: _searchController,
          onChanged: (value) {
            setState(() {
              _searchQuery = value.toLowerCase();
            });
          },
          decoration: InputDecoration(
            hintText: "Cari Kota",
            hintStyle: TextStyle(
              color: black700_70,
            ),
            prefixIcon: Icon(
              Icons.search,
              color: black700_70,
            ),

            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,

            contentPadding: EdgeInsets.symmetric(
              horizontal: padding16,
              vertical: padding12,
            ),
          ),
        ),
      ),
    );
  }

}