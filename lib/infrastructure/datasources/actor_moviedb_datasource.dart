import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasurces/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infrastructure/mappers/actor_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/credits_response.dart';
import 'package:dio/dio.dart';

class ActorMovieDBDataSource implements ActorsDataSource {
  final dio = Dio(BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3',
    queryParameters: {'api_key': Environment.movieDbKey, 'language': 'es-MX'},
  ));

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    final response = await dio.get('/movie/$movieId/credits');
    if (response.statusCode != 200)
      throw Exception('Credits for movie with id: $movieId not found');

    final credits = CreditsResponse.fromJson(response.data);
    final actors =
        credits.cast.map((e) => ActorMapper.castToEntity(e)).toList();

    return actors;
  }
}
