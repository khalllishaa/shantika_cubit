import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shantika_cubit/utility/extensions/date_time_extensions.dart';
import 'package:with_space_between/with_space_between.dart';

import '../../config/constant.dart';
import '../../model/assignment_history_model.dart';
import '../../ui/color.dart';
import '../../ui/dimension.dart';
import '../../ui/shared_widget/empty_state_view.dart';
import '../../ui/shared_widget/error_view.dart';
import '../../ui/typography.dart';
import 'assignment_detail_screen.dart';
import 'cubit/history_assignment_cubit.dart';

// ignore: must_be_immutable
class AssignmentScreen extends StatelessWidget {
  AssignmentScreen({super.key});

  late HistoryAssignmentCubit _historyAssignmentCubit;

  @override
  Widget build(BuildContext context) {
    _historyAssignmentCubit = context.read();
    _historyAssignmentCubit.init();
    _historyAssignmentCubit.history();

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.only(left: space500, top: space1200),
            //   child: Row(
            //     children: [
            //       SvgPicture.asset(
            //         'assets/images/ic_briefcase_nav.svg',
            //         color: iconDarkPrimary,
            //       ),
            //       Text(
            //         "Penugasan",
            //         style: xlMedium.copyWith(color: textDarkPrimary),
            //       ),
            //     ].withSpaceBetween(width: space200),
            //   ),
            // ),
            // _buildTabBar(),
            // Expanded(
            //   child: TabBarView(
            //     children: [
            //       // pending
            //       _buildPendingView(),
            //       // _buildInProgress(context),
            //       // berlangsung
            //       _buildInProgress(context),
            //       // dibatalkan
            //       //_buildCancelledView(),
            //       _buildFinishedView(),
            //     ],
            //   ),
            // )
          ],
          // .withSpaceBetween(height: space300),
        ),
      ),
    );
  }

