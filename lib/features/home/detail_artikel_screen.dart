import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:shantika_cubit/config/service_locator.dart';
import 'package:shantika_cubit/features/home/cubit/artikel_cubit.dart';
import 'package:shantika_cubit/features/home/cubit/artikel_state.dart';
import 'package:shantika_cubit/model/home_model.dart';
import 'package:shantika_cubit/repository/home_repository.dart';
import 'package:shantika_cubit/ui/color.dart';
import 'package:shantika_cubit/ui/dimension.dart';
import 'package:shantika_cubit/ui/typography.dart';
import '../../ui/shared_widget/custom_card_container.dart';

class DetailArtikelScreen extends StatelessWidget {
  final int articleId;
  final HomeRepository? repository;

  const DetailArtikelScreen({
    Key? key,
    required this.articleId,
    this.repository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeRepository = repository ?? serviceLocator<HomeRepository>();

    return BlocProvider(
      create: (context) => ArtikelCubit(homeRepository)
        ..loadArticleDetail(articleId),
      child: const DetailArtikelPage(),
    );
  }
}

class DetailArtikelPage extends StatelessWidget {
  const DetailArtikelPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black00,
      appBar: _header(context),
      body: BlocBuilder<ArtikelCubit, ArtikelState>(
        builder: (context, state) {
          if (state is ArtikelDetailLoading) {
            return Center(
              child: CircularProgressIndicator(color: primaryColor),
            );
          }

          if (state is ArtikelDetailError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: iconXL, color: black700_70),
                  SizedBox(height: space100),
                  Text('Terjadi kesalahan', style: smMedium),
                  SizedBox(height: space100),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: paddingL),
                    child: Text(
                      state.message,
                      style: xxsMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: space600),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      padding: EdgeInsets.symmetric(
                        horizontal: paddingL,
                        vertical: padding12,
                      ),
                    ),
                    child: Text('Kembali'),
                  ),
                ],
              ),
            );
          }

          if (state is ArtikelDetailLoaded) {
            return _buildContent(context, state);
          }

          return SizedBox();
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, ArtikelDetailLoaded state) {
    final article = state.article;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(paddingL),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: CachedNetworkImage(
                imageUrl: article.image,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  width: double.infinity,
                  height: 200,
                  color: black700_70,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                      strokeWidth: 2,
                    ),
                  ),
                ),
                errorWidget: (context, error, stackTrace) => Container(
                  width: double.infinity,
                  height: 200,
                  color: black700_70,
                  child:
                  Icon(Icons.image, size: iconXL, color: black700_70),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: paddingL),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  article.name,
                  style: lgSemiBold,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: space400),
                HtmlWidget(
                  article.description,
                  textStyle: const TextStyle(
                    fontSize: 14,
                    height: 1.6,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: space600),
        ],
      ),
    );
  }
  PreferredSizeWidget _header(BuildContext context) {
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
          title: Text(
            "Detail Artikel",
            style: xlMedium,
          ),
          actions: [
            BlocBuilder<ArtikelCubit, ArtikelState>(
              builder: (context, state) {
                if (state is ArtikelDetailLoaded) {
                  return IconButton(
                    icon: Icon(Icons.share, size: iconL, color: black950),
                    onPressed: () {
                      context.read<ArtikelCubit>().shareArticle(
                        state.article.name,
                        state.article.image,
                      );
                    },
                  );
                }
                return SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _relatedArticlesSection(
      BuildContext context, List<Artikel> articles) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Artikel Terkait", style: mdSemiBold),
        SizedBox(height: spacing4),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: articles.length,
          itemBuilder: (context, index) {
            final article = articles[index];
            return _relatedArticleCard(context, article);
          },
        ),
      ],
    );
  }

  Widget _relatedArticleCard(BuildContext context, Artikel article) {
    return Padding(
      padding: EdgeInsets.only(bottom: padding12),
      child: InkWell(
        borderRadius: BorderRadius.circular(borderRadius300),
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => DetailArtikelScreen(articleId: article.id),
            ),
          );
        },
        child: CustomCardContainer(
          padding: EdgeInsets.all(paddingL),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: paddingL),
                child:ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius300),
                child: CachedNetworkImage(
                  imageUrl: article.image,
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    // width: 80,
                    height: 120,
                    color: black700_70,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                        strokeWidth: 2,
                      ),
                    ),
                  ),
                  errorWidget: (context, error, stackTrace) => Container(
                    width: 80,
                    height: 80,
                    color: black700_70,
                    child: Icon(Icons.image, size: iconXL, color: black700_70),
                  ),
                ),
              ),
              ),
              // ClipRRect(
              //   borderRadius: BorderRadius.circular(borderRadius300),
              //   child: CachedNetworkImage(
              //     imageUrl: article.image,
              //     width: 80,
              //     height: 80,
              //     fit: BoxFit.cover,
              //     placeholder: (context, url) => Container(
              //       width: 80,
              //       height: 80,
              //       color: black700_70,
              //       child: Center(
              //         child: CircularProgressIndicator(
              //           color: primaryColor,
              //           strokeWidth: 2,
              //         ),
              //       ),
              //     ),
              //     errorWidget: (context, error, stackTrace) => Container(
              //       width: 80,
              //       height: 80,
              //       color: black700_70,
              //       child: Icon(Icons.image, size: iconXL, color: black700_70),
              //     ),
              //   ),
              // ),
              SizedBox(width: space300),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.name,
                      style: mdMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: space100),
                    Text(
                      _stripHtmlTags(article.description),
                      style: xsRegular,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
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

  String _stripHtmlTags(String htmlText) {
    final RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return htmlText.replaceAll(exp, '').trim();
  }
}
