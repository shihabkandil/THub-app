part of 'now_playing_movies_cubit.dart';
@immutable
abstract class NowPlayingMoviesState {}

class NowPlayingMoviesInitial extends NowPlayingMoviesState {}

class NowPlayingMoviesLoaded extends NowPlayingMoviesState{
  final List<Movie> nowPlayingMovies;

  NowPlayingMoviesLoaded(this.nowPlayingMovies);
}