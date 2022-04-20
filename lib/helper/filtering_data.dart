


import '../constants/strings.dart';
import '../data/models/movie_model.dart';

class DataFilter{
  static List<MovieModel> filterResultsByGenreIds(List<MovieModel> movies){
    checkId(int id) => (FilterByIDs.contains(id));
    movies.removeWhere((element) => element.genresIds.any(checkId) && !element.genresIds.contains(FamilyGenreId));
    return movies;
  }

  static List<MovieModel> removeWhereNoPosterImage(List<MovieModel> movies){
    movies.removeWhere((element) => element.posterPath == '');
    return movies;
  }
}