import 'package:movieapi/data/models/movie_model.dart';
import 'package:movieapi/data/models/movie_trailer_model.dart';
import 'package:movieapi/data/web_services/movies_web_service.dart';

class MovieRepository{
  final movieID;
  final MovieWebService movieWebService;
  MovieRepository({required this.movieID,required this.movieWebService});

  Future<List<MovieModel>> fetchSimilarMovies()async{
    final moviesResults = await movieWebService.getSimilarMovies(movieID: movieID);
    List<MovieModel>similarMovies = moviesResults['results'].map<MovieModel>((json) => MovieModel.fromJson(json)).toList();
    return similarMovies;
  }

  Future<List<MovieTrailerModel>> fetchTrailersVideos()async{
    final moviesResults = await movieWebService.getMovieTrailers(movieID: movieID);
    List<MovieTrailerModel>trailerVideos = moviesResults['results'].map<MovieTrailerModel>((json) => MovieTrailerModel.fromJson(json)).toList();
    return trailerVideos;
  }












}