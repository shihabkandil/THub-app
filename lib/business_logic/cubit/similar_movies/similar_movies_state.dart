part of 'movie_details_cubit.dart';
@immutable
abstract class SimilarMoviesState {}

class SimilarMoviesInitial extends SimilarMoviesState {}

class SimilarMoviesLoading extends SimilarMoviesState{}

class MovieTrailersLoading extends SimilarMoviesState{}

class SimilarMoviesError extends SimilarMoviesState{}

class MovieTrailersError extends SimilarMoviesState{}

class SimilarMoviesLoaded extends SimilarMoviesState{
  final List<MovieModel> similarMovies;
  SimilarMoviesLoaded(this.similarMovies);
}

class MovieTrailersLoaded extends SimilarMoviesState{
  final List<MovieTrailerModel> trailers;
  MovieTrailersLoaded(this.trailers);
}