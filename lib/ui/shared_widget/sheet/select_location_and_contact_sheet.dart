// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';

// import '../../../features/guard_schedule/location_picker_screen.dart';
import '../../../location/location_cubit.dart';
import '../../../model/address_model.dart';
import '../../color.dart';
import '../../dimension.dart';
import '../../typography.dart';
import '../custom_button.dart';
import '../custom_dropdown_button.dart';
import '../custom_switch.dart';
import '../custom_text_form_field.dart';
import '../error_view.dart';

class SelectLocationAndContactSheet extends StatefulWidget {
  SelectLocationAndContactSheet({super.key, this.onSelected, this.initialValue});
  final AddressModel? initialValue;
  final Function(AddressModel?)? onSelected;

  @override
  State<SelectLocationAndContactSheet> createState() => _SelectLocationAndContactSheetState();
}

class _SelectLocationAndContactSheetState extends State<SelectLocationAndContactSheet> {
  bool _isMainAddress = false;
  AddressModel? _selectedItem;

  // late LocationCubit _locationCubit;
  //
  // late AddressCubit _addressCubit;
  //
  // late CreateUpdateAddressCubit _createUpdateAddressCubit;

  MapController _mapController = MapController();

  final TextEditingController _addressController = TextEditingController();

  final TextEditingController _detailBangunanController = TextEditingController();

  final TextEditingController _noPhoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // _locationCubit = context.read();
    // _locationCubit.getLocation();
    //
    // _addressCubit = context.read();
    // _addressCubit.init();
    // _addressCubit.address();
    //
    // _createUpdateAddressCubit = context.read();
    // _createUpdateAddressCubit.init();

    _noPhoneController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

