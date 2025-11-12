import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shantika_cubit/features/home/cubit/artikel_state.dart';
import 'package:shantika_cubit/model/home_model.dart';
import 'package:shantika_cubit/repository/home_repository.dart';
import 'package:share_plus/share_plus.dart';

class ArtikelCubit extends Cubit<ArtikelState> {
  final HomeRepository _repository;

  ArtikelCubit(this._repository) : super(ArtikelInitial());

  List<Artikel> _allArticles = [];
  List<Artikel> _filteredArticles = [];

  Future<void> loadArticles() async {
    try {
      emit(ArtikelLoading());

      final homeData = await _repository.getHome();

      _allArticles = homeData.artikel;
      _filteredArticles = _allArticles;

      emit(ArtikelLoaded(
        articles: _allArticles,
        filteredArticles: _filteredArticles,
      ));
    } catch (e) {
      emit(ArtikelError('Terjadi kesalahan: ${e.toString()}'));
    }
  }

  void searchArticles(String query) {
    if (state is ArtikelLoaded) {
      if (query.isEmpty) {
        _filteredArticles = _allArticles;
      } else {
        _filteredArticles = _allArticles
            .where((article) =>
        article.name.toLowerCase().contains(query.toLowerCase()) ||
            article.description.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }

      emit(ArtikelLoaded(
        articles: _allArticles,
        filteredArticles: _filteredArticles,
      ));
    }
  }

  Future<void> shareArticle(String title, String imageUrl) async {
    try {
      await Share.share(
        '$title\n\nLihat artikel selengkapnya di aplikasi New Shantika\nGambar: $imageUrl',
        subject: title,
      );
    } catch (e) {
      print('Error sharing: $e');
    }
  }

  Future<void> loadArticleDetail(int articleId) async {
    try {
      emit(ArtikelDetailLoading());

      // Fetch detail artikel
      final articleDetail = await _repository.getArticleDetail(articleId);

      // Fetch artikel terkait (dari endpoint home)
      final homeData = await _repository.getHome();

      // Filter artikel terkait (exclude artikel yang sedang dibuka)
      final relatedArticles = homeData.artikel
          .where((article) => article.id != articleId)
          .take(3)
          .toList();

      emit(ArtikelDetailLoaded(
        article: articleDetail,
        relatedArticles: relatedArticles,
      ));
    } catch (e) {
      emit(ArtikelDetailError('Terjadi kesalahan: ${e.toString()}'));
    }
  }
}