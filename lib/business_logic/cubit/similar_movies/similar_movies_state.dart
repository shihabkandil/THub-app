part of 'similar_movies_cubit.dart';
@immutable
abstract class SimilarMoviesState {}

class SimilarMoviesInitial extends SimilarMoviesState {}

class SimilarMoviesLoading extends SimilarMoviesState{}

class SimilarMoviesError extends SimilarMoviesState{}

class SimilarMoviesLoaded extends SimilarMoviesState{
  final List<MovieModel> similarMovies;
  SimilarMoviesLoaded(this.similarMovies);
}
