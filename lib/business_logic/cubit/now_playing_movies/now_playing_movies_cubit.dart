import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapi/constants/strings.dart';
import 'package:movieapi/data/models/movie_model.dart';
import 'package:movieapi/data/repository/movies_categories_repository.dart';
part 'now_playing_movies_state.dart';
class NowPlayingMoviesCubit extends Cubit<NowPlayingMoviesState> {

  final MoviesCategoryRepository moviesRepository;
  List<MovieModel> movies = [];
  NowPlayingMoviesCubit(this.moviesRepository) : super(NowPlayingMoviesInitial());

  List<MovieModel> getAllNowPlayingMovies(){
    moviesRepository.fetchMovies(moviesQuery:NowplayingMoviesQuery).then((movies) {
      emit(NowPlayingMoviesLoaded(movies));
      this.movies = movies;
    });
    return movies;
  }
}
