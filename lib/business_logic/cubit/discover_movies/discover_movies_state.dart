part of 'discover_movies_cubit.dart';

@immutable
abstract class DiscoverMoviesState {}

class DiscoverMoviesInitial extends DiscoverMoviesState {}

class DiscoverMoviesLoaded extends DiscoverMoviesState{
  final List<Movie> discoverMovies;

  DiscoverMoviesLoaded(this.discoverMovies);
}