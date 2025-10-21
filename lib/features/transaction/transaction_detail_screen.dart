import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shantika_cubit/utility/extensions/int_extension.dart';
import 'package:shantika_cubit/utility/extensions/widget_extensions.dart';

import '../../config/constant.dart';
import '../../model/equipment_support_model.dart';
import '../../model/guard_history_equipment_support_model.dart';
import '../../model/transaction_detail_model.dart';
import '../../ui/color.dart';
import '../../ui/dimension.dart';
import '../../ui/shared_widget/common_appbar.dart';
import '../../ui/shared_widget/custom_button.dart';
import '../../ui/shared_widget/error_view.dart';
import '../../ui/typography.dart';
import '../../utility/dialog_utils.dart';
import 'cubit/cancel_transaction_cubit.dart';
import 'cubit/detail_history_transaction_cubit.dart';

// ignore: must_be_immutable
class TransactionDetailScreen extends StatelessWidget {
  TransactionDetailScreen({super.key, required this.id});
  final String id;

  late DetailHistoryTransactionCubit _detailHistoryTransactionCubit;
  late CancelTransactionCubit _cancelTransactionCubit;

  final String image = "assets/images/img_credit_card.png";
  final String title = "Batalkan Transaksi?";
  final String content = "Langkah anda tinggal sedikit lagi, apakah anda yakin ingin membatalkan transaksi saat ini?";

  @override
  Widget build(BuildContext context) {
    _detailHistoryTransactionCubit = context.read();
    _detailHistoryTransactionCubit.init();
    _detailHistoryTransactionCubit.detailHistory(id: id);

    _cancelTransactionCubit = context.read();
    _cancelTransactionCubit.init();

    return Scaffold(
      appBar: CommonAppbar(
        leading: true,
        title: "Detail Pembayaran",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: space400, vertical: space400),
        child: SingleChildScrollView(
          child: BlocListener<CancelTransactionCubit, CancelTransactionState>(
            listener: (context, state) {
              if (state is CancelTransactionStateSuccess) {
                _detailHistoryTransactionCubit.detailHistory(id: id);
              }
            },
            child: BlocBuilder<DetailHistoryTransactionCubit, DetailHistoryTransactionState>(
              builder: (context, state) {
                if (state is DetailHistoryTransactionStateSuccess) {
                  TransactionDetailModel? data = state.transaction;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Image.asset(
                          "assets/images/img_approved.png",
                          height: 100,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: space250, vertical: space200),
                          decoration: BoxDecoration(
                            color: data.status?.color,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Text(
                            data.status?.jsonValue ?? "-",
                            style: xsMedium.copyWith(color: black50),
                          ),
                        ),
                      ),
                      SizedBox(height: space400),
                      _buildAddress(data),
                      SizedBox(height: space400),
                      _buildSupportFee(data.guardHistory?.guardHistoryEquipmentSupports ?? []),
                      SizedBox(height: space400),
                      _buildCostBreakdown(data),
                      SizedBox(height: space600),
                      _buildTotalPrice(context, data),
                    ],
                  );
                } else if (state is DetailHistoryTransactionStateError) {
                  return ErrorView(title: "Oopss", desc: state.message);
                } else {
                  return _builLoadingView();
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAddress(TransactionDetailModel? data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Alamat Pengerjaan", style: mdSemiBold),
        SizedBox(height: space200),
        Text(
          data?.guardHistory?.userAddress?.address ?? "",
          style: xsRegular.copyWith(color: textDarkTertiary),
        ),
      ],
    );
  }

  Widget _buildSupportFee(List<GuardHistoryEquipmentSupportModel> items) {
    return Visibility(
      visible: items.isNotEmpty,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Biaya Support",
            style: mdSemiBold,
          ),
          SizedBox(height: space200),
          Column(
            children: items.map((item) => _buildItemRow(item.equipmentSupport, item.quantity ?? 0)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCostBreakdown(TransactionDetailModel data) {
    bool isMonthly = data.guardHistory?.guardType?.type == "MONTHLY_PERSONAL_SECURITY";
    Duration difference = (data.guardHistory?.endTime ?? DateTime.now()).difference(
      data.guardHistory?.startTime ?? DateTime.now(),
    );
    int hoursDiff = isMonthly ? difference.inDays : difference.inHours;
    int adminFee = data.adminFee ?? 0;
    int xenditFee = data.xenditFee ?? 0;

    int totalHoursPrice = isMonthly
        ? (data.guardHistory?.guardClass?.dailyPrice ?? 0) * hoursDiff
        : (data.guardHistory?.guardClass?.hourlyPrice ?? 0) * hoursDiff;

    int allPriceOfEquipments = data.guardHistory?.guardHistoryEquipmentSupports?.fold(
          0,
          (sum, e) => (sum ?? 0) + ((e.quantity ?? 0) * (e.equipmentSupport?.rentPrice ?? 0)),
        ) ??
        0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Rincian Biaya", style: mdSemiBold),
        SizedBox(height: space200),
        Text('${data.guardHistory?.guardType?.name}', style: xsSemiBold.copyWith(color: textDarkSecondary)),
        SizedBox(height: space200),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${hoursDiff} ${isMonthly ? 'Hari' : 'Jam'}', style: xsSemiBold),
            Text((totalHoursPrice).convertRupiah(), style: xsSemiBold),
          ],
        ),
        SizedBox(height: space200),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Total Biaya Equipment', style: xsSemiBold),
            Text((allPriceOfEquipments).convertRupiah(), style: xsSemiBold),
          ],
        ),
        SizedBox(height: space200),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Biaya Admin', style: xsSemiBold),
            Text((adminFee).convertRupiah(), style: xsSemiBold),
          ],
        ),
        SizedBox(height: space200),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Biaya Aplikasi', style: xsSemiBold),
            Text((xenditFee).convertRupiah(), style: xsSemiBold),
          ],
        ),
        SizedBox(height: space200),
        DottedLine(
          direction: Axis.horizontal,
          dashLength: 5.0,
          dashGapLength: 2,
          dashColor: bgDisabled,
        ),
        SizedBox(height: space200),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Diskon',
              style: xsRegular.copyWith(color: textDarkTertiary),
            ),
            Text((data.discountPromo ?? 0).convertRupiah(), style: xsSemiBold),
          ],
        ),
      ],
    );
  }

  Widget _buildTotalPrice(BuildContext context, TransactionDetailModel data) {
    int adminFee = data.adminFee ?? 0;
    int xenditFee = data.xenditFee ?? 0;
    int priceAfterDisc = (data.payAmount ?? 0) - (data.discountPromo ?? 0);
    int finalPrice = priceAfterDisc;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Total:", style: mdMedium.copyWith(color: textNeutralSecondary)),
        SizedBox(height: space100),
        Text((finalPrice).convertRupiah(), style: xlSemiBold),
        SizedBox(height: space400),
        CustomButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                data.status == TransactionStatus.waiting
                    ? "assets/images/ic_empty_wallet.svg"
                    : data == TransactionStatus.cancelled
                        ? "assets/images/ic_bag.svg"
                        : data == TransactionStatus.paid
                            ? "assets/images/ic_import.svg"
                            : "assets/images/ic_import.svg",
                color: iconWhite,
              ),
              SizedBox(width: space200),
              Text("Bayar Sekarang", style: smMedium)
            ],
          ),
          onPressed: () {},
        ),
        SizedBox(height: space200),
        Visibility(
          visible: data.status == TransactionStatus.waiting,
          child: GestureDetector(
            onTap: () {
              DialogUtils.showCancelTrxDialog(
                context,
                () {
                  Navigator.pop(context);
                  _cancelTransactionCubit.cancelTransaction(id: id);
                },
              );
            },
            child: Container(
              height: 46,
              decoration: BoxDecoration(
                // color: bgFillSecondary,
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(borderRadius200),
              ),
              child: Center(
                child: Text(
                  "Batalkan Transaksi",
                  style: smMedium,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildItemRow(EquipmentSupportModel? item, int selectedQty) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(item?.name ?? '', style: xsSemiBold.copyWith(color: textDarkSecondary)),
        SizedBox(height: space100),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${selectedQty}x ${item?.rentPrice ?? "-"}',
              style: xsRegular.copyWith(color: textDarkSecondary),
            ),
            Text(((item?.rentPrice ?? 0) * (selectedQty)).convertRupiah(), style: xsSemiBold),
          ],
        ),
        SizedBox(height: space200),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            25,
            (index) => Container(
              width: 5,
              height: 2,
              color: Colors.grey,
            ),
          ),
        ),
        SizedBox(height: space200),
      ],
    );
  }
}

