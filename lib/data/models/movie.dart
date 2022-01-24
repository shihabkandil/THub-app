class Movie{
  late String movieID;
  late String title;
  late String overview;
  late String posterImgPath;
  late String releaseDate;

  Movie(this.movieID,
      this.title,
      this.overview,
      this.posterImgPath,
      this.releaseDate);

  Movie.fromJson(Map<String,dynamic>json){
    movieID = json["id"];
    title = json["title"];
    overview = json["overview"];
    posterImgPath = json["poster_path"];
    releaseDate = json["release_date"];
  }

}