import 'package:cinemapedia/domain/datasurces/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/domain/repositories/actors_repository.dart';

class ActorRepositoryImpl implements ActorsRepository {
  final ActorsDataSource actorsDataSource;

  ActorRepositoryImpl(this.actorsDataSource);

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) {
    return actorsDataSource.getActorsByMovie(movieId);
  }
}
