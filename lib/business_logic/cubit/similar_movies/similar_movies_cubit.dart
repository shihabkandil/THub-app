import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapi/data/models/movie_model.dart';
import 'package:movieapi/data/models/movie_trailer_model.dart';
import 'package:movieapi/data/repository/movie_repository.dart';
part 'movie_details_state.dart';
class SimilarMoviesCubit extends Cubit<SimilarMoviesState> {

  final MovieRepository movieRepository;
  List<MovieModel> similarMovies = [];
  List<MovieTrailerModel> movieTrailers = [];

  SimilarMoviesCubit(this.movieRepository) : super(SimilarMoviesInitial());

  List<MovieModel> getSimilarMovies(String movieID){
    movieRepository.fetchSimilarMovies(movieID).then((movies) {
      emit(SimilarMoviesLoaded(movies));
      this.similarMovies = movies;
    });
    return similarMovies;
  }

  List<MovieTrailerModel> getMovieTrailers(String movieID){
    movieRepository.fetchTrailersVideos(movieID).then((videos) {
      emit(MovieTrailersLoaded(movieTrailers));
      this.movieTrailers = videos;
    });
    return movieTrailers;
  }

}
