import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapi/data/models/movie.dart';
import 'package:movieapi/data/repository/movies_repository.dart';

part 'upcoming_movies_state.dart';

class UpcomingMoviesCubit extends Cubit<UpcomingMoviesState> {

  final MoviesRepository moviesRepository;
  List<Movie> movies = [];
  UpcomingMoviesCubit(this.moviesRepository) : super(UpcomingMoviesInitial());

  List<Movie> getAllUpcomingMovies(){
    moviesRepository.fetchUpcomingMovies().then((movies) {
      emit(UpcomingMoviesLoaded(movies));
      this.movies = movies;
    });
    return movies;
  }
}
