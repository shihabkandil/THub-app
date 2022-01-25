import 'package:movieapi/data/models/movie.dart';
import 'package:movieapi/data/web_services/movies_web_service.dart';

class MoviesRepository{
  final MovieWebService movieWebService;
  MoviesRepository(this.movieWebService);

  Future<List<Movie>> fetchMovies()async{
    final moviesResults = await movieWebService.getAllMovies();
    List<Movie>movies = moviesResults['results'].map<Movie>((json) => Movie.fromJson(json)).toList();
    return movies;
  }
}
