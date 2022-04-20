import 'package:movieapi/data/models/movie_model.dart';
import 'package:movieapi/data/models/movie_trailer_model.dart';
import 'package:movieapi/data/web_services/movies_web_service.dart';

import '../../helper/filtering_data.dart';

class MovieRepository{
  final MovieWebService movieWebService;
  late List<MovieModel>similarMovies;
  MovieRepository({required this.movieWebService});

  Future<List<MovieModel>> fetchSimilarMovies(String movieID)async{
    final moviesResults = await movieWebService.getSimilarMovies(movieID: movieID);
    similarMovies = moviesResults['results'].map<MovieModel>((json) => MovieModel.fromJson(json)).toList();
    similarMovies = DataFilter.filterResultsByGenreIds(similarMovies);
    similarMovies = DataFilter.removeWhereNoPosterImage(similarMovies);
    return similarMovies;
  }

  Future<List<MovieTrailerModel>> fetchTrailersVideos(String movieID)async{
    final moviesResults = await movieWebService.getMovieTrailers(movieID: movieID);
    List<MovieTrailerModel>trailerVideos = moviesResults['results'].map<MovieTrailerModel>((json) => MovieTrailerModel.fromJson(json)).toList();
    return trailerVideos;
  }


}