  // void _onAddressSelected(AddressModel? e) {
  //   String? numberWithoutPrefix = e?.phone?.replaceFirst(RegExp(r'^\+62'), '');
  //   setState(() {
  //     _selectedItem = e;
  //
  //     _locationCubit.setLocation(
  //       latLng: LatLng(double.parse(e?.latitude ?? "0"), double.parse(e?.longitude ?? "0")),
  //     );
  //     _mapController.move(LatLng(double.parse(e?.latitude ?? "0"), double.parse(e?.longitude ?? "0")), 17.0);
  //     _detailBangunanController.text = e?.note ?? "";
  //     _noPhoneController.text = numberWithoutPrefix ?? "";
  //   });
  // }
  //
  // @override
  // Widget build(BuildContext context) {
  //   final screenHeight = MediaQuery.of(context).size.height;
  //   final appBarHeight = kToolbarHeight;
  //   final statusBarHeight = MediaQuery.of(context).padding.top;
  //   final bottomSheetHeight = screenHeight - appBarHeight - statusBarHeight;
  //
  //   return BlocBuilder<LocationCubit, LocationState>(
  //     builder: (context, state) {
  //       if (state is LocationStateError) {
  //         return SizedBox(
  //           width: MediaQuery.of(context).size.width,
  //           height: bottomSheetHeight,
  //           child: Padding(
  //             padding: const EdgeInsets.symmetric(horizontal: space400),
  //             child: ErrorView(
  //               title: "Oopps",
  //               desc: state.message,
  //               onReload: () {
  //                 if (Platform.isIOS) {
  //                   openAppSettings();
  //                 }
  //                 // _locationCubit.getLocation();
  //               },
  //             ),
  //           ),
  //         );
  //       } else if (state is LocationStateGetLocation) {
  //         _addressController.text = state.address ?? "";
  //
  //         return SingleChildScrollView(
  //           child: SizedBox(
  //             width: MediaQuery.of(context).size.width,
  //             height: bottomSheetHeight,
  //             child: Padding(
  //               padding: const EdgeInsets.all(space400),
  //               child: SingleChildScrollView(
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Row(
  //                       children: [
  //                         const Text(
  //                           'Lokasi',
  //                           style: xlSemiBold,
  //                         ),
  //                         const Spacer(),
  //                         Container(
  //                           height: 36,
  //                           width: 36,
  //                           decoration: BoxDecoration(
  //                               shape: BoxShape.rectangle,
  //                               border: Border.all(color: black200),
  //                               borderRadius: const BorderRadius.all(Radius.circular(8))),
  //                           child: Center(
  //                             child: InkWell(
  //                               onTap: () => Navigator.pop(context),
  //                               child: SvgPicture.asset(
  //                                 'assets/images/ic_bottom_sheet_close.svg',
  //                                 height: 16,
  //                                 width: 16,
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                     const SizedBox(height: space500),
  //                     _buildMapView(state),
  //                     const SizedBox(height: space200),
  //                     _buildPickManualLocationButton(context, state),
  //                     const SizedBox(height: space200),
  //                     _selectAddressView(),
  //                     const SizedBox(height: space200),
  //                     CustomTextFormField(
  //                       enabled: false,
  //                       controller: _addressController,
  //                       placeholder: "Alamat rumah Anda",
  //                       titleSection: "Alamat",
  //                     ),
  //                     const SizedBox(height: space200),
  //                     CustomTextFormField(
  //                       controller: _detailBangunanController,
  //                       placeholder: "Abu - Abu",
  //                       titleSection: "Detail Bangunan (Optional)",
  //                     ),
  //                     const SizedBox(height: space200),
  //                     CustomTextFormField(
  //                       prefixText: '+62 ',
  //                       titleSection: "Nomor Telepon",
  //                       controller: _noPhoneController,
  //                       validator: (e) {
  //                         if (e == "" || e.isEmpty) {
  //                           return "Nomor telepon tidak boleh kosong";
  //                         }
  //                         if (e[0] == '0') {
  //                           return "Nomor telepon tidak boleh diawali dengan '0'";
  //                         }
  //                         return null;
  //                       },
  //                       inputFormatters: [FilteringTextInputFormatter.digitsOnly],
  //                       keyboardType: TextInputType.phone,
  //                     ),
  //                     // const Spacer(),
  //                     _buildSetMainAddressView(),
  //                     SizedBox(height: space200),
  //                     _buildAddLocationButton(state, context),
  //                     SizedBox(height: 200),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ),
  //         );
  //       } else {
  //         return _buildLoadingView(context, bottomSheetHeight);
  //       }
  //     },
  //   );
  // }
  //
  // Widget _buildSetMainAddressView() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     children: [
  //       CustomSwitch(
  //         value: _isMainAddress,
  //         onChanged: (e) {
  //           setState(() {
  //             _isMainAddress = e;
  //           });
  //         },
  //       ),
  //       SizedBox(width: space200),
  //       Flexible(
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text('Atur Sebagai Alamat Utama', style: lgMedium),
  //             Text(
  //               'Pastikan alamat dan lokasi anda sudah benar',
  //               style: mdRegular.copyWith(color: textNeutralSecondary),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }
  //
  // Widget _selectAddressView() {
  //   return BlocBuilder<AddressCubit, AddressState>(
  //     builder: (context, state) {
  //       List<AddressModel> addressList = state is AddressStateSuccess ? state.address : [];
  //       if (state is AddressStateLoading) {
  //         return SizedBox();
  //       }
  //
  //       return Visibility(
  //         visible: addressList.isNotEmpty,
  //         child: CustomDropDownButton<AddressModel>(
  //           getLabel: (address) => address.address ?? "",
  //           titleSection: "Pilih Alamat Sebelumnya",
  //           onChanged: _onAddressSelected,
  //           selectedItem: _selectedItem,
  //           dropdownItems: addressList.map((e) => e).toList(),
  //           hint: "Pilih Alamat Sebelumnya",
  //         ),
  //       );
  //     },
  //   );
  // }
  //
  // Widget _buildAddLocationButton(LocationStateGetLocation state, BuildContext context) {
  //   return CustomButton(
  //     onPressed: _noPhoneController.text.isNotEmpty
  //         ? () {
  //             widget.onSelected!(_selectedItem);
  //             _createUpdateAddressCubit.createUpdateAddress(
  //               id: _selectedItem?.id,
  //               phone: _noPhoneController.text,
  //               address: state.address ?? "",
  //               note: _detailBangunanController.text,
  //               isMainAddress: _isMainAddress,
  //               latitude: state.latLng.latitude.toString(),
  //               longitude: state.latLng.longitude.toString(),
  //             );
  //             Navigator.pop(context);
  //           }
  //         : null,
  //     child: const Text(
  //       "Tambah Lokasi",
  //       style: smMedium,
  //     ),
  //   );
  // }
  //
  // SizedBox _buildMapView(LocationStateGetLocation state) {
  //   return SizedBox(
  //     height: 180,
  //     child: FlutterMap(
  //       mapController: _mapController,
  //       options: MapOptions(
  //         initialCenter: state.latLng,
  //         initialZoom: 17,
  //       ),
  //       children: [
  //         TileLayer(
  //           urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
  //         ),
  //         MarkerLayer(
  //           markers: [
  //             Marker(
  //               point: state.latLng,
  //               width: 80,
  //               height: 80,
  //               child: Icon(Icons.location_on, size: 40, color: Colors.red),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }
  //
  // Widget _buildPickManualLocationButton(BuildContext context, LocationStateGetLocation state) {
  //   return TextButton(
  //     onPressed: () async {
  //       LatLng? selectedLocation = await Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => LocationPickerScreen(
  //             userLocation: state.latLng,
  //           ),
  //         ),
  //       );
  //
  //       if (selectedLocation != null) {
  //         _locationCubit.setLocation(latLng: selectedLocation);
  //         _selectedItem = null;
  //         WidgetsBinding.instance.addPostFrameCallback((_) {
  //           _mapController.move(selectedLocation, 17.0);
  //         });
  //       }
  //     },
  //     child: Text('Ambil Lokasi Manual'),
  //   );
  // }
  //
  // SizedBox _buildLoadingView(BuildContext context, double bottomSheetHeight) {
  //   return SizedBox(
  //     width: MediaQuery.of(context).size.width,
  //     height: bottomSheetHeight,
  //     child: Center(
  //       child: CircularProgressIndicator(),
  //     ),
  //   );
  // }
}
