import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:nested/nested.dart';
import 'package:shantika_cubit/utility/extensions/date_time_extensions.dart';
import 'package:shantika_cubit/utility/extensions/int_extension.dart';
import 'package:shantika_cubit/utility/extensions/widget_extensions.dart';
import 'package:with_space_between/with_space_between.dart';

import '../../model/guard_model.dart';
import '../../config/constant.dart';
import '../../model/address_model.dart';
import '../../model/application_model.dart';
import '../../model/guard_model.dart';
import '../../model/my_promo_model.dart';
import '../../model/payment_method_model.dart';
import '../../model/request/transaction_request.dart';
import '../../model/user_model.dart';
import '../../ui/color.dart';
import '../../ui/dimension.dart';
import '../../ui/shared_widget/circle_image_view.dart';
import '../../ui/shared_widget/custom_button.dart';
import '../../ui/shared_widget/custom_card.dart';
import '../../ui/shared_widget/custom_text_form_field.dart';
import '../../ui/shared_widget/sheet/select_guard_type_sheet.dart';
import '../../ui/typography.dart';
import '../../utility/dialog_utils.dart';
import '../navigation/navigation_screen.dart';
import 'cubit/create_transaction_cubit.dart';
import 'cubit/guard_check_availability_cubit.dart';
import 'cubit/guard_recomendation_cubit.dart';
import 'cubit/information_application_cubit.dart';
import 'cubit/promo_check_cubit.dart';

// ignore: must_be_immutable
class OrderSummaryMonthlyScreen extends StatefulWidget {
  OrderSummaryMonthlyScreen({
    super.key,
    required this.address,
    required this.startTime,
    required this.endTime,
    this.guard,
    this.guardClass,
    required this.guardTypeId,
    required this.reason,
    required this.startDate,
    required this.endDate,
    required this.monthDuration,
  });
  final String reason;
  final AddressModel address;
  final String guardTypeId;
  final DateTime startDate;
  final DateTime endDate;
  final String startTime;
  final String endTime;
  final int monthDuration;
  GuardModel? guard;
  GuardClassModel? guardClass;

  @override
  State<OrderSummaryMonthlyScreen> createState() => _OrderSummaryMonthlyScreenState();
}

/// SELECTED PROMO
MyPromoModel? _selectedPromo;

/// SELECTED PAYMENT METHOD
PaymentMethodModel? _selectedPaymentMethod;
OfflinePaymentMethodModel? _selectedOfflinePaymentMethod;

/// DISCOUNT
int? discount;

/// FINAL PRICE
int finalPrice = 0;

/// XENDIT FEE & ADMIN FEE
int? xenditFee;
int? adminFee;

late CreateTransactionCubit _createTransactionCubit;

late GuardCheckAvailibilityCubit _guardCheckAvailibilityCubit;

late GuardRecomendationCubit _guardRecomendationCubit;

late PromoCheckCubit _promoCheckCubit;

final _noteController = TextEditingController();

class _OrderSummaryMonthlyScreenState extends State<OrderSummaryMonthlyScreen> {
  @override
  void initState() {
    _selectedPaymentMethod = null;
    _selectedPromo = null;
    _selectedOfflinePaymentMethod = null;
    discount = null;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _createTransactionCubit = context.read();
    _createTransactionCubit.init();

    _guardCheckAvailibilityCubit = context.read();
    _guardCheckAvailibilityCubit.init();

    _promoCheckCubit = context.read();
    _promoCheckCubit.init();

    if (widget.guard == null) {
      _guardRecomendationCubit = context.read();
      _guardRecomendationCubit.init();
      _guardRecomendationCubit.guardRecomendation(
        guardClassId: widget.guardClass?.id ?? "",
        startTime: "${widget.startDate.convert(format: "yyyy-MM-dd")} ${widget.startTime.padLeft(2, '0')}:00",
        endTime: "${widget.endDate.convert(format: "yyyy-MM-dd")} ${widget.endTime.padLeft(2, '0')}:00",
      );
    }

    return _buildMainView(context);
  }

