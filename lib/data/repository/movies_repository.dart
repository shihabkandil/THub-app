import 'package:movieapi/data/models/movie.dart';
import 'package:movieapi/data/web_services/movies_web_service.dart';

class MoviesRepository{
  final MovieWebService movieWebService;
  MoviesRepository(this.movieWebService);

  Future<List<Movie>> fetchMovies()async{
    final movies = await movieWebService.getAllMovies();
    return movies.map((e) => Movie.fromJson(e)).toList();
  }
}