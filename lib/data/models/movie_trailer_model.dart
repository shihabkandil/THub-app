class MovieTrailerModel {
  late String name;
  late String key;
  late DateTime publishedAt;
  late String site;
  late String id;

  MovieTrailerModel(
        this.name,
        this.key,
        this.publishedAt,
        this.site,
        this.id
      );

  MovieTrailerModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    key = json['key'];
    publishedAt = DateTime.parse(json["published_at"]);
    site = json['site'];
    id = json['id'];
  }
}