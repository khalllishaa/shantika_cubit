import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nested/nested.dart';
import 'package:shantika_cubit/utility/extensions/date_time_extensions.dart';
import 'package:shantika_cubit/utility/extensions/int_extension.dart';
import 'package:shantika_cubit/utility/extensions/show_toast.dart';import '../../config/constant.dart';
import '../../model/address_model.dart';
import '../../model/application_model.dart';
import '../../model/equipment_support_model.dart';
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
import 'package:with_space_between/with_space_between.dart';

// ignore: must_be_immutable
class OrderSummaryEventScreen extends StatefulWidget {
  OrderSummaryEventScreen({
    super.key,
    required this.address,
    required this.startTime,
    required this.endTime,
    this.guardClass,
    required this.guardTypeId,
    required this.reason,
    required this.startDate,
    required this.endDate,
    required this.equipmentSupportList,
    required this.guardCount,
    required this.isTechicalMeeting,
    required this.isIncludeMeals,
    required this.picName,
    required this.phone,
    required this.eventName,
  });
  final String reason;
  final AddressModel address;
  final String guardTypeId;
  final DateTime startDate;
  final DateTime endDate;
  final String startTime;
  final String endTime;
  final GuardClassModel? guardClass;
  final List<EquipmentSupportModel> equipmentSupportList;
  final int guardCount;
  final bool isTechicalMeeting;
  final bool isIncludeMeals;
  final String picName;
  final String phone;
  final String eventName;

  @override
  State<OrderSummaryEventScreen> createState() => _OrderSummaryEventScreenState();
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

/// FINAL PRICE AFTER DISC
int finalPriceAfterDisc = 0;

/// XENDIT FEE & ADMIN FEE
int? xenditFee;
int? adminFee;

late CreateTransactionCubit _createTransactionCubit;

late GuardCheckAvailibilityCubit _guardCheckAvailibilityCubit;

late PromoCheckCubit _promoCheckCubit;

late InformationApplicationCubit _informationApplicationCubit;

final _noteController = TextEditingController();

class _OrderSummaryEventScreenState extends State<OrderSummaryEventScreen> {
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
    // _createTransactionCubit = context.read();
    // _createTransactionCubit.init();
    //
    // _guardCheckAvailibilityCubit = context.read();
    // _guardCheckAvailibilityCubit.init();
    //
    // _promoCheckCubit = context.read();
    // _promoCheckCubit.init();
    //
    // _informationApplicationCubit = context.read();
    // _informationApplicationCubit.init();
    // _informationApplicationCubit.informationApp();

    return Column();
    // return _buildMainView(context);
  }

