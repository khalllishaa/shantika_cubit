import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
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
class TermsConditionsScreen extends StatelessWidget {
  TermsConditionsScreen({super.key});

  late TermsConditionsCubit _termsConditionsCubit;

  @override
  Widget build(BuildContext context) {
    _termsConditionsCubit = context.read();
    _termsConditionsCubit.init();
    _termsConditionsCubit.termsConditions();
    return Scaffold(
      appBar: CommonAppbar(leading: true, title: "Syarat & Ketentuan"),
      body: RefreshIndicator(
        onRefresh: () {
          return _termsConditionsCubit.termsConditions();
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: space400, vertical: space300),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Aggrement",
                  style: xsMedium.copyWith(color: textLightSecondary),
                ),
                Text(
                  "Term and Condition",
                  style: mdSemiBold.copyWith(color: textDarkPrimary),
                ),
                BlocBuilder<TermsConditionsCubit, TermsConditionsState>(
                  buildWhen: (prev, current) =>
                      current is TermsConditionStateData ||
                      current is TermsCondionsEmpty ||
                      current is TermsConditionsLoading ||
                      current is TermsConditionsError,
                  builder: (context, state) {
                    // loading view
                    if (state is TermsConditionsLoading) {
                      return Text(
                        "Lorem Ipsum Dolor sir amet puta gago dksandonaoidnoaindosa ",
                        style: xsRegular.copyWith(color: textDarkPrimary),
                      ).addShimmer(block: true);
                    }
                    // empty view
                    else if (state is TermsCondionsEmpty) {
                      return EmptyView();
                    }
                    // data view
                    else if (state is TermsConditionStateData) {
                      final dataTermsConditions = state.termsConditionModel;
                      return HtmlWidget(
                        dataTermsConditions.content ?? "",
                        onTapUrl: (link) async {
                          if (await canLaunchUrl(Uri.parse(link))) {
                            await launchUrl(
                              Uri.parse(link),
                              mode: LaunchMode.externalNonBrowserApplication,
                            );
                          }
                          return true;
                        },
                        textStyle: xsRegular,
                      );
                    }
                    // error view
                    else if (state is TermsConditionsError) {
                      return ErrorView(
                          img: "assets/images/img_error_illustration.svg",
                          title: state.message,
                          onReload: () {
                            _termsConditionsCubit.termsConditions();
                          },
                          desc:
                              "Maaf hal ini terjadi dengan Anda. Muat ulang untuk menampilkan konten di halaman ini");
                    }
                    return Container();
                  },
                )
              ].withSpaceBetween(height: space300),
            ),
          ),
        ),
      ),
    );
  }
}
