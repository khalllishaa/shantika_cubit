import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shantika_cubit/features/profile/cubit/faq_cubit.dart';
import 'package:shantika_cubit/features/profile/cubit/faq_state.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  @override
  void initState() {
    super.initState();
    // Load FAQ saat screen dibuka
    context.read<FAQCubit>().fetchFAQs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FAQ'),
      ),
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
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context.read<FAQCubit>().fetchFAQs(),
                    child: const Text('Coba Lagi'),
                  ),
                ],
              ),
            );
          }

          if (state is FAQLoaded) {
            if (state.faqs.isEmpty) {
              return const Center(
                child: Text('Belum ada data FAQ'),
              );
            }

            return RefreshIndicator(
              onRefresh: () => context.read<FAQCubit>().fetchFAQs(),
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.faqs.length,
                itemBuilder: (context, index) {
                  final item = state.faqs[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F7FA),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ExpansionTile(
                      title: Text(
                        item.question,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      childrenPadding: const EdgeInsets.all(16),
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            item.answer,
                            style: TextStyle(
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                      ],
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
}