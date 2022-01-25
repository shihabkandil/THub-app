class Movie{
  late int id;
  late String overview;
  late String posterPath;
  late String releaseDate;
  late String title;

  Movie(this.id, this.overview,  this.posterPath, this.releaseDate, this.title);

  Movie.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    overview = json['overview'];
    posterPath = json['poster_path'];
    releaseDate = json['release_date'];
    title = json['title'];
  }
}