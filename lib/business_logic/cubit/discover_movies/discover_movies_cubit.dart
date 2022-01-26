import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapi/data/models/movie.dart';
import 'package:movieapi/data/repository/movies_repository.dart';

part 'discover_movies_state.dart';

class DiscoverMoviesCubit extends Cubit<DiscoverMoviesState> {

  final MoviesRepository moviesRepository;
  List<Movie> movies = [];
  DiscoverMoviesCubit(this.moviesRepository) : super(DiscoverMoviesInitial());

  List<Movie> getAllDiscoverMovies(){
    moviesRepository.fetchDiscoverMovies().then((movies) {
      emit(DiscoverMoviesLoaded(movies));
      this.movies = movies;
    });
    return movies;
  }
}