Widget _builLoadingView() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: space400),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Image.asset(
            "assets/images/img_approved.png",
            height: 100,
          ),
        ),
        Text('------------------------------------------').addShimmer(block: true),
        SizedBox(height: space300),
        Text('------------------------------------------').addShimmer(block: true),
        SizedBox(height: space300),
        Text('------------------------------------------').addShimmer(block: true),
        SizedBox(height: space300),
        Text('------------------------------------------').addShimmer(block: true),
        SizedBox(height: space300),
        Text('------------------------------------------').addShimmer(block: true),
        SizedBox(height: space300),
        Text('------------------------------------------').addShimmer(block: true),
        SizedBox(height: space300),
        Text('------------------------------------------').addShimmer(block: true),
        SizedBox(height: space300),
        Text('------------------------------------------').addShimmer(block: true),
        SizedBox(height: space300),
        Text('------------------------------------------').addShimmer(block: true),
        SizedBox(height: space300),
        Text('------------------------------------------').addShimmer(block: true),
        SizedBox(height: space300),
        Text('------------------------------------------').addShimmer(block: true),
        SizedBox(height: space300),
        Text('------------------------------------------').addShimmer(block: true),
        SizedBox(height: space300),
        SizedBox(height: space1000),
        Container(
          height: 46,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(borderRadius200),
          ),
          child: Center(
            child: Text(
              "Batalkan Transaksi",
              style: smMedium,
            ),
          ),
        ).addShimmer(block: true),
        SizedBox(height: space300),
        Container(
          height: 46,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(borderRadius200),
          ),
          child: Center(
            child: Text(
              "Batalkan Transaksi",
              style: smMedium,
            ),
          ),
        ).addShimmer(block: true),
      ],
    ),
  );
}
