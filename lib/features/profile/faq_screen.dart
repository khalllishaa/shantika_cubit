import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shantika_cubit/features/profile/cubit/faq_cubit.dart';
import 'package:shantika_cubit/features/profile/cubit/faq_state.dart';
import 'package:shantika_cubit/ui/color.dart';
import 'package:shantika_cubit/ui/dimension.dart';
import 'package:shantika_cubit/ui/shared_widget/custom_card_container.dart';
import 'package:shantika_cubit/ui/typography.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FAQCubit>().fetchFAQs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _header(),
      body: BlocBuilder<FAQCubit, FAQState>(
        builder: (context, state) {
          if (state is FAQLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is FAQError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.message,
                    textAlign: TextAlign.center,
                    style: smMedium,
                  ),
                  SizedBox(height: space600),
                  ElevatedButton(
                    onPressed: () => context.read<FAQCubit>().fetchFAQs(),
                    child: Text('Coba Lagi'),
                  ),
                ],
              ),
            );
          }

          if (state is FAQLoaded) {
            if (state.faqs.isEmpty) {
              return Center(
                child: Text('Belum ada data FAQ'),
              );
            }

            return RefreshIndicator(
              onRefresh: () => context.read<FAQCubit>().fetchFAQs(),
              child: ListView.builder(
                padding: EdgeInsets.all(padding16),
                itemCount: state.faqs.length,
                itemBuilder: (context, index) {
                  final item = state.faqs[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: padding12),
                    child: _faqItem(
                      question: item.question,
                      answer: item.answer,
                    ),
                  );
                },
              ),
            );
          }

          return const SizedBox();
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
          title: Text("FAQ", style: xlMedium),
        ),
      ),
    );
  }

  Widget _faqItem({
    required String question,
    required String answer,
  }) {
    final isExpanded = ValueNotifier<bool>(false);

    return ValueListenableBuilder<bool>(
      valueListenable: isExpanded,
      builder: (context, expanded, _) {
        return CustomCardContainer(
          backgroundColor: navy300.withOpacity(0.1),
          boxShadow: [],
          borderRadius: borderRadius750,
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              InkWell(
                onTap: () => isExpanded.value = !expanded,
                borderRadius: BorderRadius.circular(borderRadius750),
                child: Padding(
                  padding: EdgeInsets.all(padding16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          question,
                          style: smMedium,
                        ),
                      ),
                      SizedBox(width: spacing4),
                      AnimatedRotation(
                        turns: expanded ? 0.5 : 0,
                        duration: Duration(milliseconds: 300),
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          color: black950,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AnimatedCrossFade(
                firstChild: SizedBox.shrink(),
                secondChild: Container(
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(
                    padding16,
                    0,
                    padding16,
                    padding16,
                  ),
                  child: Text(
                    answer,
                    style: smMedium.copyWith(color: black700_70),
                  ),
                ),
                crossFadeState:
                expanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                duration: Duration(milliseconds: 300),
              ),
            ],
          ),
        );
      },
    );
  }

}