import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:cinemapedia/presentation/widgets/movies/movie_horizontal_listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final similarMoviesProvider = FutureProvider.family((ref, String id) {
  final movieRepository = ref.watch(movieRepositoryProvider);
  return movieRepository.getSimilar(id);
});

class SimilarMovies extends ConsumerWidget {
  final String movieId;

  const SimilarMovies({super.key, required this.movieId});

  @override
  Widget build(BuildContext context, ref) {
    final similarMovies = ref.watch(similarMoviesProvider(movieId));
    return similarMovies.when(
      data: (data) => _SimilarList(movies: data),
      error: (error, stackTrace) => throw UnimplementedError(),
      loading: () => const CircularProgressIndicator(),
    );
  }
}

class _SimilarList extends StatelessWidget {
  final List<Movie> movies;

  const _SimilarList({required this.movies});

  @override
  Widget build(BuildContext context) {
    return MovieHorizontalListview(
      movies: movies,
      title: 'Similares',
    );
  }
}
