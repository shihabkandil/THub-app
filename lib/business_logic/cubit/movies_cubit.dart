import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movieapi/data/models/movie.dart';
import 'package:movieapi/data/repository/movies_repository.dart';
part 'movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {

  final MoviesRepository moviesRepository;
  late List<Movie> movies;
  MoviesCubit(this.moviesRepository) : super(MoviesInitial());

  List<Movie> getAllMovies(){
    moviesRepository.fetchMovies().then((movies) {
      emit(MoviesLoaded(movies));
      this.movies = movies;
    });
    return movies;
  }
}
