import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapi/data/models/movie_model.dart';
import 'package:movieapi/data/repository/movies_categories_repository.dart';
part 'top_rated_movies_state.dart';
class TopRatedMoviesCubit extends Cubit<TopRatedMoviesState> {

  final MoviesCategoryRepository moviesRepository;
  List<MovieModel> movies = [];
  TopRatedMoviesCubit(this.moviesRepository) : super(TopRatedMoviesInitial());

  List<MovieModel> getAllTopRatedMovies(){
    moviesRepository.fetchTopRatedMovies().then((movies) {
      emit(TopRatedMoviesLoaded(movies));
      this.movies = movies;
    });
    return movies;
  }
}
