import 'package:movieapi/constants/strings.dart';
import 'package:movieapi/data/models/movie_model.dart';
import 'package:movieapi/data/web_services/movies_web_service.dart';

import '../../helper/filtering_data.dart';

class MoviesCategoryRepository{
  final MovieWebService movieWebService;

  late List<MovieModel>movies;
  MoviesCategoryRepository(this.movieWebService);

  Future<List<MovieModel>> fetchMovies({required String moviesQuery})async{
    final moviesResults = await movieWebService.getAllMovies(query:moviesQuery);
    movies = moviesResults['results'].map<MovieModel>((json) => MovieModel.fromJson(json)).toList();
    movies = DataFilter.filterResultsByGenreIds(movies);
    movies = DataFilter.removeWhereNoPosterImage(movies);
    return movies;
  }
}