//   Widget _buildPendingView() {
//     return BlocBuilder<HistoryAssignmentCubit, HistoryAssignmentState>(
//       builder: (context, state) {
//         if (state is HistoryAssignmentStateSuccess) {
//           if (state.histories.isEmpty) {
//             return EmptyStateView(
//               title: "Belum Ada Riwayat",
//               type: EmptyStateType.assignment,
//               onPressed: () {
//                 _historyAssignmentCubit.setStatus(null);
//               },
//             );
//           } else {
//             return Padding(
//               padding: const EdgeInsets.symmetric(horizontal: space200, vertical: space200),
//               child: ListView.separated(
//                 padding: EdgeInsets.zero,
//                 itemCount: state.histories.length,
//                 shrinkWrap: true,
//                 separatorBuilder: (BuildContext context, int index) {
//                   return SizedBox(height: space400);
//                 },
//                 itemBuilder: (BuildContext context, int index) {
//                   AssignmentHistoryModel? data = state.histories[index];
//
//                   return _cardAssigment(data, context);
//                 },
//               ),
//             );
//           }
//         } else if (state is HistoryAssignmentStateError) {
//           return ErrorView(
//             title: "Oops",
//             desc: state.message,
//             onReload: () {
//               _historyAssignmentCubit.setStatus(null);
//             },
//           );
//         } else {
//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         }
//       },
//     );
//   }
//
//   Widget _buildFinishedView() {
//     return BlocBuilder<HistoryAssignmentCubit, HistoryAssignmentState>(
//       builder: (context, state) {
//         if (state is HistoryAssignmentStateSuccess) {
//           if (state.histories.isEmpty) {
//             return EmptyStateView(
//               title: "Belum Ada Riwayat",
//               type: EmptyStateType.assignment,
//               onPressed: () {
//                 _historyAssignmentCubit.setStatus(AssignmentHistoryStatus.finished.jsonValue);
//               },
//             );
//           } else {
//             return Padding(
//               padding: const EdgeInsets.symmetric(horizontal: space200, vertical: space200),
//               child: ListView.separated(
//                 padding: EdgeInsets.zero,
//                 itemCount: state.histories.length,
//                 shrinkWrap: true,
//                 separatorBuilder: (BuildContext context, int index) {
//                   return SizedBox(height: space400);
//                 },
//                 itemBuilder: (BuildContext context, int index) {
//                   AssignmentHistoryModel? data = state.histories[index];
//
//                   return _cardAssigment(data, context);
//                 },
//               ),
//             );
//           }
//         } else if (state is HistoryAssignmentStateError) {
//           return ErrorView(
//             title: "Oops",
//             desc: state.message,
//             onReload: () {
//               _historyAssignmentCubit.setStatus(AssignmentHistoryStatus.finished.jsonValue);
//             },
//           );
//         } else {
//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         }
//       },
//     );
//   }
//
//   Widget _buildInProgress(BuildContext context) {
//     return BlocBuilder<HistoryAssignmentCubit, HistoryAssignmentState>(
//       builder: (context, state) {
//         if (state is HistoryAssignmentStateSuccess) {
//           if (state.histories.isEmpty) {
//             return EmptyStateView(
//               title: "Belum Ada Riwayat",
//               type: EmptyStateType.assignment,
//               onPressed: () {
//                 _historyAssignmentCubit.setStatus(AssignmentHistoryStatus.process.jsonValue);
//               },
//             );
//           } else {
//             return Padding(
//               padding: const EdgeInsets.symmetric(horizontal: space200, vertical: space200),
//               child: ListView.separated(
//                 padding: EdgeInsets.zero,
//                 itemCount: state.histories.length,
//                 shrinkWrap: true,
//                 separatorBuilder: (BuildContext context, int index) {
//                   return SizedBox(height: space400);
//                 },
//                 itemBuilder: (BuildContext context, int index) {
//                   AssignmentHistoryModel? data = state.histories[index];
//
//                   return _cardAssigment(data, context);
//                 },
//               ),
//             );
//           }
//         } else if (state is HistoryAssignmentStateError) {
//           return ErrorView(
//             title: "Oops",
//             desc: state.message,
//             onReload: () {
//               _historyAssignmentCubit.setStatus(AssignmentHistoryStatus.process.jsonValue);
//             },
//           );
//         } else {
//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         }
//       },
//     );
//   }
//
//   // Widget _buildCancelledView() {
//   //   return BlocBuilder<HistoryAssignmentCubit, HistoryAssignmentState>(
//   //     builder: (context, state) {
//   //       if (state is HistoryAssignmentStateSuccess) {
//   //         if (state.histories.isEmpty) {
//   //           return EmptyStateView(
//   //             title: "Belum Ada Riwayat",
//   //             type: EmptyStateType.assignment,
//   //             onPressed: () {
//   //               _historyAssignmentCubit.setStatus(AssignmentHistoryStatus.cancelled.jsonValue);
//   //             },
//   //           );
//   //         } else {
//   //           return Padding(
//   //             padding: const EdgeInsets.symmetric(horizontal: space200, vertical: space200),
//   //             child: ListView.separated(
//   //               padding: EdgeInsets.zero,
//   //               itemCount: state.histories.length,
//   //               shrinkWrap: true,
//   //               separatorBuilder: (BuildContext context, int index) {
//   //                 return SizedBox(height: space400);
//   //               },
//   //               itemBuilder: (BuildContext context, int index) {
//   //                 AssignmentHistoryModel? data = state.histories[index];
//
//   //                 return _cardAssigment(data, context);
//   //               },
//   //             ),
//   //           );
//   //         }
//   //       } else if (state is HistoryAssignmentStateError) {
//   //         return ErrorView(
//   //           title: "Oops",
//   //           desc: state.message,
//   //           onReload: () {
//   //             _historyAssignmentCubit.setStatus(AssignmentHistoryStatus.cancelled.jsonValue);
//   //           },
//   //         );
//   //       } else {
//   //         return Center(
//   //           child: CircularProgressIndicator(),
//   //         );
//   //       }
//   //     },
//   //   );
//   // }
//
//   Widget _cardAssigment(AssignmentHistoryModel? data, BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => AssignmentDetailScreen(
//               id: data?.id ?? "",
//             ),
//           ),
//         );
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           border: Border.all(color: Colors.grey[300]!),
//           borderRadius: BorderRadius.circular(borderRadius500),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: space400, horizontal: space200),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     children: [
//                       SvgPicture.asset(
//                         'assets/images/ic_bag.svg',
//                       ),
//                       SizedBox(width: space150),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             data?.guardType ?? "",
//                             style: xxsSemiBold.copyWith(color: textPrimary),
//                           ),
//                           Text(
//                             "${data?.startTime?.convert(format: 'dd MMM yyyy')}",
//                             style: xxsSemiBold.copyWith(color: Colors.grey),
//                           )
//                         ],
//                       )
//                     ],
//                   ),
//                   SizedBox(width: space400),
//                   FittedBox(
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(horizontal: space250, vertical: space200),
//                       decoration: BoxDecoration(
//                         color: getStatusContainerColor(data?.status ?? AssignmentHistoryStatus.upcoming),
//                         borderRadius: BorderRadius.circular(100),
//                       ),
//                       child: Text(
//                         data?.status?.translatedName ?? "",
//                         style: xsMedium.copyWith(
//                           color: getStatusTextColor(data?.status ?? AssignmentHistoryStatus.upcoming),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: space300),
//               Text(
//                 data?.address?.address ?? "",
//                 style: smSemiBold,
//               ),
//               SizedBox(height: space100),
//               Text(
//                 "${data?.startTime?.convert(format: "EE, dd MMM yyyy, HH:mm")} - ${data?.endTime?.convert(format: "EE, dd MMM yyyy, HH:mm")}",
//                 style: xxsRegular.copyWith(color: Colors.grey),
//               ),
//               SizedBox(height: space300),
//               Container(
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.grey.shade300),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Table(
//                   columnWidths: const {
//                     0: FlexColumnWidth(1),
//                     1: FlexColumnWidth(1),
//                     2: FlexColumnWidth(0.8),
//                     3: FlexColumnWidth(0.6),
//                   },
//                   border: TableBorder.symmetric(
//                     inside: BorderSide(color: Colors.grey.shade300),
//                   ),
//                   children: [
//                     _buildTableHeader(),
//                     data?.guardTypeName == "MONTHLY_PERSONAL_SECURITY"
//                         ? _buildMonthlyTableData(data)
//                         : _buildTableData(data),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   TableRow _buildTableHeader() {
//     return TableRow(
//       decoration: BoxDecoration(
//         color: Colors.grey[100],
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(borderRadius150),
//           topRight: Radius.circular(borderRadius150),
//         ),
//       ),
//       children: [
//         _buildHeaderCell('Jumlah Petugas'),
//         _buildHeaderCell('Jenis Penugasan'),
//         _buildHeaderCell('Kelas'),
//         _buildHeaderCell('Durasi'),
//       ],
//     );
//   }
//
//   TableRow _buildTableData(AssignmentHistoryModel? data) {
//     String startTimeString = data?.startTime?.toUtc().toString() ?? "2025-01-01 00:00:00";
//     String endTimeString = data?.endTime?.toUtc().toString() ?? "2025-01-01 00:00:00";
//
//     DateTime startTime = DateTime.parse(startTimeString).toUtc();
//     DateTime endTime = DateTime.parse(endTimeString).toUtc();
//
//     int differenceInHours = endTime.difference(startTime).inHours;
//     return TableRow(
//       children: [
//         _buildDataCell('${data?.numberOfGuard} Petugas'),
//         _buildDataCell('${data?.guardType}'),
//         _buildDataCell('${data?.guardClass}'),
//         _buildDataCell('${differenceInHours} Jam'),
//       ],
//     );
//   }
//
//   TableRow _buildMonthlyTableData(AssignmentHistoryModel? data) {
//     String startTimeString = data?.startTime?.toUtc().toString() ?? "2025-01-01 00:00:00";
//     String endTimeString = data?.endTime?.toUtc().toString() ?? "2025-01-01 00:00:00";
//
//     DateTime startTime = DateTime.parse(startTimeString).toUtc();
//     DateTime endTime = DateTime.parse(endTimeString).toUtc();
//
//     int differenceInDays = endTime.difference(startTime).inDays;
//     return TableRow(
//       children: [
//         _buildDataCell('${data?.numberOfGuard} Petugas'),
//         _buildDataCell('${data?.guardType}'),
//         _buildDataCell('${data?.guardClass}'),
//         _buildDataCell('${differenceInDays} Hari'),
//       ],
//     );
//   }
//
//   Widget _buildHeaderCell(String text) {
//     return Padding(
//       padding: EdgeInsets.symmetric(
//         vertical: space100,
//       ),
//       child: Text(text, textAlign: TextAlign.center, style: xxsRegular),
//     );
//   }
//
//   Widget _buildDataCell(String text) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Text(text, textAlign: TextAlign.center, style: xsMedium),
//     );
//   }
//
//   void fetchDataByStatus(int index) {
//     switch (index) {
//       case 0:
//         _historyAssignmentCubit.setStatus(null);
//         break;
//       case 1:
//         _historyAssignmentCubit.setStatus(AssignmentHistoryStatus.process.jsonValue);
//         break;
//       case 2:
//         _historyAssignmentCubit.setStatus(AssignmentHistoryStatus.finished.jsonValue);
//         break;
//     }
//   }
//
//   TabBar _buildTabBar() {
//     return TabBar(
//       onTap: fetchDataByStatus,
//       padding: EdgeInsets.zero,
//       tabAlignment: TabAlignment.fill,
//       labelPadding: const EdgeInsets.symmetric(vertical: spacing5),
//       labelStyle: sSemiBold.copyWith(color: textPrimary),
//       unselectedLabelStyle: sSemiBold.copyWith(color: textDisabled),
//       dividerColor: Colors.transparent,
//       indicatorColor: bgFillPrimary,
//       indicatorPadding: const EdgeInsets.symmetric(horizontal: space400),
//       tabs: const [
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text("Menunggu"),
//           ],
//         ),
//         // Row(
//         //   crossAxisAlignment: CrossAxisAlignment.center,
//         //   mainAxisAlignment: MainAxisAlignment.center,
//         //   children: [
//         //     Text("Akan Datang"),
//         //   ],
//         // ),
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text("Berlangsung"),
//           ],
//         ),
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text("Terselesaikan"),
//           ],
//         ),
//       ],
//     );
//   }
// }
//
// Color getStatusContainerColor(AssignmentHistoryStatus status) {
//   if (status == AssignmentHistoryStatus.upcoming) {
//     return bgSurfaceSecondary;
//   } else if (status == AssignmentHistoryStatus.process) {
//     return bgSurfacePrimary;
//   } else if (status == AssignmentHistoryStatus.finished) {
//     return bgSurfaceSuccess;
//   } else if (status == AssignmentHistoryStatus.cancelled) {
//     return bgSurfaceNeutralLight;
//   } else if (status == AssignmentHistoryStatus.pending) {
//     return bgSurfaceNeutralLight;
//   } else {
//     return bgSurfaceNeutralLight;
//   }
// }
//
// Color getStatusTextColor(AssignmentHistoryStatus status) {
//   if (status == AssignmentHistoryStatus.upcoming) {
//     return textSecondary;
//   } else if (status == AssignmentHistoryStatus.process) {
//     return textPrimary;
//   } else if (status == AssignmentHistoryStatus.finished) {
//     return textSuccess;
//   } else if (status == AssignmentHistoryStatus.cancelled) {
//     return textDarkSecondary;
//   } else if (status == AssignmentHistoryStatus.pending) {
//     return textDarkSecondary;
//   } else {
//     return textDarkSecondary;
//   }
// }
}
