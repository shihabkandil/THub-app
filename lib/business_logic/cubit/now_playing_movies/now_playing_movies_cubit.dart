import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapi/data/models/movie.dart';
import 'package:movieapi/data/repository/movies_repository.dart';
part 'now_playing_movies_state.dart';
class NowPlayingMoviesCubit extends Cubit<NowPlayingMoviesState> {

  final MoviesRepository moviesRepository;
  List<Movie> movies = [];
  NowPlayingMoviesCubit(this.moviesRepository) : super(NowPlayingMoviesInitial());

  List<Movie> getAllNowPlayingMovies(){
    moviesRepository.fetchNowPlayingMovies().then((movies) {
      emit(NowPlayingMoviesLoaded(movies));
      this.movies = movies;
    });
    return movies;
  }
}
