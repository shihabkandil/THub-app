part of 'popular_movies_cubit.dart';

@immutable
abstract class PopularMoviesState {}

class PopularMoviesInitial extends PopularMoviesState {}

class PopularMoviesLoaded extends PopularMoviesState{
  final List<Movie> popularMovies;

  PopularMoviesLoaded(this.popularMovies);
}