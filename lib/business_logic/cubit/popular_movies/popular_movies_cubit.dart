import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapi/data/models/movie.dart';
import 'package:movieapi/data/repository/movies_repository.dart';

part 'popular_movies_state.dart';
class PopularMoviesCubit extends Cubit<PopularMoviesState> {

  final MoviesRepository moviesRepository;
  List<Movie> movies = [];
  PopularMoviesCubit(this.moviesRepository) : super(PopularMoviesInitial());

  List<Movie> getAllPopularMovies(){
    moviesRepository.fetchPopularMovies().then((movies) {
      emit(PopularMoviesLoaded(movies));
      this.movies = movies;
    });
    return movies;
  }
}
