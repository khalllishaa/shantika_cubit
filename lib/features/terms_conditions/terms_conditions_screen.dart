import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:shantika_cubit/features/terms_conditions/cubit/terms_conditions_state.dart';
import 'package:shantika_cubit/utility/extensions/widget_extensions.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:with_space_between/with_space_between.dart';

import '../../ui/color.dart';
import '../../ui/dimension.dart';
import '../../ui/shared_widget/common_appbar.dart';
import '../../ui/shared_widget/empty_view.dart';
import '../../ui/shared_widget/error_view.dart';
import '../../ui/typography.dart';
import 'cubit/terms_conditions_cubit.dart';

// ignore: must_be_immutable
class TermsConditionsScreen extends StatefulWidget {
  const TermsConditionsScreen({super.key});

  @override
  State<TermsConditionsScreen> createState() => _TermsConditionsScreenState();
}

class _TermsConditionsScreenState extends State<TermsConditionsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TermsConditionsCubit>().fetchTermsConditions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:_header(),
      body: BlocBuilder<TermsConditionsCubit, TermsConditionsState>(
        builder: (context, state) {
          if (state is TermsConditionsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is TermsConditionsError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(padding16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: red50,
                      size: iconXL,
                    ),
                    SizedBox(height: spacing4),
                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style:smMedium,
                    ),
                    SizedBox(height: space600),
                    ElevatedButton.icon(
                      onPressed: () {
                        context.read<TermsConditionsCubit>().fetchTermsConditions();
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

          if (state is TermsConditionsLoaded) {
            final data = state.termsConditions;

            return RefreshIndicator(
              onRefresh: () =>
                  context.read<TermsConditionsCubit>().fetchTermsConditions(),
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.all(padding16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: space600),
                    HtmlWidget(
                      data.content,
                      customStylesBuilder: (element) {
                        if (element.localName == 'h1') {
                          return {
                            'color': '#000000',
                            'font-size': '14px',
                            'border-bottom': 'none',
                            'padding-bottom': '0',
                          };
                        }
                        return null;
                      },
                      textStyle: smMedium,
                    ),
                    SizedBox(height: space600),
                    Container(
                      padding: EdgeInsets.all(padding12),
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
          title: Text("Syarat dan Ketentuan", style: xlMedium),
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