import 'package:flutter/cupertino.dart';

class Series {
  Series({
    this.id,
    required this.title,
    required this.imageUrl,
    int? season,
    int? episode,
    this.totalSeasons,
    this.released,
    this.episodeDuration,
    this.actors,
  }): season = ValueNotifier(season ?? 1), episode = ValueNotifier(episode ?? 1);

  factory Series.fromJson(Map<String, dynamic> json) {
  return Series(
    id: json['imdbID'],
    title: json['Title'],
    imageUrl: json['Poster'],
    season: json['Season'],
    episode: json['Episode'],
    totalSeasons: json['totalSeasons'],
    actors: json['Actors'],
    released: json['Released'],
    episodeDuration: json['Runtime']);
  }

  String? id;
  String title;
  String imageUrl;
  ValueNotifier<int> season;
  ValueNotifier<int> episode;
  String? totalSeasons;
  String? released;
  String? episodeDuration;
  String? actors;

  Map<String, dynamic> toJson() => {
    'imdbID': id,
    'Title': title,
    'Poster': imageUrl,
    'Season': season.value,
    'Episode': episode.value,
    'totalSeasons': totalSeasons,
    'Released': released,
    'Runtime': episodeDuration,
    'Actors': actors,
  };
}