import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapi/data/models/movie_model.dart';
import 'package:movieapi/data/models/movie_trailer_model.dart';
import 'package:movieapi/data/repository/movie_repository.dart';
part 'movie_details_state.dart';
class MovieDetailsCubit extends Cubit<MovieDetailsState> {

  final MovieRepository movieRepository;
  List<MovieModel> similarMovies = [];
  List<MovieTrailerModel> movieTrailers = [];

  MovieDetailsCubit(this.movieRepository) : super(MovieDetailsInitial());

  List<MovieModel> getSimilarMovies(){
    movieRepository.fetchSimilarMovies().then((movies) {
      emit(SimilarMoviesLoaded(movies));
      this.similarMovies = movies;
    });
    return similarMovies;
  }

  List<MovieTrailerModel> getMovieTrailers(){
    movieRepository.fetchTrailersVideos().then((videos) {
      emit(MovieTrailersLoaded(movieTrailers));
      this.movieTrailers = videos;
    });
    return movieTrailers;
  }

}
