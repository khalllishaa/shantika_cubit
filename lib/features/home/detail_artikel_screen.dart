import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shantika_cubit/features/home/cubit/artikel_cubit.dart';
import 'package:shantika_cubit/features/home/cubit/artikel_state.dart';
import 'package:shantika_cubit/ui/color.dart';
import 'package:shantika_cubit/ui/dimension.dart';
import 'package:shantika_cubit/ui/typography.dart';

import '../../ui/shared_widget/custom_card_container.dart';

class DetailArtikelScreen extends StatelessWidget {
  final String title;
  final String image;

  const DetailArtikelScreen({
    Key? key,
    required this.title,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ArtikelCubit()..loadArticles(),
      child: Scaffold(
        backgroundColor: black00,
        appBar: _header(context),
        body: BlocBuilder<ArtikelCubit, ArtikelState>(
          builder: (context, state) {
            if (state is ArtikelLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ArtikelError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 64, color: black700_70),
                    SizedBox(height: space100),
                    Text('Terjadi kesalahan', style: smMedium),
                    SizedBox(height: space100),
                    Text(state.message, style: smMedium),
                  ],
                ),
              );
            }

            if (state is ArtikelLoaded) {
              return RefreshIndicator(
                onRefresh: () => context.read<ArtikelCubit>().loadArticles(),
                child: ListView(
                  padding: EdgeInsets.all(paddingL),
                  children: [
                    _protokol(image, title),
                    SizedBox(height: space600),
                    _artikelList(state.relatedArticles),
                    SizedBox(height: space100),
                    _bacaLainnya(context, state.articles),
                  ],
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }

  // PreferredSizeWidget _header(BuildContext context) {
  //   return AppBar(
  //     leadingWidth: spacing10,
  //     backgroundColor: black00,
  //     leading: IconButton(
  //       icon: Icon(
  //         Icons.arrow_back_rounded,
  //         size: iconL,
  //         color: black950,
  //       ),
  //       onPressed: () => Navigator.pop(context),
  //     ),
  //     title: Text("Detail Artikel", style: xlMedium),
  //     actions: [
  //       Padding(
  //         padding: EdgeInsets.only(right: paddingL),
  //         child: IconButton(
  //           icon: Icon(Icons.share, color: black950, size: iconL),
  //           onPressed: () {
  //             context.read<ArtikelCubit>().shareArticle(title);
  //             ScaffoldMessenger.of(context).showSnackBar(
  //               SnackBar(content: Text('Berbagi artikel: $title')),
  //             );
  //           },
  //         ),
  //       )
  //     ],
  //   );
  // }

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
            Padding(
              padding: EdgeInsets.only(right: paddingL),
              child: IconButton(
                icon: Icon(Icons.share, color: black950, size: iconL),
                onPressed: () {
                  context.read<ArtikelCubit>().shareArticle(title);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Berbagi artikel: $title')),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }


  Widget _protokol(String image, String title) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius300),
          child: Image.asset(
            image,
            height: 120,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: 120,
                width: double.infinity,
                color: black700_70,
                child: Icon(Icons.image, size: 48, color: black700_70),
              );
            },
          ),
        ),
        SizedBox(height: spacing5),
        Center(
          child: Text(title, textAlign: TextAlign.center, style: mdMedium),
        ),
        SizedBox(height: spacing4),
        Text(
          "Perjalanan selama pandemi menghadirkan tantangan tersendiri, tetapi juga memberikan pengalaman berharga yang sulit dilupakan. "
              "Salah satu momen terbaik adalah ketika saya melakukan perjalanan ke daerah terpencil dengan protokol kesehatan yang ketat.",
          textAlign: TextAlign.center,
          style: xsRegular,
        ),
      ],
    );
  }

  Widget _artikelList(List<Map<String, String>> relatedArticles) {
    return ListView.builder(
      itemCount: relatedArticles.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final item = relatedArticles[index];
        return Padding(
          padding: EdgeInsets.only(bottom: space100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item['title'] ?? '', style: smMedium),
              SizedBox(height: spacing4),
              ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius300),
                child: Image.asset(
                  item['image'] ?? '',
                  height: 116.74,
                  width: 150,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: spacing4),
              Text(item['description'] ?? '', style: xsRegular),
              SizedBox(height: spacing5),
            ],
          ),
        );
      },
    );
  }

  Widget _bacaLainnya(BuildContext context, List<Map<String, String>> articles) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Baca Artikel Lainnya', style: smMedium),
            Text(
              'Selengkapnya →',
              style: smRegular.copyWith(color: orange700),
            ),
          ],
        ),
        SizedBox(height: spacing4),
        Column(
          children: articles.map((item) {
            return Padding(
              padding: EdgeInsets.only(bottom: spacing4),
              child: CustomCardContainer(
                padding: EdgeInsets.zero,
                borderRadius: borderRadius300,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(borderRadius300),
                      ),
                      child: Image.asset(
                        item['image'] ?? '',
                        height: 160,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(padding12),
                      child: Text(
                        item['title'] ?? '',
                        style: smMedium.copyWith(color: black900),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildCard(BuildContext context, String image, String title) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailArtikelScreen(
              title: title,
              image: image,
            ),
          ),
        );
      },
      borderRadius: BorderRadius.circular(borderRadius300),
      child: CustomCardContainer(
        padding: EdgeInsets.zero,
        borderRadius: borderRadius300,
        borderColor: Colors.grey.shade300,
        borderWidth: 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
              BorderRadius.vertical(top: Radius.circular(borderRadius300)),
              child: Image.asset(
                image,
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 100,
                    width: double.infinity,
                    color: black700_70,
                    child: Icon(Icons.image, size: 32, color: black700_70),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(paddingM),
              child: Text(title, style: smMedium),
            ),
          ],
        ),
      ),
    );
  }
}
