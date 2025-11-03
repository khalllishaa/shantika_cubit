import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shantika_cubit/features/home/cubit/artikel_cubit.dart';
import 'package:shantika_cubit/features/home/cubit/artikel_state.dart';
import 'package:shantika_cubit/features/home/detail_artikel_screen.dart';
import 'package:shantika_cubit/ui/color.dart';
import 'package:shantika_cubit/ui/dimension.dart';
import 'package:shantika_cubit/ui/typography.dart';

import '../../ui/shared_widget/custom_card_container.dart';

class ArtikelScreen extends StatelessWidget {
  const ArtikelScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ArtikelCubit()..loadArticles(),
      child: const ArtikelPage(),
    );
  }
}

// ✅ INI UI-nya
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
                // Loading state
                if (state is ArtikelLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                // Error state
                if (state is ArtikelError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 64,
                          color: black700_70,
                        ),
                        SizedBox(height: space100),
                        Text(
                          'Terjadi kesalahan',
                          style: smMedium,
                        ),
                        SizedBox(height: space100),
                        Text(
                          state.message,
                          style: xxsMedium,
                        ),
                      ],
                    ),
                  );
                }

                // Loaded state
                if (state is ArtikelLoaded) {
                  final articles = state.filteredArticles;

                  if (articles.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.article_outlined,
                            size: 64,
                            color: black700_70,
                          ),
                          SizedBox(height: space100),
                          Text(
                            'Tidak ada artikel ditemukan',
                            style: smMedium,
                          ),
                        ],
                      ),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () => context.read<ArtikelCubit>().loadArticles(),
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
      icon: Icon(
        Icons.arrow_back_rounded,
        size: iconL,
        color: black950,
      ),
      color: black950,
      onPressed: () => Navigator.pop(context),
    ),
    title: Text(
      "Artikel",
      style: xlMedium,
    ),
  );
}

Widget _searchBar(BuildContext context) {
  return Padding(
    padding: EdgeInsets.all(padding16),
    child: Container(
      height: 45,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.grey.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: TextField(
                onChanged: (value) {
                  context.read<ArtikelCubit>().searchArticles(value);
                },
                cursorColor: Colors.grey,
                style: const TextStyle(color: Colors.black87, fontSize: 14),
                decoration: InputDecoration(
                  hintText: "Cari Artikel",
                  hintStyle: const TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                  ),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none, // ✅ biar ga berubah pas fokus
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Icon(
              Icons.search_rounded,
              color: Colors.black45,
              size: 22,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _articleCard(BuildContext context, Map<String, String> article) {
  return Padding(
    padding: EdgeInsets.only(bottom: paddingL),
    child: InkWell(
      borderRadius: BorderRadius.circular(borderRadius300),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailArtikelScreen(
              title: article["title"]!,
              image: article["image"]!,
            ),
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
              child: Image.asset(
                article["image"]!,
                width: double.infinity,
                height: 130,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: double.infinity,
                    height: 130,
                    color: black700_70,
                    child: Icon(
                      Icons.image,
                      size: 48,
                      color: black700_70,
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(paddingM),
              child: Text(
                article["title"]!,
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