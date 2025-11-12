import 'package:shantika_cubit/model/detail_artikel_model.dart';
import 'package:shantika_cubit/model/home_model.dart';

abstract class ArtikelState {}

class ArtikelInitial extends ArtikelState {}

class ArtikelLoading extends ArtikelState {}

class ArtikelLoaded extends ArtikelState {
  final List<Artikel> articles;
  final List<Artikel> filteredArticles;

  ArtikelLoaded({
    required this.articles,
    required this.filteredArticles,
  });
}

// State untuk Detail Artikel
class ArtikelDetailLoading extends ArtikelState {}

class ArtikelDetailLoaded extends ArtikelState {
  final Article article;
  final List<Artikel> relatedArticles;

  ArtikelDetailLoaded({
    required this.article,
    this.relatedArticles = const [],
  });
}

class ArtikelDetailError extends ArtikelState {
  final String message;

  ArtikelDetailError(this.message);
}

class ArtikelError extends ArtikelState {
  final String message;

  ArtikelError(this.message);
}