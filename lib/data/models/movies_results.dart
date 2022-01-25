import 'movie.dart';

class MoviesResults{
  late List<Movie> movies;

  MoviesResults(this.movies);

  MoviesResults.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      movies = <Movie>[];
      json['results'].forEach((movie) {
        movies.add(Movie.fromJson(movie));
      });
    }
    else{
      movies = <Movie>[];
    }
  }
  List<Movie>getMovies(){
    return movies;
  }
}