  Widget _buildMainView(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ringkasan Pemesanan'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(space400),
          // child: MultiBlocListener(
          //   listeners: orderSummaryListener,
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       // _buildAddressView(),
          //       // SizedBox(height: space300),
          //       // _buildFormView(),
          //       // SizedBox(height: space300),
          //       // _buildUserView(),
          //       // SizedBox(height: space300),
          //       // _buildPromoView(),
          //       // SizedBox(height: space400),
          //       // _buildPaymentMethodView(context),
          //       // SizedBox(height: space800),
          //       // _detailedCostView(),
          //       // SizedBox(height: space800),
          //       // _buildPaymentView(),
          //       // SizedBox(height: space800),
          //       // _buildTotalView(),
          //       // SizedBox(height: space800),
          //     ],
          //   ),
          // ),
        ),
      ),
    );
  }

  // Widget _buildTotalView() {
  //   int difference = widget.endDate.difference(widget.startDate).inDays;
  //   int totalPrice = difference *
  //       (widget.guardClass != null
  //           ? (widget.guardClass?.dailyPrice ?? 0)
  //           : (widget.guard?.guardClass?.dailyPrice ?? 0));
  //
  //   return BlocBuilder<InformationApplicationCubit, InformationApplicationState>(
  //     builder: (context, state) {
  //       ApplicationModel? application = state is InformationApplicationStateSuccess ? state.data : null;
  //       finalPrice = totalPrice + (application?.adminFees ?? 0) + (application?.xenditFee ?? 0) - (discount ?? 0);
  //       return Container(
  //         width: double.infinity,
  //         color: Colors.white,
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           children: [
  //             Text(
  //               "Total:",
  //               style: mdMedium.copyWith(color: textDarkSecondary),
  //             ),
  //             Text(
  //               finalPrice.convertRupiah(),
  //               style: xlSemiBold.copyWith(color: textDarkPrimary),
  //             ),
  //             _buildTransactionButton(finalPrice),
  //           ].withSpaceBetween(height: space400),
  //         ),
  //       );
  //     },
  //   );
  // }
  //
  // Widget _buildTransactionButton(int finalPrice) {
  //   return BlocProvider(
  //     create: (context) => GuardRecomendationCubit()
  //       ..init()
  //       ..guardRecomendation(
  //         guardClassId: widget.guardClass?.id ?? "",
  //         startTime: "${widget.startDate.convert(format: "yyyy-MM-dd")} ${widget.startTime.padLeft(2, '0')}:00",
  //         endTime: "${widget.endDate.convert(format: "yyyy-MM-dd")} ${widget.endTime.padLeft(2, '0')}:00",
  //       ),
  //     child: BlocBuilder<GuardRecomendationCubit, GuardRecomendationState>(
  //       builder: (context, state) {
  //         GuardModel? guard = state is GuardRecomendationStateSuccess ? state.guard : widget.guard;
  //
  //         return CustomButton(
  //           onPressed: _selectedPaymentMethod != null
  //               ? () {
  //                   _handleTransaction(context, guard);
  //                 }
  //               : null,
  //           backgroundColor: bgFillPrimary,
  //           child: Text(
  //             "Selanjutnya",
  //             style: smMedium.copyWith(color: textLightPrimary),
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }
  //
  // Row _buildGuardRecomendationErrorView(GuardRecomendationStateError state, BuildContext context) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       Text(state.message),
  //       Expanded(
  //         child: TextButton(
  //           onPressed: () async {
  //             _showSelectGuardTypeSheet(context, widget.guardTypeId);
  //           },
  //           child: Text('Ubah Kelas'),
  //         ),
  //       )
  //     ],
  //   );
  // }
  //
  // Column _detailedCostView() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text('Rincian Biaya', style: mdSemiBold),
  //       SizedBox(height: space200),
  //       _buildCostItemView(),
  //     ],
  //   );
  // }
  //
  // Widget _buildPaymentView() {
  //   return BlocProvider(
  //     create: (context) => InformationApplicationCubit()
  //       ..init()
  //       ..informationApp(),
  //     child: BlocBuilder<InformationApplicationCubit, InformationApplicationState>(
  //       builder: (context, state) {
  //         ApplicationModel? application = state is InformationApplicationStateSuccess ? state.data : null;
  //         return Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text('Biaya Pembayaran', style: mdSemiBold),
  //             SizedBox(height: space300),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Text('Harga Layanan', style: xsRegular.copyWith(color: textDarkSecondary)),
  //                 Text((application?.xenditFee ?? 0).convertRupiah(), style: xsSemiBold),
  //               ],
  //             ),
  //             SizedBox(height: space200),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Text('Biaya Admin', style: xsRegular.copyWith(color: textDarkSecondary)),
  //                 Text((application?.adminFees ?? 0).convertRupiah(), style: xsSemiBold),
  //               ],
  //             ),
  //           ],
  //         );
  //       },
  //     ),
  //   );
  // }
  //
  // Widget _buildUserView() {
  //   if (widget.guard != null) {
  //     return Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Row(
  //           children: [
  //             CircleImageView(
  //               url: '${baseImage}/${widget.guard?.avatar}',
  //               radius: 16,
  //             ),
  //             SizedBox(width: 12),
  //             Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(widget.guard?.name ?? "", style: smMedium),
  //                 Text(widget.guard?.gender == "MALE" ? "Laki-Laki" : "Perempuan"),
  //               ],
  //             ),
  //             SizedBox(width: space400),
  //             Container(
  //               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
  //               decoration: BoxDecoration(
  //                 color: bgSurfaceSecondary,
  //                 borderRadius: BorderRadius.circular(999),
  //               ),
  //               child: Text(
  //                 widget.guard?.guardClass?.name ?? "",
  //                 style: xsMedium.copyWith(color: textSecondary),
  //               ),
  //             ),
  //             Spacer(),
  //             TextButton(
  //               onPressed: () async {
  //                 GuardModel? result = await Navigator.push(
  //                   context,
  //                   MaterialPageRoute(
  //                     builder: (context) => SelectGuardScreen(initialGuard: widget.guard),
  //                   ),
  //                 );
  //
  //                 if (result != null) {
  //                   setState(() {
  //                     widget.guard = result;
  //                   });
  //                 }
  //               },
  //               child: Text('Ubah'),
  //             )
  //           ],
  //         ),
  //       ],
  //     );
  //   }
  //
  //   return BlocBuilder<GuardRecomendationCubit, GuardRecomendationState>(
  //     builder: (context, state) {
  //       GuardModel? guard = state is GuardRecomendationStateSuccess ? state.guard : widget.guard;
  //
  //       if (state is GuardRecomendationStateLoading) {
  //         return Text('Loading').addShimmer(block: true);
  //       }
  //
  //       if (state is GuardRecomendationStateError) {
  //         return _buildGuardRecomendationErrorView(state, context);
  //       }
  //
  //       return Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Row(
  //             children: [
  //               CircleImageView(
  //                 url: '${baseImage}/${guard?.avatar}',
  //                 radius: 16,
  //               ),
  //               SizedBox(width: 12),
  //               Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text(guard?.name ?? "", style: smMedium),
  //                   Text(guard?.gender == "MALE" ? "Laki-Laki" : "Perempuan"),
  //                 ],
  //               ),
  //               SizedBox(width: space400),
  //               Container(
  //                 padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
  //                 decoration: BoxDecoration(
  //                   color: bgSurfaceSecondary,
  //                   borderRadius: BorderRadius.circular(999),
  //                 ),
  //                 child: Text(
  //                   guard?.guardClass?.name ?? "",
  //                   style: xsMedium.copyWith(color: textSecondary),
  //                 ),
  //               ),
  //               Spacer(),
  //               TextButton(
  //                 onPressed: () async {
  //                   _showSelectGuardTypeSheet(context, widget.guardTypeId);
  //                 },
  //                 child: Text('Ubah Kelas'),
  //               )
  //             ],
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
  //
  // Widget _buildCostItemView() {
  //   int difference = widget.endDate.difference(widget.startDate).inDays;
  //
  //   int totalPrice = difference *
  //       (widget.guardClass != null
  //           ? (widget.guardClass?.dailyPrice ?? 0)
  //           : (widget.guard?.guardClass?.dailyPrice ?? 0));
  //   return Column(
  //     children: [
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Text('Penugasan Pribadi Per Bulan', style: xsSemiBold.copyWith(color: textDarkSecondary)),
  //           Text('${difference} Hari', style: xsRegular.copyWith(color: textDarkTertiary))
  //         ],
  //       ),
  //       SizedBox(height: space200),
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Text(
  //             '${difference} × ${widget.guardClass != null ? widget.guardClass?.dailyPrice?.convertRupiah() : widget.guard?.guardClass?.dailyPrice?.convertRupiah()}',
  //             style: xsRegular.copyWith(color: textDarkTertiary),
  //           ),
  //           Text(totalPrice.convertRupiah(), style: xsSemiBold),
  //         ],
  //       ),
  //       SizedBox(height: space200),
  //       DottedLine(
  //         direction: Axis.horizontal,
  //         dashLength: 5.0,
  //         dashGapLength: 2,
  //         dashColor: bgDisabled,
  //       ),
  //       SizedBox(height: space200),
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Text(
  //             'Diskon',
  //             style: xsRegular.copyWith(color: textDarkTertiary),
  //           ),
  //           Text('-' + (discount ?? 0).convertRupiah(), style: xsSemiBold),
  //         ],
  //       ),
  //     ],
  //   );
  // }
  //
  // Widget _buildAddressView() {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text('Alamat Pengiriman', style: mdSemiBold),
  //       SizedBox(height: space100),
  //       Text(
  //         maxLines: 2,
  //         '${widget.address.address}',
  //         style: sRegular.copyWith(color: textDarkTertiary),
  //       ),
  //     ],
  //   );
  // }
  //
  // Column _buildFormView() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text('Pengamanan Pribadi Bulan', style: mdSemiBold),
  //       SizedBox(height: space400),
  //       _infoTextView('Durasi', '${widget.monthDuration} Bulan'),
  //       SizedBox(height: space400),
  //       _infoTextView('Tujuan Pengamanan', '${widget.reason}'),
  //       SizedBox(height: space400),
  //       _infoTextView('Jadwal mulai',
  //           '${widget.startDate.convert(format: "EEE, dd MMM yyyy")} - ${widget.endDate.convert(format: "EEE, dd MMM yyyy")}'),
  //       SizedBox(height: space400),
  //       Text('Masukan Catatan', style: xsRegular.copyWith(color: textDarkTertiary)),
  //       CustomTextFormField(
  //         placeholder: 'Masukan catatan tambahan',
  //         controller: _noteController,
  //         maxLines: 5,
  //         verticalContentPadding: space400,
  //       )
  //     ],
  //   );
  // }
  //
  // Widget _buildPaymentMethodView(BuildContext context) {
  //   bool isSelected = _selectedPaymentMethod != null;
  //   return CustomCard(
  //     color: Color(isSelected ? 0xFFFAFDF1 : 0xFFFFF5ED),
  //     borderRadius: BorderRadius.circular(12),
  //     borderSide: BorderSide(color: isSelected ? iconSuccess : secondaryColor),
  //     padding: EdgeInsets.all(space400),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text('Metode Pembayaran'),
  //             Text(
  //               _selectedPaymentMethod != null
  //                   ? '${_selectedPaymentMethod?.name} ${_selectedOfflinePaymentMethod?.bankAccount ?? "-"}'
  //                   : 'Pilih Metode pembayaran',
  //               style: xsRegular.copyWith(
  //                 color: isSelected ? textSuccess : textSecondary,
  //               ),
  //             ),
  //           ],
  //         ),
  //         Container(
  //           height: 36,
  //           width: 36,
  //           decoration: BoxDecoration(
  //             shape: BoxShape.rectangle,
  //             color: isSelected ? iconSuccess : secondaryColor,
  //             borderRadius: const BorderRadius.all(Radius.circular(12)),
  //           ),
  //           child: Center(
  //             child: InkWell(
  //               onTap: () async {
  //                 final result = await Navigator.push(
  //                   context,
  //                   MaterialPageRoute(
  //                     builder: (context) => PaymentMethodsScreen(
  //                       offlinePaymentMethodModel: _selectedOfflinePaymentMethod,
  //                       paymentMethod: _selectedPaymentMethod,
  //                       onPaymentMethodSelected: (paymentMethod, offline) {
  //                         setState(() {
  //                           _selectedOfflinePaymentMethod = offline;
  //                           _selectedPaymentMethod = paymentMethod;
  //                         });
  //                       },
  //                     ),
  //                   ),
  //                 );
  //                 if (result != null) {
  //                   setState(() {
  //                     _selectedPaymentMethod = result;
  //                   });
  //                 }
  //               },
  //               child: SvgPicture.asset(
  //                 isSelected ? 'assets/images/ic_tick_circle.svg' : 'assets/images/ic_caret_circle_right.svg',
  //                 height: 16,
  //                 width: 16,
  //                 color: black50,
  //               ),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  //
  // Widget _buildPromoView() {
  //   DateFormat format = DateFormat("HH:mm");
  //   DateTime start = format.parse(widget.startTime);
  //   DateTime end = format.parse(widget.endTime);
  //   Duration difference = end.difference(start);
  //   int hoursDiff = difference.inHours;
  //   int totalPrice = hoursDiff *
  //       (widget.guardClass != null
  //           ? (widget.guardClass?.hourlyPrice ?? 0)
  //           : (widget.guard?.guardClass?.hourlyPrice ?? 0));
  //
  //   finalPrice = totalPrice + (adminFee ?? 0) + (xenditFee ?? 0);
  //   bool isSelected = _selectedPromo != null;
  //
  //   return BlocProvider(
  //     create: (context) => GuardRecomendationCubit()
  //       ..init()
  //       ..guardRecomendation(
  //         guardClassId: widget.guardClass?.id ?? "",
  //         startTime: "${widget.startDate.convert(format: "yyyy-MM-dd")} ${widget.startTime.padLeft(2, '0')}:00",
  //         endTime: "${widget.endDate.convert(format: "yyyy-MM-dd")} ${widget.endTime.padLeft(2, '0')}:00",
  //       ),
  //     child: BlocBuilder<GuardRecomendationCubit, GuardRecomendationState>(
  //       builder: (context, state) {
  //         GuardModel? guard = state is GuardRecomendationStateSuccess ? state.guard : widget.guard;
  //
  //         return CustomCard(
  //           color: Color(isSelected ? 0xFFFAFDF1 : 0xFFFFF5ED),
  //           borderRadius: BorderRadius.circular(12),
  //           borderSide: BorderSide(color: isSelected ? iconSuccess : secondaryColor),
  //           padding: EdgeInsets.all(space400),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text('Kode Promo'),
  //                   Text(
  //                     isSelected ? '${_selectedPromo?.promo?.code}' : 'Lihat promo yang kamu gunakan',
  //                     style: xsRegular.copyWith(
  //                       color: isSelected ? textSuccess : textSecondary,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               Container(
  //                 height: 36,
  //                 width: 36,
  //                 decoration: BoxDecoration(
  //                   shape: BoxShape.rectangle,
  //                   color: isSelected ? iconSuccess : secondaryColor,
  //                   borderRadius: const BorderRadius.all(Radius.circular(12)),
  //                 ),
  //                 child: Center(
  //                   child: InkWell(
  //                     onTap: () async {
  //                       final result = await Navigator.push(
  //                         context,
  //                         MaterialPageRoute(builder: (context) => PromoScreen()),
  //                       );
  //
  //                       if (result != null) {
  //                         _selectedPromo = result;
  //                         _promoCheckCubit.checkPromo(
  //                           guard: guard,
  //                           request: createTransactionRequest(finalPrice: finalPrice, guard: guard),
  //                         );
  //                         setState(() {});
  //                       }
  //                     },
  //                     child: SvgPicture.asset(
  //                       isSelected ? 'assets/images/ic_tick_circle.svg' : 'assets/images/ic_caret_circle_right.svg',
  //                       height: 16,
  //                       width: 16,
  //                       color: black50,
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }
  //
  // Widget _infoTextView(String title, String subtitle) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(title, style: xsRegular.copyWith(color: textDarkTertiary)),
  //       Text(subtitle, style: smMedium),
  //     ],
  //   );
  // }
  //
  // void _handleTransaction(BuildContext context, GuardModel? guard) {
  //   _guardCheckAvailibilityCubit.checkGuardAvailability(
  //     request: createTransactionRequest(finalPrice: finalPrice, guard: guard),
  //   );
  // }
  //
  // List<SingleChildWidget> get orderSummaryListener {
  //   return [
  //     BlocListener<InformationApplicationCubit, InformationApplicationState>(
  //       listener: (context, state) {
  //         if (state is InformationApplicationStateSuccess) {
  //           xenditFee = state.data.xenditFee ?? 0;
  //           adminFee = state.data.adminFees ?? 0;
  //         }
  //       },
  //     ),
  //     BlocListener<CreateTransactionCubit, CreateTransactionState>(
  //       listener: (context, state) {
  //         if (state is CreateTransactionStateSuccess) {
  //           DialogUtils.hideLoadingDialog(context);
  //           Navigator.pushAndRemoveUntil(
  //             context,
  //             MaterialPageRoute(
  //               builder: (context) => NavigationScreen(goToHistoryTransaction: true),
  //             ),
  //             (route) => false,
  //           );
  //           WidgetsBinding.instance.addPostFrameCallback((_) {
  //             Navigator.push(
  //               context,
  //               MaterialPageRoute(
  //                 builder: (context) => ApprovalStatusScreen(
  //                   transactionId: state.id,
  //                   paymentCode: state.paymentCode,
  //                 ),
  //               ),
  //             );
  //           });
  //         } else if (state is CreateTransactionStateError) {
  //           DialogUtils.hideLoadingDialog(context);
  //           DialogUtils.showErrorDialog(context, state.message);
  //         } else {
  //           DialogUtils.showLoadingDialog(context, "Membuat transaksi anda ...");
  //         }
  //       },
  //     ),
  //     BlocListener<PromoCheckCubit, PromoCheckState>(
  //       listener: (context, state) {
  //         if (state is PromoCheckStateSuccess) {
  //           setState(() {
  //             discount = state.discount;
  //           });
  //           DialogUtils.hideLoadingDialog(context);
  //           context.showCustomToast(title: "Berhasil", message: "Promo Berhasil Digunakan", isSuccess: true);
  //         } else if (state is PromoCheckStateError) {
  //           DialogUtils.hideLoadingDialog(context);
  //           DialogUtils.showErrorDialog(context, state.message);
  //           setState(() {
  //             _selectedPromo = null;
  //           });
  //         } else {
  //           DialogUtils.showLoadingDialog(context, "Sedang mengecek promo...");
  //         }
  //       },
  //     ),
  //     BlocListener<GuardCheckAvailibilityCubit, GuardCheckAvailibilityState>(
  //       listener: (context, state) {
  //         if (state is GuardCheckAvailibilityStateSuccess) {
  //           DialogUtils.hideLoadingDialog(context);
  //
  //           GuardModel? guard = context.read<GuardRecomendationCubit>().state is GuardRecomendationStateSuccess
  //               ? (context.read<GuardRecomendationCubit>().state as GuardRecomendationStateSuccess).guard
  //               : widget.guard;
  //
  //           int difference = widget.endDate.difference(widget.startDate).inDays;
  //           int totalPrice = difference *
  //               (widget.guardClass != null
  //                   ? (widget.guardClass?.dailyPrice ?? 0)
  //                   : (widget.guard?.guardClass?.dailyPrice ?? 0));
  //
  //           _createTransactionCubit.createTransaction(
  //             request: createTransactionRequest(finalPrice: totalPrice, guard: guard),
  //           );
  //         } else if (state is GuardCheckAvailibilityStateError) {
  //           DialogUtils.hideLoadingDialog(context);
  //
  //           DialogUtils.showErrorDialog(context, state.message);
  //         } else {
  //           DialogUtils.showLoadingDialog(context, "Sedang mengecek ketersediaan guard...");
  //         }
  //       },
  //     ),
  //   ];
  // }
  //
  // TransactionRequest createTransactionRequest({
  //   required int finalPrice,
  //   required GuardModel? guard,
  // }) {
  //   return TransactionRequest(
  //     adminFee: adminFee ?? 0,
  //     xenditFee: xenditFee ?? 0,
  //     promoClaimId: _selectedPromo?.id,
  //     paymentMethodId: _selectedPaymentMethod?.id,
  //     offlinePaymentMethodId: _selectedOfflinePaymentMethod?.id,
  //     discountPromo: discount ?? 0,
  //     payAmount: finalPrice,
  //     programs: [
  //       Program(
  //         guard: widget.guard?.copyWith(
  //               isGuardRecomendation: false,
  //               securityObjective: widget.reason,
  //               numberOfGuard: 0,
  //               isTechicalMeeting: false,
  //               isIncludeMeals: false,
  //             ) ??
  //             guard?.copyWith(
  //               isGuardRecomendation: true,
  //               securityObjective: widget.reason,
  //               numberOfGuard: 0,
  //               isTechicalMeeting: false,
  //               isIncludeMeals: false,
  //             ),
  //         guardTypeId: widget.guardTypeId,
  //         type: "MONTHLY_PERSONAL_SECURITY",
  //         startTime: "${widget.startDate.convert(format: "yyyy-MM-dd")} ${widget.startTime.padLeft(2, '0')}:00",
  //         endTime: "${widget.endDate.convert(format: "yyyy-MM-dd")} ${widget.endTime.padLeft(2, '0')}:00",
  //         note: _noteController.text,
  //         equipmentSupports: [],
  //         user: UserModel(userAddressId: widget.address.id ?? ""),
  //       ),
  //     ],
  //   );
  // }
  //
  // Future<dynamic> _showSelectGuardTypeSheet(BuildContext context, String guardTypeId) {
  //   return showMaterialModalBottomSheet(
  //     context: context,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(borderRadius300)),
  //     ),
  //     builder: (BuildContext context) {
  //       return SelectGuardTypeSheet(
  //         guardTypeId: guardTypeId,
  //         onGuardSelected: (guardClass) {
  //           if (guardClass != null) {
  //             setState(() {
  //               widget.guardClass = guardClass;
  //               _guardRecomendationCubit.guardRecomendation(
  //                 guardClassId: guardClass.id ?? "",
  //                 startTime: "${widget.startDate.convert(format: "yyyy-MM-dd")} ${widget.startTime.padLeft(2, '0')}:00",
  //                 endTime: "${widget.endDate.convert(format: "yyyy-MM-dd")} ${widget.endTime.padLeft(2, '0')}:00",
  //               );
  //             });
  //           }
  //         },
  //       );
  //     },
  //   );
  // }
}
