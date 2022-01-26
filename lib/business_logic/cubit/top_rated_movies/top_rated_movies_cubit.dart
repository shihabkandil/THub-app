import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapi/data/models/movie.dart';
import 'package:movieapi/data/repository/movies_repository.dart';
part 'top_rated_movies_state.dart';
class TopRatedMoviesCubit extends Cubit<TopRatedMoviesState> {

  final MoviesRepository moviesRepository;
  List<Movie> movies = [];
  TopRatedMoviesCubit(this.moviesRepository) : super(TopRatedMoviesInitial());

  List<Movie> getAllTopRatedMovies(){
    moviesRepository.fetchTopRatedMovies().then((movies) {
      emit(TopRatedMoviesLoaded(movies));
      this.movies = movies;
    });
    return movies;
  }
}
