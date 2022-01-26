part of 'upcoming_movies_cubit.dart';
@immutable
abstract class UpcomingMoviesState {}

class UpcomingMoviesInitial extends UpcomingMoviesState {}

class UpcomingMoviesLoaded extends UpcomingMoviesState{
  final List<Movie> upcomingMovies;

  UpcomingMoviesLoaded(this.upcomingMovies);
}