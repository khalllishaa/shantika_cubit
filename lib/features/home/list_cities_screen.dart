import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shantika_cubit/features/home/cubit/cities/all_cities_cubit.dart';
import 'package:shantika_cubit/features/home/cubit/cities/all_cities_state.dart';
import 'package:shantika_cubit/features/home/cubit/info_agency/info_agency_cubit.dart';
import 'package:shantika_cubit/features/home/info_agency_screen.dart';
import 'package:shantika_cubit/repository/info_agency_repository.dart';
import 'package:shantika_cubit/data/api/api_service.dart';
import 'package:dio/dio.dart';
import 'package:shantika_cubit/ui/color.dart';
import 'package:shantika_cubit/ui/dimension.dart';
import 'package:shantika_cubit/ui/shared_widget/custom_card_container.dart';
import 'package:shantika_cubit/ui/typography.dart';

class ListCitiesScreen extends StatefulWidget {
  const ListCitiesScreen({super.key});

  @override
  State<ListCitiesScreen> createState() => _ListCitiesScreenState();
}

class _ListCitiesScreenState extends State<ListCitiesScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  @override
  void initState() {
    super.initState();
    context.read<AllCitiesCubit>().loadCities();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.trim().toLowerCase();
      });
    });
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
          "Informasi Agen",
          style: xlSemiBold,
        ),
      ),

      body: Column(
        children: [
          _buildSearchBar(context),
          Expanded(
            child: BlocBuilder<AllCitiesCubit, AllCitiesState>(
              builder: (context, state) {

                if (state is AllCitiesLoading) {
                  return Center(child: CircularProgressIndicator());
                }

                if (state is AllCitiesError) {
                  return Center(child: Text(state.message));
                }

                if (state is AllCitiesLoaded) {
                  final filtered = state.cities.where((c) {
                    return c.name.toLowerCase().contains(_searchQuery);
                  }).toList();

                  if (filtered.isEmpty) {
                    return Center(child: Text("Kota tidak ditemukan"));
                  }

                  return ListView.builder(
                    padding: EdgeInsets.only(bottom: paddingL),
                    itemCount: filtered.length,
                    itemBuilder: (context, i) {
                      final city = filtered[i];

                      return CustomCardContainer(
                        margin: EdgeInsets.fromLTRB(padding16, padding6, padding16, padding6),
                        padding: EdgeInsets.symmetric(
                          horizontal: padding20,
                          vertical: paddingM,
                        ),
                        backgroundColor: black00,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  city.name.toUpperCase(),
                                  style: smMedium,
                                ),
                                SizedBox(height: space200),
                                Text(
                                  "${city.agentCount ?? 0} Agen",
                                  style: xsRegular.copyWith(color: black700_70),
                                ),
                              ],
                            ),

                            GestureDetector(
                              onTap: () {
                                final api = ApiService(Dio());
                                final repo = InfoAgencyRepository(api);

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => BlocProvider(
                                      create: (_) => InfoAgencyCubit(repo),
                                      child: InfoAgencyScreen(
                                        agencyId: city.id,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                "Lihat Selengkapnya",
                                style: smMedium.copyWith(color: black700_70),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                }
                return const SizedBox();
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
            context.read<InfoAgencyCubit>().searchAgencies(value);
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