import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/movies/movie_masonry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final trendingMoviesProvider = FutureProvider((
  ref,
) {
  final movieRepository = ref.watch(movieRepositoryProvider);
  return movieRepository.getTrendingMovies();
});

class TrendingView extends ConsumerWidget {
  const TrendingView({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final trendingMovies = ref.watch(trendingMoviesProvider);

    return Scaffold(
      body: trendingMovies.when(
        data: (data) => MovieMasonry(movies: data),
        error: (error, stackTrace) => throw UnimplementedError(),
        loading: () => const Center(
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
    );
  }
}
