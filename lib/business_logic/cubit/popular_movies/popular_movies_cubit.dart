import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapi/constants/strings.dart';
import 'package:movieapi/data/models/movie_model.dart';
import 'package:movieapi/data/repository/movies_categories_repository.dart';

part 'popular_movies_state.dart';
class PopularMoviesCubit extends Cubit<PopularMoviesState> {

  final MoviesCategoryRepository moviesRepository;
  List<MovieModel> movies = [];
  PopularMoviesCubit(this.moviesRepository) : super(PopularMoviesInitial());

  List<MovieModel> getAllPopularMovies(){
    moviesRepository.fetchMovies(moviesQuery:PopularMoviesQuery).then((movies) {
      emit(PopularMoviesLoaded(movies));
      this.movies = movies;
    });
    return movies;
  }
}
