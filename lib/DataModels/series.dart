class Series {
  String title;
  int season;
  int episode;
  String imageUrl;
  String totalSeasons;
  String released;
  String episodeDuration;
  String actors;

  Series({this.title, this.season, this.episode, this.imageUrl, this.totalSeasons, this.released, this.episodeDuration, this.actors});

  factory Series.fromJson(Map<String, dynamic> json) {
  return Series(
    title: json['Title'],
    season: json['Season'],
    episode: json['Episode'],
    imageUrl: json['Poster'],
    totalSeasons: json['totalSeasons'],
    actors: json['Actors'],
    released: json['Released'],
    episodeDuration: json['Runtime']);
  }

  Map<String, dynamic> toJson() {
    return {
      'Title': this.title,
      'Season': this.season,
      'Episode': this.episode,
      'Poster': this.imageUrl,
      'totalSeasons': this.totalSeasons,
      'Actors': this.actors,
      'Released': this.released,
      'Runtime': this.episodeDuration
    };
  }
}