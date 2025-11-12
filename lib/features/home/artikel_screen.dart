import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shantika_cubit/config/service_locator.dart';
import 'package:shantika_cubit/features/home/cubit/artikel_cubit.dart';
import 'package:shantika_cubit/features/home/cubit/artikel_state.dart';
import 'package:shantika_cubit/features/home/detail_artikel_screen.dart';
import 'package:shantika_cubit/model/home_model.dart';
import 'package:shantika_cubit/repository/home_repository.dart';
import 'package:shantika_cubit/ui/color.dart';
import 'package:shantika_cubit/ui/dimension.dart';
import 'package:shantika_cubit/ui/typography.dart';
import '../../ui/shared_widget/custom_card_container.dart';

class ArtikelScreen extends StatelessWidget {
  const ArtikelScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ArtikelCubit(
        serviceLocator<HomeRepository>(),
      )..loadArticles(),
      child: const ArtikelPage(),
    );
  }
}

class ArtikelPage extends StatelessWidget {
  const ArtikelPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black00,
      appBar: _header(context),
      body: Column(
        children: [
          _searchBar(context),
          Expanded(
            child: BlocBuilder<ArtikelCubit, ArtikelState>(
              builder: (context, state) {
                if (state is ArtikelLoading) {
                  return Center(
                    child: CircularProgressIndicator(color: primaryColor),
                  );
                }

                if (state is ArtikelError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline, size: iconXL, color: black700_70),
                        SizedBox(height: space100),
                        Text('Terjadi kesalahan', style: smMedium),
                        SizedBox(height: space100),
                        Text(state.message, style: xxsMedium, textAlign: TextAlign.center),
                        SizedBox(height: space600),
                        ElevatedButton(
                          onPressed: () => context.read<ArtikelCubit>().loadArticles(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            padding: EdgeInsets.symmetric(horizontal: paddingL, vertical: padding12),
                          ),
                          child: Text('Coba Lagi'),
                        ),
                      ],
                    ),
                  );
                }

                if (state is ArtikelLoaded) {
                  final articles = state.filteredArticles;

                  if (articles.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.article_outlined, size: iconXL, color: black700_70),
                          SizedBox(height: space100),
                          Text('Tidak ada artikel ditemukan', style: smMedium),
                        ],
                      ),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () => context.read<ArtikelCubit>().loadArticles(),
                    color: primaryColor,
                    child: ListView.builder(
                      itemCount: articles.length,
                      padding: EdgeInsets.symmetric(horizontal: padding16),
                      itemBuilder: (context, index) {
                        final article = articles[index];
                        return _articleCard(context, article);
                      },
                    ),
                  );
                }

                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}

PreferredSizeWidget _header(BuildContext context) {
  return AppBar(
    leadingWidth: spacing10,
    backgroundColor: black00,
    leading: IconButton(
      icon: Icon(Icons.arrow_back_rounded, size: iconL, color: black950),
      onPressed: () => Navigator.pop(context),
    ),
    title: Text("Artikel", style: xlMedium),
  );
}

Widget _searchBar(BuildContext context) {
  return Padding(
    padding: EdgeInsets.all(padding16),
    child: Container(
      height: 45,
      decoration: BoxDecoration(
        color: black00,
        borderRadius: BorderRadius.circular(borderRadius750),
        border: Border.all(color: black700_70.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: padding16),
              child: TextField(
                onChanged: (value) {
                  context.read<ArtikelCubit>().searchArticles(value);
                },
                cursorColor: black700_70,
                style: mdRegular,
                decoration: InputDecoration(
                  hintText: "Cari Artikel",
                  hintStyle: mdRegular.copyWith(color: black700_70),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: paddingS),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: padding12),
            child: Icon(Icons.search_rounded, color: black700_70, size: iconL),
          ),
        ],
      ),
    ),
  );
}

Widget _articleCard(BuildContext context, Artikel article) {
  return Padding(
    padding: EdgeInsets.only(bottom: paddingL),
    child: InkWell(
      borderRadius: BorderRadius.circular(borderRadius300),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailArtikelScreen(articleId: article.id),
          ),
        );
      },
      child: CustomCardContainer(
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(borderRadius300),
              ),
              child: CachedNetworkImage(
                imageUrl: article.image,
                width: double.infinity,
                height: 130,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  width: double.infinity,
                  height: 130,
                  color: black700_70,
                  child: Center(
                    child: CircularProgressIndicator(color: primaryColor, strokeWidth: 2),
                  ),
                ),
                errorWidget: (context, error, stackTrace) => Container(
                  width: double.infinity,
                  height: 130,
                  color: black700_70,
                  child: Icon(Icons.image, size: iconXL, color: black700_70),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(paddingM),
              child: Text(
                article.name,
                style: smMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}