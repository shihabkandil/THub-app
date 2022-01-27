part of 'movie_details_cubit.dart';
@immutable
abstract class MovieDetailsState {}

class MovieDetailsInitial extends MovieDetailsState {}

class SimilarMoviesLoading extends MovieDetailsState{}

class MovieTrailersLoading extends MovieDetailsState{}

class SimilarMoviesError extends MovieDetailsState{}

class MovieTrailersError extends MovieDetailsState{}

class SimilarMoviesLoaded extends MovieDetailsState{
  final List<MovieModel> similarMovies;
  SimilarMoviesLoaded(this.similarMovies);
}

class MovieTrailersLoaded extends MovieDetailsState{
  final List<MovieTrailerModel> trailers;
  MovieTrailersLoaded(this.trailers);
}