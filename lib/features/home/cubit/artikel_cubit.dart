// cubit/artikel_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'artikel_state.dart';

class ArtikelCubit extends Cubit<ArtikelState> {
  ArtikelCubit() : super(ArtikelInitial());

  Future<void> loadArticles() async {
    emit(ArtikelLoading());

    try {
      // Simulasi loading data
      await Future.delayed(const Duration(milliseconds: 500));

      // Dummy data - ganti dengan data asli kamu
      final articles = [
        {
          "title": "Tips Menjaga Kesehatan Mental di Era Digital",
          "image": "assets/images/artikel1.png",
        },
        {
          "title": "Pentingnya Olahraga Rutin untuk Tubuh Sehat",
          "image": "assets/images/artikel2.png",
        },
        {
          "title": "Nutrisi Seimbang untuk Keluarga Indonesia",
          "image": "assets/images/artikel3.png",
        },
        {
          "title": "Cara Mengatasi Stress dengan Mindfulness",
          "image": "assets/images/artikel4.png",
        },
      ];

      final relatedArticles = [
        {
          "image": "assets/images/dokter.jpg",
          "title": "1. Penerapan Protokol Kesehatan Dalam perjalanan",
          "description": "Mengutamakan keselamatan dengan masker, hand sanitizer, dan menjaga jarak, memberikan rasa aman selama perjalanan."
        },
        {
          "image": "assets/images/dokter.jpg",
          "title": "2. Menemukan Keindahan Baru",
          "description": "Mengeksplorasi tempat-tempat terpencil yang sebelumnya jarang dikunjungi."
        },
        {
          "image": "assets/images/dokter.jpg",
          "title": "3. Destinasi Lebih Sepi",
          "description": "Wisata yang biasanya ramai menjadi lebih tenang, memungkinkan pengalaman yang lebih intim dengan alam."
        },
      ];

      emit(ArtikelLoaded(
        articles: articles,
        relatedArticles: relatedArticles, // Add this
      ));
    } catch (e) {
      emit(ArtikelError(e.toString()));
    }
  }

  void searchArticles(String query) {
    if (state is ArtikelLoaded) {
      final currentState = state as ArtikelLoaded;
      emit(currentState.copyWith(searchQuery: query));
    }
  }

  void clearSearch() {
    if (state is ArtikelLoaded) {
      final currentState = state as ArtikelLoaded;
      emit(currentState.copyWith(searchQuery: ''));
    }
  }

  // Method untuk share artikel
  void shareArticle(String title) {
    print('Share artikel: $title');
  }

}