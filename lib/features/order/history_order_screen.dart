import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shantika_cubit/features/order/cubit/order_cubit.dart';
import 'package:shantika_cubit/features/order/cubit/order_state.dart';
import 'package:shantika_cubit/features/order/order_detail_screen.dart';
import 'package:shantika_cubit/model/history_order_model.dart';
import 'package:shantika_cubit/ui/color.dart';
import 'package:shantika_cubit/ui/typography.dart';
import '../../ui/dimension.dart';
import '../../ui/shared_widget/custom_button.dart';
import '../../ui/shared_widget/custom_card_container.dart';

class HistoryOrderScreen extends StatefulWidget {
  const HistoryOrderScreen({super.key});

  @override
  State<HistoryOrderScreen> createState() => _HistoryOrderScreenState();
}

class _HistoryOrderScreenState extends State<HistoryOrderScreen> {
  @override
  void initState() {
    super.initState();
    _loadHistoryOrder();
  }

  void _loadHistoryOrder() {
    context.read<OrderCubit>().loadHistoryOrder();
  }

  Future<void> _onRefresh() async {
    await context.read<OrderCubit>().refreshHistoryOrder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black00,
      appBar: _header(context),
      body: SafeArea(
        child: BlocBuilder<OrderCubit, OrderState>(
          builder: (context, state) {
            if (state is OrderLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is OrderError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 64,
                      color: red100,
                    ),
                    SizedBox(height: spacing4),
                    Text(
                      'Error',
                      style: xlSemiBold,
                    ),
                    SizedBox(height: spacing2),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: paddingL),
                      child: Text(
                        state.message,
                        style: mdRegular,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: spacing6),
                    ElevatedButton.icon(
                      onPressed: _loadHistoryOrder,
                      icon: Icon(Icons.refresh),
                      label: Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            if (state is OrderLoaded) {
              if (state.data.order.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/img_order.png',
                        width: 200
                      ),
                      SizedBox(height: spacing4),
                      Text(
                        'Belum ada riwayat pesanan',
                        style: mdRegular.copyWith(
                          color: black700_70,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: _onRefresh,
                child: ListView.separated(
                  padding: EdgeInsets.all(paddingL),
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: state.data.order.length,
                  separatorBuilder: (_, __) => SizedBox(height: spacing3),
                  itemBuilder: (context, index) {
                    final order = state.data.order[index];
                    return _orderCard(context, order);
                  },
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  PreferredSizeWidget _header(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight + 4),
      child: Container(
        decoration: BoxDecoration(
          color: black00,
          boxShadow: [
            BoxShadow(
              color: black950.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: black950),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            "Riwayat",
            style: xlSemiBold,
          ),
          centerTitle: true,
        ),
      ),
    );
  }

  Widget _orderCard(BuildContext context, Order order) {
    final formattedDate = DateFormat('dd MMMM yyyy • HH:mm', 'id_ID')
        .format(order.createdAtDateTime);

    Color statusColor;
    switch (order.status.toLowerCase()) {
      case 'lunas':
      case 'paid':
        statusColor = green400;
        break;
      case 'sudah ditukarkan':
      case 'redeemed':
        statusColor = navy500;
        break;
      case 'sudah direview':
      case 'reviewed':
        statusColor = navy600;
        break;
      default:
        statusColor = black400;
    }

    final formattedPrice = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    ).format(order.price);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPesananScreen(
              pesananData: {
                'id': order.id,
                'code_order': order.codeOrder,
                'title': '${order.nameFleet} • ${order.fleetClass}',
                'status': order.status,
                'date': formattedDate,
                'from': '${order.checkpoints.start.agencyName} - ${order.checkpoints.start.cityName}',
                'to': '${order.checkpoints.destination.agencyName} - ${order.checkpoints.destination.cityName}',
                'depart_time': order.departureAt,
                'price': formattedPrice,
              },
            ),
          ),
        );
      },
      child: CustomCardContainer(
        borderRadius: borderRadius300,
        margin: EdgeInsets.symmetric(vertical: paddingS),
        padding: EdgeInsets.all(padding12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    '${order.nameFleet} • ${order.fleetClass}',
                    style: smMedium,
                  ),
                ),
                IntrinsicWidth(
                  child: CustomButton(
                    onPressed: () {},
                    borderRadius: borderRadius750,
                    backgroundColor: statusColor,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    child: Text(
                      order.status,
                      style: xsMedium.copyWith(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: space100),

            // Tanggal pemesanan
            Text(
              formattedDate,
              style: xsRegular.copyWith(color: black400),
            ),
            SizedBox(height: spacing4),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.location_pin, color: black700_70, size: 20),
                SizedBox(width: space200),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${order.checkpoints.start.agencyName} - ${order.checkpoints.start.cityName}',
                        style: xsMedium,
                      ),
                      SizedBox(height: space150),
                      Text(
                        order.departureAt,
                        style: xxsRegular,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: spacing4),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.location_pin, color: navy400, size: 20),
                SizedBox(width: space200),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${order.checkpoints.destination.agencyName} - ${order.checkpoints.destination.cityName}',
                        style: xsMedium,
                      ),
                      SizedBox(height: space150),
                      Text(
                        'Estimasi tiba',
                        style: xxsRegular.copyWith(color: black400),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Harga
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                formattedPrice,
                style: mdSemiBold.copyWith(color: navy400),
              ),
            ),
            SizedBox(height: spacing5),
          ],
        ),
      ),
    );
  }
}