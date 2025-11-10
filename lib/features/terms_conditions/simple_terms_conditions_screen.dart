import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shantika_cubit/features/terms_conditions/cubit/terms_conditions_cubit.dart';
import 'package:shantika_cubit/features/terms_conditions/cubit/terms_conditions_state.dart';
import 'package:shantika_cubit/ui/dimension.dart';
import 'package:shantika_cubit/ui/typography.dart';

class SimpleTermsConditionsScreen extends StatefulWidget {
  const SimpleTermsConditionsScreen({super.key});

  @override
  State<SimpleTermsConditionsScreen> createState() =>
      _SimpleTermsConditionsScreenState();
}

class _SimpleTermsConditionsScreenState
    extends State<SimpleTermsConditionsScreen> {

  @override
  void initState() {
    super.initState();
    context.read<TermsConditionsCubit>().fetchTermsConditions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Syarat & Ketentuan'),
      ),
      body: BlocBuilder<TermsConditionsCubit, TermsConditionsState>(
        builder: (context, state) {
          if (state is TermsConditionsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is TermsConditionsError) {
            return Center(child: Text(state.message));
          }

          if (state is TermsConditionsLoaded) {
            return SingleChildScrollView(
              padding: EdgeInsets.all(padding16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    state.termsConditions.name,
                    style: smMedium,
                  ),
                  SizedBox(height: spacing4),
                  Text(
                    _stripHtmlTags(state.termsConditions.content),
                    style: mdMedium,
                  ),
                ],
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  String _stripHtmlTags(String htmlString) {
    return htmlString
        .replaceAll(RegExp(r'<[^>]*>'), '')
        .replaceAll('&nbsp;', ' ')
        .replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .trim();
  }
}