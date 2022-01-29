import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapi/constants/strings.dart';
import 'package:movieapi/data/models/movie_model.dart';
import 'package:movieapi/data/repository/movies_categories_repository.dart';

part 'upcoming_movies_state.dart';

class UpcomingMoviesCubit extends Cubit<UpcomingMoviesState> {

  final MoviesCategoryRepository moviesRepository;
  List<MovieModel> movies = [];
  UpcomingMoviesCubit(this.moviesRepository) : super(UpcomingMoviesInitial());

  List<MovieModel> getAllUpcomingMovies(){
    moviesRepository.fetchMovies(moviesQuery:UpcomingMoviesQuery).then((movies) {
      emit(UpcomingMoviesLoaded(movies));
      this.movies = movies;
    });
    return movies;
  }
}
