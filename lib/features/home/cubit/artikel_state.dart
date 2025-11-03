import 'package:equatable/equatable.dart';

abstract class ArtikelState extends Equatable {
  const ArtikelState();

  @override
  List<Object?> get props => [];
}

class ArtikelInitial extends ArtikelState {}

class ArtikelLoading extends ArtikelState {}

class ArtikelLoaded extends ArtikelState {
  final List<Map<String, String>> articles;
  final List<Map<String, String>> relatedArticles;
  final String searchQuery;

  const ArtikelLoaded({
    required this.articles,
    required this.relatedArticles,
    this.searchQuery = '',
  });

  List<Map<String, String>> get filteredArticles {
    if (searchQuery.isEmpty) return articles;

    return articles.where((article) {
      return article['title']!
          .toLowerCase()
          .contains(searchQuery.toLowerCase());
    }).toList();
  }

  ArtikelLoaded copyWith({
    List<Map<String, String>>? articles,
    List<Map<String, String>>? relatedArticles, // Add this
    String? searchQuery,
  }) {
    return ArtikelLoaded(
      articles: articles ?? this.articles,
      relatedArticles: relatedArticles ?? this.relatedArticles, // Add this
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [articles, searchQuery];
}

class ArtikelError extends ArtikelState {
  final String message;

  const ArtikelError(this.message);

  @override
  List<Object?> get props => [message];
}
