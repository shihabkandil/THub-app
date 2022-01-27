class MovieModel{
  late int id;
  late String overview;
  late String posterPath;
  late dynamic backdrop_path;
  late String releaseDate;
  late String title;
  late dynamic vote_average;
  late dynamic votes_count;
  late dynamic popularity;

  MovieModel(
      this.id,
      this.overview,
      this.posterPath,
      this.releaseDate,
      this.title,
      this.popularity,
      this.vote_average,
      this.backdrop_path,
      this.votes_count
      );

  MovieModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    overview = json['overview'];
    posterPath = json['poster_path'];
    backdrop_path = json["backdrop_path"];
    releaseDate = json['release_date'];
    title = json['title'];
    popularity = json["popularity"];
    vote_average = json["vote_average"];
    votes_count = json["vote_count"];
  }
}