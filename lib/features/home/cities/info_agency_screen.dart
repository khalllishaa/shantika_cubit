import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shantika_cubit/features/home/cities/cubit/info_agency_cubit.dart';
import 'package:shantika_cubit/features/home/cities/cubit/info_agency_state.dart';
import 'package:shantika_cubit/model/info_agency_model.dart';
import 'package:shantika_cubit/ui/color.dart';
import 'package:shantika_cubit/ui/dimension.dart';
import 'package:shantika_cubit/ui/shared_widget/custom_card_container.dart';
import 'package:shantika_cubit/ui/typography.dart';
import 'package:url_launcher/url_launcher.dart';


class InfoAgencyScreen extends StatefulWidget {
  final int agencyId;

  const InfoAgencyScreen({Key? key, required this.agencyId}) : super(key: key);

  @override
  State<InfoAgencyScreen> createState() => _InfoAgencyScreenState();
}

class _InfoAgencyScreenState extends State<InfoAgencyScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<InfoAgencyCubit>().loadInfoAgency(widget.agencyId);
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
          'Informasi Agen',
          style: xlSemiBold,
        ),
      ),
      body: BlocBuilder<InfoAgencyCubit, InfoAgencyState>(
        builder: (context, state) {
          if (state is InfoAgencyLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is InfoAgencyError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 60, color: red100),
                  SizedBox(height: padding16),
                  Text(
                    state.message,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<InfoAgencyCubit>().loadInfoAgency(widget.agencyId);
                    },
                    child: Text('Coba Lagi'),
                  ),
                ],
              ),
            );
          }

          if (state is InfoAgencyLoaded) {
            return Column(
              children: [
                _buildSearchBar(context),
                Expanded(
                  child: state.filteredAgencies.isEmpty
                      ? _buildEmptyState()
                      : _buildAgencyList(state.filteredAgencies),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
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

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 60, color: black700_70),
          SizedBox(height: spacing5),
          Text(
            'Agen tidak ditemukan',
            style: smMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildAgencyList(List<Agency> agencies) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: padding16),
      itemCount: agencies.length,
      itemBuilder: (context, index) {
        final agency = agencies[index];
        return _buildAgencyCard(agency);
      },
    );
  }

  Widget _buildAgencyCard(Agency agency) {
    return CustomCardContainer(
      margin: EdgeInsets.only(bottom: padding12),
      padding: EdgeInsets.all(padding16),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: black00,
              borderRadius: BorderRadius.circular(borderRadius200),
            ),
            child: Center(
              child: Image.asset(
                'assets/images/img_monthly_guard.png',
                width: 35,
                height: 35,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/images/img_logo_shantika.png',
                    width: 30,
                    height: 30,
                    fit: BoxFit.contain,
                  );
                },
              ),
            ),
          ),
          SizedBox(width: spacing5),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  agency.agencyName,
                  style: smMedium,
                ),
                SizedBox(height: space100),
                Text(
                  agency.cityName,
                  style: sMedium.copyWith(color: black650_20),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () => _showAgencyDetail(agency),
            style: TextButton.styleFrom(
              foregroundColor: navy400,
              padding: EdgeInsets.symmetric(horizontal: padding16, vertical: paddingS),
            ),
            child: Text(
              'Detail',
              style: smMedium,
            ),
          ),
        ],
      ),
    );
  }

  void _showAgencyDetail(Agency agency) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _AgencyDetailSheet(agency: agency),
    );
  }
}

class _AgencyDetailSheet extends StatelessWidget {
  final Agency agency;

  const _AgencyDetailSheet({required this.agency});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.65,
      decoration: const BoxDecoration(
        color: black00,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadius500),
          topRight: Radius.circular(borderRadius500),
        ),
      ),
      child: Column(
        children: [
          // Handle Bar
          Container(
            margin: EdgeInsets.symmetric(vertical: padding12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: black700_70,
              borderRadius: BorderRadius.circular(borderRadius500),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(paddingL),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: black300,
                        child: Icon(Icons.person, size: 30, color: black700_70),
                      ),
                      SizedBox(width: spacing5),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              agency.agencyName,
                              style: mdSemiBold,
                            ),
                            SizedBox(height: space100),
                            Text(
                              agency.cityName,
                              style: xsMedium.copyWith(color: black700_70),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spacing5),
                  _buildInfoSection(
                    title: 'Alamat Agen',
                    content: agency.agencyAddress,
                    trailing: IconButton(
                      icon: Icon(Icons.location_on, color: primaryColor),
                      onPressed: () => _openMaps(agency.agencyLat ?? '', agency.agencyLng ?? ''),
                    ),
                  ),
                  SizedBox(height: spacing5),

                  _buildInfoSection(
                    title: 'Jam Berangkat',
                    content: _buildOperatingHours(agency),
                  ),
                  SizedBox(height: spacing5),

                  _buildInfoSection(
                    title: 'Nomor Telepon',
                    content: agency.agencyPhone,
                    trailing: IconButton(
                      icon: Icon(Icons.phone, color: primaryColor),
                      onPressed: () => _makePhoneCall(agency.agencyPhone),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _buildOperatingHours(Agency agency) {
    final morning = agency.morningTime ?? '';
    final night = agency.nightTime ?? '';

    return 'Pagi ${morning.isNotEmpty ? morning : '-'} WIB\n'
        'Sore 14:00:00 WIB\n'
        'Malam ${night.isNotEmpty ? night : '-'} WIB';
  }

  Widget _buildInfoSection({
    required String title,
    required String content,
    Widget? trailing,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: smBold,
            ),
            if (trailing != null) trailing,
          ],
        ),
        SizedBox(height: space100),
        Text(
          content,
          style: smMedium.copyWith(color: black700_70),
        ),
      ],
    );
  }

  Future<void> _openMaps(String lat, String lng) async {
    if (lat.isEmpty || lng.isEmpty) return;
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final url = 'tel:$phoneNumber';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }
}