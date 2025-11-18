import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shantika_cubit/features/home/fleet/cubit/fleet_cubit.dart';
import 'package:shantika_cubit/features/home/fleet/cubit/fleet_state.dart';
import 'package:shantika_cubit/ui/dimension.dart';
import 'package:shantika_cubit/ui/shared_widget/custom_title.dart';
import '../../../ui/color.dart';
import '../../../ui/typography.dart';

class InfoFleetDetail extends StatefulWidget {
  final int fleetClassId;
  final String fleetClassName;

  const InfoFleetDetail({
    super.key,
    required this.fleetClassId,
    required this.fleetClassName,
  });

  @override
  State<InfoFleetDetail> createState() => _InfoFleetDetailState();
}

class _InfoFleetDetailState extends State<InfoFleetDetail> {
  @override
  void initState() {
    super.initState();
    print('InfoFleetDetail initState for ${widget.fleetClassName}');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FleetClassesCubit>().loadFleetDetail(widget.fleetClassId);
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
          onPressed: () {
            context.read<FleetClassesCubit>().backToFleetClasses();
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Informasi Armada",
          style: xlSemiBold,
        ),
      ),
      body: BlocConsumer<FleetClassesCubit, FleetClassesState>(
        listener: (context, state) {
          if (state is FleetDetailError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: red700,
              ),
            );
          }
        },
        builder: (context, state) {
          print('Building FleetDetail with state: ${state.runtimeType}');

          if (state is FleetDetailLoading) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: spacing5),
                  Text(
                    'Memuat informasi armada...',
                    style: TextStyle(color: black700_70),
                  ),
                ],
              ),
            );
          }

          if (state is FleetDetailError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: iconXXL, color: red700),
                  SizedBox(height: 16),
                  Text(
                    'Gagal memuat data',
                    style: smMedium,
                  ),
                  SizedBox(height: space200),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: paddingXL),
                    child: Text(
                      state.message,
                      style: TextStyle(color: black950),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: space600),
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<FleetClassesCubit>().loadFleetDetail(widget.fleetClassId);
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

          if (state is FleetDetailLoaded) {
            final fleet = state.fleetDetail;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(padding16),
                    child: Text(
                      fleet.name,
                      style: lgBold,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: padding16),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(borderRadius400),
                      child: AspectRatio(
                        aspectRatio: 20 / 20,
                        child: Image.network(
                          fleet.image,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: black300,
                              child: Icon(
                                Icons.image,
                                size: iconXXL,
                                color: black950,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: space600),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: padding16),
                    child: SectionTitle(
                      title: "Fasilitas",
                      lineColor: blue400,
                      textStyle: mdSemiBold,
                    ),
                  ),
                  SizedBox(height: spacing4),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: padding16),
                    child: fleet.facilities.isEmpty
                        ? Center(
                      child: Padding(
                        padding: EdgeInsets.all(paddingL),
                        child: Text(
                          'Tidak ada fasilitas',
                          style: smMedium,
                        ),
                      ),
                    )
                        : GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.8,
                        // mainAxisExtent: 100,
                      ),
                      itemCount: fleet.facilities.length,
                      itemBuilder: (context, index) {
                        final facility = fleet.facilities[index];
                        return _buildFacilityItem(facility);
                      },
                    ),
                  ),
                  SizedBox(height: space600),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: padding16),
                    child: SectionTitle(
                      title: "Foto Armada",
                      lineColor: blue400,
                      textStyle: mdSemiBold,
                    ),
                  ),
                  SizedBox(height: spacing4),
                  Padding(
                    padding: EdgeInsets.only(left: padding16, bottom: paddingL),
                    child: SizedBox(
                      height: 248,
                      child: fleet.images.isEmpty
                          ? Center(
                        child: Text(
                          'Tidak ada foto',
                          style: smMedium,
                        ),
                      )
                          : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: fleet.images.length > 10
                            ? 10
                            : fleet.images.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(right: padding12),
                            child: GestureDetector(
                              onTap: () {
                                _showImageDialog(
                                    context, fleet.images[index]);
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(borderRadius300),
                                child: AspectRatio(
                                  aspectRatio: 20 / 20,
                                  child: Image.network(
                                    fleet.images[index],
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        color: black300,
                                        child: Icon(
                                          Icons.image,
                                          size: iconXXL,
                                          color: Colors.grey,
                                        ),
                                      );
                                    },
                                  ),

                                //   child: Image.network(
                                //   fleet.images[index],
                                //   width: 248,
                                //   height: 344,
                                //   fit: BoxFit.cover,
                                //   errorBuilder:
                                //       (context, error, stackTrace) {
                                //     return Container(
                                //       width: 120,
                                //       height: 500,
                                //       color: black300,
                                //       child: Icon(
                                //         Icons.image_not_supported,
                                //         color: black700_70,
                                //       ),
                                //     );
                                //   },
                                // ),
                              ),
                            ),
                          ));
                        },
                      ),
                    ),
                  ),
                ],
              ),
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
                  style: TextStyle(color: black700_70),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildFacilityItem(facility) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 60,
          height: 60,
          padding: EdgeInsets.all(padding12),
          decoration: BoxDecoration(
            color: black00,
            borderRadius: BorderRadius.circular(borderRadius300),
          ),
          child: Image.network(
            facility.image,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return Icon(Icons.error, color: navy400, size: iconL);
            },
          ),
        ),
        SizedBox(height: space200),
        Flexible(
          child: Text(
            facility.name,
            style: xsSemiBold.copyWith(color: black700_70),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  void _showImageDialog(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: InteractiveViewer(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius300),
              child: Image.network(
                imageUrl,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: black500,
                    child: Center(
                      child: Icon(
                        Icons.error_outline,
                        size: iconXXL,
                        color: black950,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}