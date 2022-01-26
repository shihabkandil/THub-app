import 'package:movieapi/constants/strings.dart';
import 'package:movieapi/data/models/movie.dart';
import 'package:movieapi/data/web_services/movies_web_service.dart';

class MoviesRepository{
  final MovieWebService movieWebService;
  MoviesRepository(this.movieWebService);

  Future<List<Movie>> fetchPopularMovies()async{
    final moviesResults = await movieWebService.getAllMovies(query:PopularMoviesQuery);
    List<Movie>movies = moviesResults['results'].map<Movie>((json) => Movie.fromJson(json)).toList();
    return movies;
  }
  Future<List<Movie>> fetchNowPlayingMovies()async{
    final moviesResults = await movieWebService.getAllMovies(query: NowplayingMoviesQuery);
    List<Movie>movies = moviesResults['results'].map<Movie>((json) => Movie.fromJson(json)).toList();
    return movies;
  }
  Future<List<Movie>> fetchTopRatedMovies()async{
    final moviesResults = await movieWebService.getAllMovies(query: TopRatedMoviesQuery);
    List<Movie>movies = moviesResults['results'].map<Movie>((json) => Movie.fromJson(json)).toList();
    return movies;
  }
  Future<List<Movie>> fetchDiscoverMovies()async{
    final moviesResults = await movieWebService.getAllMovies(query:DiscoverMoviesQuery);
    List<Movie>movies = moviesResults['results'].map<Movie>((json) => Movie.fromJson(json)).toList();
    return movies;
  }
  Future<List<Movie>> fetchUpcomingMovies()async{
    final moviesResults = await movieWebService.getAllMovies(query:UpcomingMoviesQuery);
    List<Movie>movies = moviesResults['results'].map<Movie>((json) => Movie.fromJson(json)).toList();
    return movies;
  }
}
