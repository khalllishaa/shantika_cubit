import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

// import '../../../features/guard_schedule/cubit/guard_type_cubit.dart';
import '../../../model/guard_model.dart';
import '../../color.dart';
import '../../dimension.dart';
import '../../typography.dart';
import '../custom_button.dart';
import '../custom_close_button.dart';
import '../error_view.dart';

// ignore: must_be_immutable
class SelectGuardTypeSheet extends StatelessWidget {
  SelectGuardTypeSheet({super.key, required this.guardTypeId, required this.onGuardSelected});

  final String guardTypeId;
  final Function(GuardClassModel?)? onGuardSelected;

  // int _selectedIndex = 0;

  // late GuardTypeCubit _guardTypeCubit;

  @override
  Widget build(BuildContext context) {
    return Column();
    // _guardTypeCubit = context.read();
    // _guardTypeCubit.init();
    // _guardTypeCubit.guardTypeById(guardTypeId: guardTypeId);
    // final screenHeight = MediaQuery.of(context).size.height;
    // final appBarHeight = kToolbarHeight;
    // final statusBarHeight = MediaQuery.of(context).padding.top;
    // final bottomSheetHeight = screenHeight - appBarHeight - statusBarHeight;

    // return BlocBuilder<GuardTypeCubit, GuardTypeState>(
    //   builder: (context, state) {
    //     List<GuardClassModel> guardClass = state is GuardTypeStateSuccess ? state.guardClass : [];
    //
    //     if (state is GuardTypeStateLoading) {
    //       return SizedBox(
    //         width: MediaQuery.of(context).size.width,
    //         height: bottomSheetHeight,
    //         child: Center(
    //           child: CircularProgressIndicator(),
    //         ),
    //       );
    //     } else if (state is GuardTypeStateError) {
    //       return SizedBox(
    //         width: MediaQuery.of(context).size.width,
    //         height: bottomSheetHeight,
    //         child: ErrorView(
    //           title: "OOpps",
    //           desc: state.message,
    //           onReload: () {
    //             _guardTypeCubit.guardTypeById(guardTypeId: guardTypeId);
    //           },
    //         ),
    //       );
    //     } else {
    //       return StatefulBuilder(
    //         builder: (context, setState) => SizedBox(
    //           width: MediaQuery.of(context).size.width,
    //           height: bottomSheetHeight,
    //           child: Padding(
    //             padding: const EdgeInsets.all(space400),
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Row(
    //                   children: [
    //                     const Text('Kelas Petugas', style: xlSemiBold),
    //                     const Spacer(),
    //                     CustomCloseButton(),
    //                   ],
    //                 ),
    //                 const SizedBox(height: space800),
    //                 Center(
    //                   child: Container(
    //                     width: double.infinity,
    //                     padding: const EdgeInsets.all(space100),
    //                     decoration: BoxDecoration(
    //                       color: bgSurfaceNeutral,
    //                       borderRadius: BorderRadius.circular(borderRadius300),
    //                     ),
    //                     child: Row(
    //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                       children: List.generate(
    //                         guardClass.length,
    //                         (index) {
    //                           bool isSelectedIndex = _selectedIndex == index;
    //                           return InkWell(
    //                             onTap: () {
    //                               setState(() {
    //                                 _selectedIndex = index;
    //                               });
    //                             },
    //                             child: FittedBox(
    //                               child: Container(
    //                                 padding: const EdgeInsets.symmetric(vertical: space250, horizontal: space600),
    //                                 decoration: BoxDecoration(
    //                                     color: isSelectedIndex ? iconWhite : Colors.transparent,
    //                                     borderRadius: BorderRadius.circular(borderRadius300),
    //                                     border: isSelectedIndex ? Border.all(color: black200) : null),
    //                                 child: Text(
    //                                   guardClass[index].name ?? "",
    //                                   style: smMedium.copyWith(color: isSelectedIndex ? Colors.black : Colors.grey),
    //                                 ),
    //                               ),
    //                             ),
    //                           );
    //                         },
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //                 const SizedBox(height: space800),
    //                 Text(
    //                   "${guardClass[_selectedIndex].name} Class",
    //                   style: lgSemiBold,
    //                 ),
    //                 const SizedBox(height: space600),
    //                 Text(
    //                   guardClass[_selectedIndex].description ?? "-",
    //                   style: smRegular,
    //                 ),
    //                 const SizedBox(height: space600),
    //                 Column(
    //                   children: List.generate(
    //                     guardClass[_selectedIndex].guard_skills?.length ?? 0,
    //                     (index) {
    //                       bool isSkilled = guardClass[_selectedIndex].guard_skills?[index].is_skilled ?? false;
    //                       return Column(
    //                         children: [
    //                           Row(
    //                             children: [
    //                               SvgPicture.asset(
    //                                 "assets/images/ic_tick_circle.svg",
    //                                 color: !isSkilled ? Colors.red : iconDisabled,
    //                               ),
    //                               const SizedBox(width: space200),
    //                               Text(guardClass[_selectedIndex].guard_skills?[index].name ?? "", style: smMedium)
    //                             ],
    //                           ),
    //                           const SizedBox(height: space400),
    //                         ],
    //                       );
    //                     },
    //                   ),
    //                 ),
    //                 SizedBox(height: space600),
    //                 CustomButton(
    //                   onPressed: () {
    //                     onGuardSelected!(guardClass[_selectedIndex]);
    //                     Navigator.pop(context, guardClass[_selectedIndex]);
    //                   },
    //                   child: const Text(
    //                     "Pilih",
    //                     style: smMedium,
    //                   ),
    //                 )
    //               ],
    //             ),
    //           ),
    //         ),
    //       );
    //     }
    //   },
    // );
  }
}
