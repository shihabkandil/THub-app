part of 'movie_trailer_cubit.dart';

@immutable
abstract class MovieTrailersState {}

class MovieTrailersInitial extends MovieTrailersState {}

class MovieTrailersLoading extends MovieTrailersState{}

class MovieTrailersError extends MovieTrailersState{}


class MovieTrailersLoaded extends MovieTrailersState{
  final List<MovieTrailerModel> trailers;

  MovieTrailersLoaded(this.trailers);
}