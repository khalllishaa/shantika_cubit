import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shantika_cubit/features/transaction/payment_webview_screen.dart';
import 'package:shantika_cubit/features/transaction/transaction_detail_screen.dart';
import 'package:shantika_cubit/utility/extensions/date_time_extensions.dart';
import 'package:shantika_cubit/utility/extensions/int_extension.dart';
import 'package:with_space_between/with_space_between.dart';

import '../../config/constant.dart';
import '../../model/transaction_model.dart';
import '../../ui/color.dart';
import '../../ui/dimension.dart';
import '../../ui/shared_widget/custom_appbar.dart';
import '../../ui/shared_widget/custom_button.dart';
import '../../ui/shared_widget/empty_state_view.dart';
import '../../ui/shared_widget/error_view.dart';
import '../../ui/typography.dart';
import 'cubit/history_transaction_cubit.dart';

// ignore: must_be_immutable
class TransactionScreen extends StatelessWidget {
  TransactionScreen({super.key});

  late HistoryTransactionCubit _historyTransactionCubit;

  @override
  Widget build(BuildContext context) {
    _historyTransactionCubit = context.read();
    _historyTransactionCubit.init();
    _historyTransactionCubit.historyTransaction();

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: CustomAppBar(
          leading: false,
          title: "Transaksi",
          img: 'assets/images/ic_transaction_nav.svg',
        ),
        body: Column(
          children: [
            // _buildTabBar(),
            // Expanded(
            //   child: TabBarView(
            //     children: [
            //       _buildActiveInvoice(),
            //       _buildSuccessInvoice(),
            //       _buildCancelledInvoice(),
            //     ],
            //   ),
            // )
          ],
              // .withSpaceBetween(height: space300),
        ),
      ),
    );
  }
  //
  // Widget _buildActiveInvoice() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: space200, vertical: space200),
  //     child: BlocBuilder<HistoryTransactionCubit, HistoryTransactionState>(
  //       builder: (context, state) {
  //         if (state is HistoryTransactionStateSuccess) {
  //           if (state.transactions.isEmpty) {
  //             return EmptyStateView(
  //               title: "Belum Ada Tagihan",
  //               type: EmptyStateType.trx,
  //               onPressed: () {
  //                 _historyTransactionCubit.setStatus(TransactionStatus.pending.jsonValue);
  //               },
  //             );
  //           } else {
  //             return ListView.separated(
  //               padding: EdgeInsets.zero,
  //               itemCount: state.transactions.length,
  //               shrinkWrap: true,
  //               separatorBuilder: (BuildContext context, int index) {
  //                 return SizedBox(height: space400);
  //               },
  //               itemBuilder: (BuildContext context, int index) {
  //                 return _cardTransaction(data: state.transactions[index], context: context);
  //               },
  //             );
  //           }
  //         } else if (state is HistoryTransactionStateError) {
  //           return ErrorView(
  //             title: "Oops",
  //             desc: state.message,
  //             onReload: () {
  //               _historyTransactionCubit.setStatus(TransactionStatus.pending.jsonValue);
  //             },
  //           );
  //         } else {
  //           return Center(
  //             child: CircularProgressIndicator(),
  //           );
  //         }
  //       },
  //     ),
  //   );
  // }
  //
  // Widget _buildSuccessInvoice() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: space200, vertical: space200),
  //     child: BlocBuilder<HistoryTransactionCubit, HistoryTransactionState>(
  //       builder: (context, state) {
  //         if (state is HistoryTransactionStateSuccess) {
  //           List<TransactionModel> filteredList =
  //               state.transactions.where((e) => e.status == TransactionStatus.paid).toList();
  //
  //           if (filteredList.isEmpty) {
  //             return EmptyStateView(
  //               title: "Belum Ada Tagihan",
  //               type: EmptyStateType.trx,
  //               onPressed: () {
  //                 _historyTransactionCubit.setStatus(TransactionStatus.paid.jsonValue);
  //               },
  //             );
  //           } else {
  //             return ListView.separated(
  //               padding: EdgeInsets.zero,
  //               itemCount: filteredList.length,
  //               shrinkWrap: true,
  //               separatorBuilder: (BuildContext context, int index) {
  //                 return SizedBox(height: space400);
  //               },
  //               itemBuilder: (BuildContext context, int index) {
  //                 return _cardTransaction(data: filteredList[index], context: context);
  //               },
  //             );
  //           }
  //         } else if (state is HistoryTransactionStateError) {
  //           return ErrorView(
  //             title: "Oops",
  //             desc: state.message,
  //             onReload: () {
  //               _historyTransactionCubit.setStatus(TransactionStatus.paid.jsonValue);
  //             },
  //           );
  //         } else {
  //           return Center(
  //             child: CircularProgressIndicator(),
  //           );
  //         }
  //       },
  //     ),
  //   );
  // }
  //
  // Widget _buildCancelledInvoice() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: space200, vertical: space200),
  //     child: BlocBuilder<HistoryTransactionCubit, HistoryTransactionState>(
  //       builder: (context, state) {
  //         if (state is HistoryTransactionStateSuccess) {
  //           List<TransactionModel> filteredList =
  //               state.transactions.where((e) => e.status == TransactionStatus.cancelled).toList();
  //
  //           if (filteredList.isEmpty) {
  //             return EmptyStateView(
  //               title: "Belum Ada Tagihan",
  //               type: EmptyStateType.trx,
  //               onPressed: () {
  //                 _historyTransactionCubit.setStatus(TransactionStatus.cancelled.jsonValue);
  //               },
  //             );
  //           } else {
  //             return ListView.separated(
  //               padding: EdgeInsets.zero,
  //               itemCount: filteredList.length,
  //               shrinkWrap: true,
  //               separatorBuilder: (BuildContext context, int index) {
  //                 return SizedBox(height: space400);
  //               },
  //               itemBuilder: (BuildContext context, int index) {
  //                 return _cardTransaction(data: filteredList[index], context: context);
  //               },
  //             );
  //           }
  //         } else if (state is HistoryTransactionStateError) {
  //           return ErrorView(
  //             title: "Oops",
  //             desc: state.message,
  //             onReload: () {
  //               _historyTransactionCubit.setStatus(TransactionStatus.cancelled.jsonValue);
  //             },
  //           );
  //         } else {
  //           return Center(
  //             child: CircularProgressIndicator(),
  //           );
  //         }
  //       },
  //     ),
  //   );
  // }
  //
  // Widget _cardTransaction({
  //   required TransactionModel data,
  //   required BuildContext context,
  // }) {
  //   final parsedStartTime = DateTime.parse(data.startTime ?? DateTime.now().toIso8601String());
  //   final parsedEndTime = DateTime.parse(data.endTime ?? DateTime.now().toIso8601String());
  //
  //   return GestureDetector(
  //     onTap: () {
  //       if (data.status == TransactionStatus.waiting) {
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => ApprovalStatusScreen(
  //               transactionId: data.id ?? "",
  //               paymentCode: data.paymentCode ?? "",
  //             ),
  //           ),
  //         );
  //       } else {
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => TransactionDetailScreen(
  //               id: data.id ?? "",
  //             ),
  //           ),
  //         );
  //       }
  //     },
  //     child: Container(
  //       decoration: BoxDecoration(
  //         border: Border.all(color: Colors.grey[300]!),
  //         borderRadius: BorderRadius.circular(borderRadius500),
  //       ),
  //       child: Padding(
  //         padding: const EdgeInsets.symmetric(vertical: space400, horizontal: space200),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Row(
  //               children: [
  //                 Expanded(
  //                   child: Row(
  //                     children: [
  //                       SvgPicture.asset(
  //                         'assets/images/ic_bag.svg',
  //                       ),
  //                       SizedBox(width: space150),
  //                       Column(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           Text(
  //                             data.guardType ?? "-",
  //                             style: xxsSemiBold.copyWith(color: textPrimary),
  //                           ),
  //                           Text(
  //                             data.createdAt?.convert(format: "EE MM yyyy") ?? "-",
  //                             style: xxsSemiBold.copyWith(color: Colors.grey),
  //                           )
  //                         ],
  //                       )
  //                     ],
  //                   ),
  //                 ),
  //                 FittedBox(
  //                   child: Container(
  //                     padding: const EdgeInsets.symmetric(horizontal: space250, vertical: space200),
  //                     decoration: BoxDecoration(
  //                       color: data.status?.color,
  //                       borderRadius: BorderRadius.circular(100),
  //                     ),
  //                     child: Text(
  //                       data.status?.jsonValue ?? "-",
  //                       style: xsMedium.copyWith(color: black50),
  //                     ),
  //                   ),
  //                 ),
  //                 SizedBox(width: space250),
  //                 SvgPicture.asset('assets/images/ic_more.svg')
  //               ],
  //             ),
  //             SizedBox(height: space200),
  //             Divider(
  //               color: borderNeutralLight,
  //             ),
  //             SizedBox(height: space200),
  //             Text(
  //               data.address?.address ?? "",
  //               style: smSemiBold,
  //             ),
  //             SizedBox(height: space100),
  //             Text(
  //               '${parsedStartTime.convert(format: 'EEEE, dd MMM yyyy HH:mm')} - ${parsedEndTime.convert(format: 'HH:mm')}',
  //               style: xsRegular.copyWith(color: Colors.grey),
  //             ),
  //             SizedBox(height: space300),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Text((data.payAmount ?? 0).convertRupiah(), style: mdBold),
  //                 Visibility(
  //                   visible: data.status == TransactionStatus.cancelled ? true : false,
  //                   child: CustomButton(
  //                     child: Text("Re-Order"),
  //                     onPressed: () {
  //                       Navigator.push(
  //                         context,
  //                         MaterialPageRoute(
  //                           builder: (context) => TransactionDetailScreen(
  //                             id: data.id ?? "",
  //                           ),
  //                         ),
  //                       );
  //                     },
  //                     width: 94,
  //                   ),
  //                 )
  //               ],
  //             ),
  //             SizedBox(height: space300),
  //             Visibility(
  //               visible: data.status == TransactionStatus.pending ? true : false,
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Expanded(
  //                     child: Row(
  //                       children: [
  //                         SvgPicture.asset(
  //                           "assets/images/ic_notification.svg",
  //                           height: 16,
  //                           width: 16,
  //                           color: iconDarkTertiary,
  //                         ),
  //                         SizedBox(width: space200),
  //                         Expanded(
  //                           child: Text(
  //                             "Bayar sebelum ${data.expiryTime?.convert(format: 'dd MMM yyyy HH:mm')}",
  //                             style: xxsMedium.copyWith(color: textNeutralSecondary),
  //                           ),
  //                         )
  //                       ],
  //                     ),
  //                   ),
  //                   CustomButton(
  //                     child: Text("Bayar"),
  //                     width: 71,
  //                     onPressed: () {
  //                       if (data.paymentLink != null) {
  //                         Navigator.push(
  //                           context,
  //                           MaterialPageRoute(
  //                             builder: (context) => PaymentWebviewScreen(
  //                               paymentUrl: data.paymentLink ?? "",
  //                               onPaymentComplete: (status, id) {},
  //                             ),
  //                           ),
  //                         ).then((e) {
  //                           _historyTransactionCubit.setStatus(null);
  //                         });
  //                       }
  //                     },
  //                   )
  //                 ],
  //               ),
  //             ),
  //             Visibility(
  //               visible: data.status == TransactionStatus.paid ? true : false,
  //               child: GestureDetector(
  //                 onTap: () {
  //                   if (data.status == TransactionStatus.waiting) {
  //                     Navigator.push(
  //                       context,
  //                       MaterialPageRoute(
  //                         builder: (context) => ApprovalStatusScreen(
  //                           transactionId: data.id ?? "",
  //                           paymentCode: data.paymentCode ?? "",
  //                         ),
  //                       ),
  //                     );
  //                   } else {
  //                     Navigator.push(
  //                       context,
  //                       MaterialPageRoute(
  //                         builder: (context) => TransactionDetailScreen(
  //                           id: data.id ?? "",
  //                         ),
  //                       ),
  //                     );
  //                   }
  //                 },
  //                 child: Container(
  //                   height: 36,
  //                   decoration: BoxDecoration(
  //                     border: Border.all(color: Colors.grey[300]!),
  //                     borderRadius: BorderRadius.circular(borderRadius200),
  //                   ),
  //                   child: Center(
  //                     child: Text(
  //                       "Lihat Detail",
  //                       style: smMedium,
  //                       textAlign: TextAlign.center,
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
  //
  // TabBar _buildTabBar() {
  //   return TabBar(
  //     onTap: (index) {
  //       fetchDataByStatus(index);
  //     },
  //     padding: EdgeInsets.zero,
  //     tabAlignment: TabAlignment.fill,
  //     labelPadding: const EdgeInsets.symmetric(vertical: spacing5),
  //     labelStyle: sSemiBold.copyWith(color: textPrimary),
  //     unselectedLabelStyle: sSemiBold.copyWith(color: textDisabled),
  //     dividerColor: Colors.transparent,
  //     indicatorColor: bgFillPrimary,
  //     indicatorPadding: const EdgeInsets.symmetric(horizontal: space400),
  //     tabs: const [
  //       Row(
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           Text("Tagihan Aktif"),
  //         ],
  //       ),
  //       Row(
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           Text("Berhasil"),
  //         ],
  //       ),
  //       Row(
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           Text("Dibatalkan"),
  //         ],
  //       ),
  //     ],
  //   );
  // }
  //
  // void fetchDataByStatus(int index) {
  //   switch (index) {
  //     case 0:
  //       _historyTransactionCubit.setStatus(null);
  //       break;
  //     case 1:
  //       _historyTransactionCubit.setStatus(TransactionStatus.paid.jsonValue);
  //       break;
  //     case 2:
  //       _historyTransactionCubit.setStatus(TransactionStatus.cancelled.jsonValue);
  //       break;
  //   }
  // }
}
