import 'package:cinemapedia/domain/entities/video.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final moviesVideosProvider =
    StateNotifierProvider<MovieVideosNotifier, Map<String, Video>>((ref) {
  final moviesRepository = ref.watch(movieRepositoryProvider);
  return MovieVideosNotifier(getVideos: moviesRepository.getVideosByMovieId);
});

typedef GetVideosCallBack = Future<List<Video>> Function(String id);

class MovieVideosNotifier extends StateNotifier<Map<String, Video>> {
  final GetVideosCallBack getVideos;

  MovieVideosNotifier({required this.getVideos}) : super({});

  Future<void> loadVideos(String id) async {
    final videos = await getVideos(id);
    videos.sort((a, b) => a.publishedAt.compareTo(b.publishedAt));
    state = {...state, id: videos.first};
  }
}
