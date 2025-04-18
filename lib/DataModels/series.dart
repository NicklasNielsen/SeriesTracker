import 'package:flutter/cupertino.dart';

class Series {
  String title;
  ValueNotifier<int> season;
  ValueNotifier<int> episode;
  String imageUrl;
  String? totalSeasons;
  String? released;
  String? episodeDuration;
  String? actors;

  Series({required this.title, 
    int? season, 
    int? episode, 
    required this.imageUrl, 
    this.totalSeasons, 
    this.released, 
    this.episodeDuration, 
    this.actors,
  }): season = ValueNotifier(season ?? 1), episode = ValueNotifier(episode ?? 1);

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