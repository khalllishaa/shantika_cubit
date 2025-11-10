import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:shantika_cubit/features/profile/cubit/privacy_policy_cubit.dart';
import 'package:shantika_cubit/features/profile/cubit/privacy_policy_state.dart';
import 'package:shantika_cubit/ui/color.dart';
import 'package:shantika_cubit/ui/dimension.dart';
import 'package:shantika_cubit/ui/typography.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PrivacyPolicyCubit>().fetchPrivacyPolicy();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _header(),
      body: BlocBuilder<PrivacyPolicyCubit, PrivacyPolicyState>(
        builder: (context, state) {
          if (state is PrivacyPolicyLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is PrivacyPolicyError) {
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: padding16, horizontal: padding20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: red50,
                      size: iconXL,
                    ),
                    SizedBox(height: spacing4),
                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: smMedium,
                    ),
                    SizedBox(height: space600),
                    ElevatedButton.icon(
                      onPressed: () {
                        context.read<PrivacyPolicyCubit>().fetchPrivacyPolicy();
                      },
                      icon: Icon(Icons.refresh),
                      label: Text('Coba Lagi'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF1A3A6E),
                        foregroundColor: black00,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          if (state is PrivacyPolicyLoaded) {
            final data = state.privacyPolicy;

            return RefreshIndicator(
              onRefresh: () =>
                  context.read<PrivacyPolicyCubit>().fetchPrivacyPolicy(),
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: padding20, vertical: padding16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HtmlWidget(
                      data.content,
                      textStyle: smMedium.copyWith(color: black750),
                    ),
                    SizedBox(height: space600),
                    // Footer info
                    Container(
                      padding: EdgeInsets.all(paddingS),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Terakhir diperbarui:',
                            style: xsMedium,
                          ),
                          SizedBox(height: space200),
                          Text(
                            _formatDate(data.updatedAt),
                            style: xsRegular,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return SizedBox();
        },
      ),
    );
  }

  PreferredSizeWidget _header() {
    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight + 4),
      child: Container(
        decoration: BoxDecoration(
          color: black00,
          boxShadow: [
            BoxShadow(
              color: black950.withOpacity(0.08),
              blurRadius: 8,
              offset: Offset(0, 3),
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
          title: Text("Kebijakan Privasi", style: xlMedium),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }
}