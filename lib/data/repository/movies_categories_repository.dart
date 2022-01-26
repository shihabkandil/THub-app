import 'package:movieapi/constants/strings.dart';
import 'package:movieapi/data/models/movie_model.dart';
import 'package:movieapi/data/web_services/movies_web_service.dart';

class MoviesCategoryRepository{
  final MovieWebService movieWebService;
  MoviesCategoryRepository(this.movieWebService);

  Future<List<MovieModel>> fetchPopularMovies()async{
    final moviesResults = await movieWebService.getAllMovies(query:PopularMoviesQuery);
    List<MovieModel>movies = moviesResults['results'].map<MovieModel>((json) => MovieModel.fromJson(json)).toList();
    return movies;
  }
  Future<List<MovieModel>> fetchNowPlayingMovies()async{
    final moviesResults = await movieWebService.getAllMovies(query: NowplayingMoviesQuery);
    List<MovieModel>movies = moviesResults['results'].map<MovieModel>((json) => MovieModel.fromJson(json)).toList();
    return movies;
  }
  Future<List<MovieModel>> fetchTopRatedMovies()async{
    final moviesResults = await movieWebService.getAllMovies(query: TopRatedMoviesQuery);
    List<MovieModel>movies = moviesResults['results'].map<MovieModel>((json) => MovieModel.fromJson(json)).toList();
    return movies;
  }
  Future<List<MovieModel>> fetchDiscoverMovies()async{
    final moviesResults = await movieWebService.getAllMovies(query:DiscoverMoviesQuery);
    List<MovieModel>movies = moviesResults['results'].map<MovieModel>((json) => MovieModel.fromJson(json)).toList();
    return movies;
  }
  Future<List<MovieModel>> fetchUpcomingMovies()async{
    final moviesResults = await movieWebService.getAllMovies(query:UpcomingMoviesQuery);
    List<MovieModel>movies = moviesResults['results'].map<MovieModel>((json) => MovieModel.fromJson(json)).toList();
    return movies;
  }
}
