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
      appBar: AppBar(
        title: const Text('Syarat & Ketentuan'),
        backgroundColor: const Color(0xFF1A3A6E),
        foregroundColor: Colors.white,
      ),
      body: BlocBuilder<TermsConditionsCubit, TermsConditionsState>(
        builder: (context, state) {
          if (state is TermsConditionsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is TermsConditionsError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 60,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () {
                        context.read<TermsConditionsCubit>().fetchTermsConditions();
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Coba Lagi'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1A3A6E),
                        foregroundColor: Colors.white,
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
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Render HTML content menggunakan flutter_widget_from_html
                    HtmlWidget(
                      data.content,
                      textStyle: const TextStyle(
                        fontSize: 14,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Footer info
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Terakhir diperbarui:',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _formatDate(data.updatedAt),
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[800],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return const SizedBox();
        },
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