  // Widget _buildMainView(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('Ringkasan Pemesanan (Event)'),
  //     ),
  //     body: SingleChildScrollView(
  //       child: Padding(
  //         padding: const EdgeInsets.all(space400),
  //         child: MultiBlocListener(
  //           listeners: orderSummaryListener,
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               _buildAddressView(),
  //               SizedBox(height: space300),
  //               _buildFormView(),
  //               SizedBox(height: space300),
  //               _buildPromoView(),
  //               SizedBox(height: space400),
  //               _buildPaymentMethodView(context),
  //               SizedBox(height: space800),
  //               _detailedCostView(),
  //               SizedBox(height: space800),
  //               _buildPaymentView(),
  //               SizedBox(height: space800),
  //               _buildTotalView(),
  //               SizedBox(height: space800),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
  //
  // Widget _buildTotalView() {
  //   String startTime = widget.startTime;
  //   String endTime = widget.endTime;
  //
  //   List<String> startSplit = startTime.split(":");
  //   List<String> endSplit = endTime.split(":");
  //
  //   int startHour = int.parse(startSplit[0]);
  //   int startMinute = int.parse(startSplit[1]);
  //
  //   int endHour = int.parse(endSplit[0]);
  //   int endMinute = int.parse(endSplit[1]);
  //
  //   DateTime startDateTime = widget.startDate.add(Duration(hours: startHour, minutes: startMinute));
  //   DateTime endDateTime = widget.endDate.add(Duration(hours: endHour, minutes: endMinute));
  //
  //   Duration difference = endDateTime.difference(startDateTime);
  //
  //   int hoursDiff = difference.inHours;
  //   int totalPrice = hoursDiff * (widget.guardClass?.hourlyPrice ?? 0);
  //
  //   int allPriceOfEquipments = widget.equipmentSupportList.fold(
  //     0,
  //     (sum, e) => sum + ((e.selectedQty ?? 0) * (e.rentPrice ?? 0)),
  //   );
  //
  //   return BlocBuilder<InformationApplicationCubit, InformationApplicationState>(
  //     builder: (context, state) {
  //       ApplicationModel? application = state is InformationApplicationStateSuccess ? state.data : null;
  //       xenditFee = application?.xenditFee ?? 0;
  //       adminFee = application?.adminFees ?? 0;
  //
  //       int technicalMeetingPrice = widget.isTechicalMeeting ? (application?.technicalMeetingPrice ?? 0) : 0;
  //       int includesMealsPrice = widget.isIncludeMeals ? (application?.includesMealsPrice ?? 0) : 0;
  //
  //       finalPrice = totalPrice + allPriceOfEquipments;
  //
  //       finalPriceAfterDisc = finalPrice +
  //           technicalMeetingPrice +
  //           includesMealsPrice +
  //           (xenditFee ?? 0) +
  //           (adminFee ?? 0) -
  //           (discount ?? 0);
  //
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
  //               (finalPriceAfterDisc).convertRupiah(),
  //               style: xlSemiBold.copyWith(color: textDarkPrimary),
  //             ),
  //             _buildTransactionButton(),
  //           ].withSpaceBetween(height: space400),
  //         ),
  //       );
  //     },
  //   );
  // }
  //
  // Widget _buildTransactionButton() {
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
  //         GuardModel? guard = state is GuardRecomendationStateSuccess ? state.guard : null;
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
  //   return BlocBuilder<InformationApplicationCubit, InformationApplicationState>(
  //     builder: (context, state) {
  //       ApplicationModel? application = state is InformationApplicationStateSuccess ? state.data : null;
  //       return Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text('Biaya Pembayaran', style: mdSemiBold),
  //           SizedBox(height: space300),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               Text('Harga Layanan', style: xsRegular.copyWith(color: textDarkSecondary)),
  //               Text((application?.xenditFee ?? 0).convertRupiah(), style: xsSemiBold),
  //             ],
  //           ),
  //           SizedBox(height: space200),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               Text('Biaya Admin', style: xsRegular.copyWith(color: textDarkSecondary)),
  //               Text((application?.adminFees ?? 0).convertRupiah(), style: xsSemiBold),
  //             ],
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
  //
  // Widget _buildCostItemView() {
  //   String startTime = widget.startTime;
  //   String endTime = widget.endTime;
  //
  //   List<String> startSplit = startTime.split(":");
  //   List<String> endSplit = endTime.split(":");
  //
  //   int startHour = int.parse(startSplit[0]);
  //   int startMinute = int.parse(startSplit[1]);
  //
  //   int endHour = int.parse(endSplit[0]);
  //   int endMinute = int.parse(endSplit[1]);
  //
  //   DateTime startDateTime = widget.startDate.add(Duration(hours: startHour, minutes: startMinute));
  //   DateTime endDateTime = widget.endDate.add(Duration(hours: endHour, minutes: endMinute));
  //
  //   Duration difference = endDateTime.difference(startDateTime);
  //
  //   int hoursDiff = difference.inHours;
  //   int totalPrice = hoursDiff * (widget.guardClass?.hourlyPrice ?? 0);
  //
  //   int allPriceOfEquipments = widget.equipmentSupportList.fold(
  //     0,
  //     (sum, e) => sum + ((e.selectedQty ?? 0) * (e.rentPrice ?? 0)),
  //   );
  //
  //   return BlocBuilder<InformationApplicationCubit, InformationApplicationState>(
  //     builder: (context, state) {
  //       ApplicationModel? application = state is InformationApplicationStateSuccess ? state.data : null;
  //       int technicalMeetingPrice = widget.isTechicalMeeting ? application?.technicalMeetingPrice ?? 0 : 0;
  //       int includesMealsPrice = widget.isIncludeMeals ? application?.includesMealsPrice ?? 0 : 0;
  //       finalPrice = totalPrice + allPriceOfEquipments + technicalMeetingPrice + includesMealsPrice;
  //       int finalPriceAfterDisc = finalPrice - (discount ?? 0);
  //       return Column(
  //         children: [
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               Text('Penugasan Event', style: xsSemiBold.copyWith(color: textDarkSecondary)),
  //               Text('${hoursDiff}j', style: xsRegular.copyWith(color: textDarkTertiary))
  //             ],
  //           ),
  //           SizedBox(height: space200),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               Text(
  //                 '${hoursDiff}j × ${widget.guardClass?.hourlyPrice?.convertRupiah()}',
  //                 style: xsRegular.copyWith(color: textDarkTertiary),
  //               ),
  //               Text(totalPrice.convertRupiah(), style: xsSemiBold),
  //             ],
  //           ),
  //           if (widget.equipmentSupportList.isNotEmpty) ...[
  //             SizedBox(height: space300),
  //             ...widget.equipmentSupportList.map((e) {
  //               int totalPrice = (e.selectedQty ?? 0) * (e.rentPrice ?? 0);
  //               return Column(
  //                 children: [
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       Text(
  //                         '${e.selectedQty}x ${e.name}',
  //                         style: xsRegular.copyWith(color: textDarkTertiary),
  //                       ),
  //                       Text(totalPrice.convertRupiah(), style: xsSemiBold),
  //                     ],
  //                   ),
  //                 ],
  //               );
  //             }).toList(),
  //           ],
  //           Visibility(
  //             visible: widget.isTechicalMeeting,
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Text(
  //                   'Technical Meeting',
  //                   style: xsRegular.copyWith(color: textDarkTertiary),
  //                 ),
  //                 Text((application?.technicalMeetingPrice ?? 0).convertRupiah(), style: xsSemiBold),
  //               ],
  //             ),
  //           ),
  //           Visibility(
  //             visible: widget.isIncludeMeals,
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Text(
  //                   'Include makan siang',
  //                   style: xsRegular.copyWith(color: textDarkTertiary),
  //                 ),
  //                 Text((application?.includesMealsPrice ?? 0).convertRupiah(), style: xsSemiBold),
  //               ],
  //             ),
  //           ),
  //           SizedBox(height: space200),
  //           DottedLine(
  //             direction: Axis.horizontal,
  //             dashLength: 5.0,
  //             dashGapLength: 2,
  //             dashColor: bgDisabled,
  //           ),
  //           SizedBox(height: space200),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               Text(
  //                 'Diskon',
  //                 style: xsRegular.copyWith(color: textDarkTertiary),
  //               ),
  //               Text('-' + (discount ?? 0).convertRupiah(), style: xsSemiBold),
  //             ],
  //           ),
  //           SizedBox(height: space200),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               Text(
  //                 'Subtotal',
  //                 style: xsRegular.copyWith(color: textDarkTertiary),
  //               ),
  //               Text(
  //                 (finalPriceAfterDisc).convertRupiah(),
  //                 style: xsSemiBold,
  //               ),
  //             ],
  //           ),
  //         ],
  //       );
  //     },
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
  //   String startTime = widget.startTime;
  //   String endTime = widget.endTime;
  //
  //   List<String> startSplit = startTime.split(":");
  //   List<String> endSplit = endTime.split(":");
  //
  //   int startHour = int.parse(startSplit[0]);
  //   int startMinute = int.parse(startSplit[1]);
  //
  //   int endHour = int.parse(endSplit[0]);
  //   int endMinute = int.parse(endSplit[1]);
  //
  //   DateTime startDateTime = widget.startDate.add(Duration(hours: startHour, minutes: startMinute));
  //   DateTime endDateTime = widget.endDate.add(Duration(hours: endHour, minutes: endMinute));
  //
  //   Duration difference = endDateTime.difference(startDateTime);
  //
  //   int days = difference.inDays;
  //   int hours = difference.inHours % 24;
  //
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text('Pengamanan Pribadi', style: mdSemiBold),
  //       SizedBox(height: space400),
  //       _infoTextView('Durasi', '${days} Hari  ${hours} Jam'),
  //       SizedBox(height: space400),
  //       _infoTextView('Tujuan Pengamanan', '${widget.reason}'),
  //       SizedBox(height: space400),
  //       _infoTextView('Jadwal mulai', '${widget.startDate.convert(format: "EEEE, d MMMM y")}, ${widget.startTime} WIB'),
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
  //         // Container(
  //         //   height: 36,
  //         //   width: 36,
  //         //   decoration: BoxDecoration(
  //         //     shape: BoxShape.rectangle,
  //         //     color: isSelected ? iconSuccess : secondaryColor,
  //         //     borderRadius: const BorderRadius.all(Radius.circular(12)),
  //         //   ),
  //         //   child: Center(
  //         //     child: InkWell(
  //         //       onTap: () async {
  //         //         final result = await Navigator.push(
  //         //           context,
  //         //           MaterialPageRoute(
  //         //             builder: (context) => PaymentMethodsScreen(
  //         //               offlinePaymentMethodModel: _selectedOfflinePaymentMethod,
  //         //               paymentMethod: _selectedPaymentMethod,
  //         //               onPaymentMethodSelected: (paymentMethod, offline) {
  //         //                 setState(() {
  //         //                   _selectedOfflinePaymentMethod = offline;
  //         //                   _selectedPaymentMethod = paymentMethod;
  //         //                 });
  //         //               },
  //         //             ),
  //         //           ),
  //         //         );
  //         //         if (result != null) {
  //         //           setState(() {
  //         //             _selectedPaymentMethod = result;
  //         //           });
  //         //         }
  //         //       },
  //         //       child: SvgPicture.asset(
  //         //         isSelected ? 'assets/images/ic_tick_circle.svg' : 'assets/images/ic_caret_circle_right.svg',
  //         //         height: 16,
  //         //         width: 16,
  //         //         color: black50,
  //         //       ),
  //         //     ),
  //         //   ),
  //         // ),
  //       ],
  //     ),
  //   );
  // }
  //
  // Widget _buildPromoView() {
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
  //         GuardModel? guard = state is GuardRecomendationStateSuccess ? state.guard : null;
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
  //               // Container(
  //               //   height: 36,
  //               //   width: 36,
  //               //   decoration: BoxDecoration(
  //               //     shape: BoxShape.rectangle,
  //               //     color: isSelected ? iconSuccess : secondaryColor,
  //               //     borderRadius: const BorderRadius.all(Radius.circular(12)),
  //               //   ),
  //               //   child: Center(
  //               //     child: InkWell(
  //               //       onTap: () async {
  //               //         final result = await Navigator.push(
  //               //           context,
  //               //           MaterialPageRoute(builder: (context) => PromoScreen()),
  //               //         );
  //               //
  //               //         if (result != null) {
  //               //           _selectedPromo = result;
  //               //           _promoCheckCubit.checkPromo(
  //               //             guard: guard,
  //               //             request: createTransactionRequest(finalPrice: finalPriceAfterDisc, guard: guard),
  //               //           );
  //               //           setState(() {});
  //               //         }
  //               //       },
  //               //       child: SvgPicture.asset(
  //               //         isSelected ? 'assets/images/ic_tick_circle.svg' : 'assets/images/ic_caret_circle_right.svg',
  //               //         height: 16,
  //               //         width: 16,
  //               //         color: black50,
  //               //       ),
  //               //     ),
  //               //   ),
  //               // ),
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
  //   _createTransactionCubit.createTransaction(
  //     request: createTransactionRequest(finalPrice: finalPriceAfterDisc, guard: guard),
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
  //     payAmount: finalPriceAfterDisc,
  //     programs: [
  //       Program(
  //         guard: guard?.copyWith(
  //           id: null,
  //           guardClassId: widget.guardClass?.id,
  //           isGuardRecomendation: true,
  //           securityObjective: widget.reason,
  //           numberOfGuard: widget.guardCount,
  //           isTechicalMeeting: widget.isTechicalMeeting,
  //           isIncludeMeals: widget.isIncludeMeals,
  //         ),
  //         guardTypeId: widget.guardTypeId,
  //         type: "EVENT_SECURITY",
  //         startTime: "${widget.startDate.convert(format: "yyyy-MM-dd")} ${widget.startTime.padLeft(2, '0')}:00",
  //         endTime: "${widget.endDate.convert(format: "yyyy-MM-dd")} ${widget.endTime.padLeft(2, '0')}:00",
  //         note: _noteController.text,
  //         equipmentSupports: List.generate(
  //           widget.equipmentSupportList.length,
  //           (i) => EquipmentSupportModel().copyWith(
  //             id: widget.equipmentSupportList[i].id,
  //             quantity: widget.equipmentSupportList[i].selectedQty,
  //           ),
  //         ),
  //         user: UserModel(
  //           userAddressId: widget.address.id ?? "",
  //           picName: widget.picName,
  //           eventName: widget.eventName,
  //           phone: widget.phone,
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
