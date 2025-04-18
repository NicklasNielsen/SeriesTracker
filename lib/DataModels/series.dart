class Series {
  String title;
  int season;
  int episode;
  String imageUrl;
  String totalSeasons;
  String released;
  String episodeDuration;
  String actors;

  Series({required this.title, 
    required this.season, 
    required this.episode, 
    required this.imageUrl, 
    required this.totalSeasons, 
    required this.released, 
    required this.episodeDuration, 
    required this.actors,
  });

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
      'Title': title,
      'Season': season,
      'Episode': episode,
      'Poster': imageUrl,
      'totalSeasons': totalSeasons,
      'Actors': actors,
      'Released': released,
      'Runtime': episodeDuration,
    };
  }
}