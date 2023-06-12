// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasurces/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/entities/video.dart';
import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_details.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/moviedb_videos.dart';
import 'package:dio/dio.dart';

class MoviedbDataSource implements MovieDataSource {
  final dio = Dio(BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3',
    queryParameters: {'api_key': Environment.movieDbKey, 'language': 'es-MX'},
  ));

  List<Movie> _jsonToMovies(Map<String, dynamic> data) {
    final movieDBResponse = MovieDbResponse.fromJson(data);

    final List<Movie> movies = movieDBResponse.results
        .where((moviedb) => moviedb.posterPath != 'no-poster')
        .map((movieDb) => MovieMapper.movieDBToEntity(movieDb))
        .toList();

    return movies;
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response =
        await dio.get('/movie/now_playing', queryParameters: {'page': page});

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response =
        await dio.get('/movie/popular', queryParameters: {'page': page});

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response =
        await dio.get('/movie/top_rated', queryParameters: {'page': page});

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    final response =
        await dio.get('/movie/upcoming', queryParameters: {'page': page});

    return _jsonToMovies(response.data);
  }

  @override
  Future<Movie> getMovieById(String id) async {
    final response = await dio.get('/movie/$id');
    if (response.statusCode != 200)
      throw Exception('Movie with id: $id not found');

    final movieDetails = MovieDetails.fromJson(response.data);

    return MovieMapper.movieDetailsToEntity(movieDetails);
  }

  @override
  Future<List<Movie>> searchMovies(String query) async {
    if (query.isEmpty) return [];
    final response = await dio.get('/search/movie', queryParameters: {
      'query': query,
    });
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Video>> getVideosByMovieId(String id) async {
    List<Video> videos = [];
    final response = await dio.get('/movie/$id/videos');
    if (response.statusCode != 200)
      throw Exception('Videos from movie with id: $id not found');
    final movieVideosResponse = MoviedbVideos.fromJson(response.data);
    final trailers =
        movieVideosResponse.results.where((e) => e.type == 'Trailer').toList();
    for (var trailer in trailers) {
      final video = MovieMapper.movieDBVideoToEntity(trailer);
      videos.add(video);
    }
    return videos;
  }

  @override
  Future<List<Movie>> getSimilar(String id) async {
    final response = await dio.get('/movie/$id/similar');
    if (response.statusCode != 200)
      throw Exception('Similar from movie with id: $id not found');
    return _jsonToMovies(response.data);
  }
}
