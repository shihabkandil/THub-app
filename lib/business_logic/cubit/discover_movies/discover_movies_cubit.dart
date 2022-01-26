import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapi/data/models/movie_model.dart';
import 'package:movieapi/data/repository/movies_categories_repository.dart';

part 'discover_movies_state.dart';

class DiscoverMoviesCubit extends Cubit<DiscoverMoviesState> {

  final MoviesCategoryRepository moviesRepository;
  List<MovieModel> movies = [];
  DiscoverMoviesCubit(this.moviesRepository) : super(DiscoverMoviesInitial());

  List<MovieModel> getAllDiscoverMovies(){
    moviesRepository.fetchDiscoverMovies().then((movies) {
      emit(DiscoverMoviesLoaded(movies));
      this.movies = movies;
    });
    return movies;
  }
}
