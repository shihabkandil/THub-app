import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapi/data/models/movie_trailer_model.dart';
import 'package:movieapi/data/repository/movie_repository.dart';
part 'movie_trailer_state.dart';
class MovieTrailersCubit extends Cubit<MovieTrailersState> {

  final MovieRepository movieRepository;
  List<MovieTrailerModel> movieTrailers = [];

  MovieTrailersCubit(this.movieRepository) : super(MovieTrailersInitial());

  List<MovieTrailerModel> getMovieTrailers(String movieID){
    movieRepository.fetchTrailersVideos(movieID).then((movieTrailers) {
      emit(MovieTrailersLoaded(movieTrailers));
      this.movieTrailers = movieTrailers;
    });
    return movieTrailers;
  }

}
