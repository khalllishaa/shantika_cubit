import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:with_space_between/with_space_between.dart';

import '../../../config/constant.dart';
// import '../../../features/guard_schedule/cubit/equipment_support_cubit.dart';
import '../../../model/equipment_support_model.dart';
import '../../color.dart';
import '../../dimension.dart';
import '../../typography.dart';
import '../custom_button.dart';
import '../custom_close_button.dart';
import '../error_view.dart';
import '../network_image_view.dart';

// ignore: must_be_immutable
class SelectEquipmentSupportSheet extends StatefulWidget {
  SelectEquipmentSupportSheet({super.key, this.onEquipmentSelected, this.initalEquipments});

  List<EquipmentSupportModel>? initalEquipments;

  Function(List<EquipmentSupportModel>?)? onEquipmentSelected;

  @override
  State<SelectEquipmentSupportSheet> createState() => _SelectEquipmentSupportSheetState();
}

class _SelectEquipmentSupportSheetState extends State<SelectEquipmentSupportSheet> {
  List<EquipmentSupportModel> selectedEquipments = [];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final appBarHeight = kToolbarHeight;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final bottomSheetHeight = screenHeight - appBarHeight - statusBarHeight;
    return Padding(
      padding: const EdgeInsets.all(space400),
      child: Container(
        height: bottomSheetHeight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('Support', style: xlSemiBold),
                const Spacer(),
                CustomCloseButton(),
              ],
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: space300, vertical: space300),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius300),
                color: bgFillInfo,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    'assets/images/ic_info.svg',
                    width: 20,
                    height: 20,
                    color: iconLightPrimary,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Supports Equipment',
                          style: smMedium.copyWith(color: textLightPrimary),
                        ),
                        Text(
                          'Jika kamu menyimpan Support Equipment, maka akan ditambahkan ke tagihan akhir',
                          style: xsRegular.copyWith(color: textLightPrimary),
                          textAlign: TextAlign.start,
                        ),
                      ].withSpaceBetween(height: space200),
                    ),
                  )
                ].withSpaceBetween(width: space200),
              ),
            ),
            SizedBox(height: space300),
            Text(
              'Security Equipment',
              style: lgSemiBold.copyWith(color: textDarkPrimary),
            ),
            SizedBox(height: space300),
            // Expanded(
            //   child: BlocProvider(
            //     create: (context) => EquipmentSupportCubit()
            //       ..init()
            //       ..equipments(),
            //     child: BlocBuilder<EquipmentSupportCubit, EquipmentSupportState>(
            //       builder: (context, state) {
            //         if (state is EquipmentSupportStateSuccess) {
            //           selectedEquipments = state.equipments;
            //
            //           return ListView.separated(
            //             itemCount: state.equipments.length,
            //             padding: EdgeInsets.zero,
            //             shrinkWrap: true,
            //             itemBuilder: (context, index) {
            //               EquipmentSupportModel? data = state.equipments[index];
            //               return _reuseCardEquipment(data: data, equipments: state.equipments);
            //             },
            //             separatorBuilder: (BuildContext context, int index) {
            //               return const SizedBox(height: space200);
            //             },
            //           );
            //         } else if (state is EquipmentSupportStateError) {
            //           return ErrorView(
            //             title: "Oopps",
            //             desc: state.message,
            //             onReload: () {
            //               Navigator.pop(context);
            //             },
            //           );
            //         } else {
            //           return Center(
            //             child: CircularProgressIndicator(),
            //           );
            //         }
            //       },
            //     ),
            //   ),
            // ),
            CustomButton(
              backgroundColor: bgFillPrimary,
              onPressed: () {
                List<EquipmentSupportModel> selectedList =
                    selectedEquipments.where((e) => (e.selectedQty ?? 0) > 0).toList();

                if (selectedList.isNotEmpty) {
                  widget.onEquipmentSelected!(selectedList);
                  Navigator.pop(context);
                }

                print(selectedList.length);
              },
              child: Text(
                'Tambahkan',
                style: smMedium.copyWith(color: textLightPrimary),
              ),
            ),
          ].withSpaceBetween(height: space200),
        ),
      ),
    );
  }

  Widget _reuseCardEquipment({
    required EquipmentSupportModel? data,
    required List<EquipmentSupportModel> equipments,
  }) {
    return Container(
      padding: EdgeInsets.all(space400),
      decoration: BoxDecoration(
        color: bgLight,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius200),
            child: SizedBox(
              width: 50,
              height: 50,
              child: NetworkImageView(
                url: '${baseImage}/${data?.thumbnail}',
                width: 50,
                height: 50,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data?.name ?? "",
                  style: mdSemiBold.copyWith(color: textDarkPrimary),
                ),
                Text(
                  'Kamu bisa memilih lebih dari 1',
                  style: smRegular.copyWith(color: textDarkSecondary),
                ),
              ].withSpaceBetween(height: space050),
            ),
          ),
          Container(
            width: 90,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: bg,
              boxShadow: [
                BoxShadow(
                  color: Color(0xffB5B5B5),
                  spreadRadius: 0,
                  blurRadius: 0,
                  offset: Offset(0, 1), // changes position of shadow
                ),
                BoxShadow(
                  color: Color(0xffE3E3E3),
                  spreadRadius: 0,
                  blurRadius: 0,
                  offset: Offset(1, 0), // changes position of shadow
                ),
                BoxShadow(
                  color: Color(0xffE3E3E3),
                  spreadRadius: 0,
                  blurRadius: 0,
                  offset: Offset(-1, 0), // changes position of shadow
                ),
                BoxShadow(
                  color: Color(0xffE3E3E3),
                  spreadRadius: 0,
                  blurRadius: 0,
                  offset: Offset(0, -1), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    if ((data?.selectedQty ?? 0) > 0) {
                      setState(() {
                        int index = equipments.indexWhere((e) => e.id == data?.id);
                        int newQuantity = (data?.selectedQty ?? 0) - 1;
                        if (index != -1) {
                          equipments[index] = equipments[index].copyWith(selectedQty: newQuantity);
                        }
                      });
                    }
                  },
                  child: Icon(Icons.remove, size: 15),
                ),
                Text((data?.selectedQty ?? 0).toString(), style: smSemiBold),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      int newQuantity = (data?.selectedQty ?? 0) + 1;
                      int index = equipments.indexWhere((e) => e.id == data?.id);
                      if (index != -1) {
                        if ((data?.selectedQty ?? 0) < (data?.readyToUse ?? 0)) {
                          equipments[index] = equipments[index].copyWith(selectedQty: newQuantity);
                        }
                      }
                    });
                  },
                  child: Icon(Icons.add, size: 15),
                ),
              ],
            ),
          ),
        ].withSpaceBetween(width: space300),
      ),
    );
  }
}
