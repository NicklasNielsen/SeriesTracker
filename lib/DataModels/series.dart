import 'dart:math';

import 'package:flutter/cupertino.dart';

class Series {
  Series({
    this.imdbId,
    required this.title,
    required this.imageUrl,
    int? season,
    int? episode,
    this.totalSeasons,
    this.released,
    this.episodeDuration,
    this.actors,
  }): season = ValueNotifier(season ?? 1), episode = ValueNotifier(episode ?? 1), id = generateGuid();

  factory Series.fromJson(Map<String, dynamic> json) {
  return Series(
    imdbId: json['imdbID'],
    title: json['Title'],
    imageUrl: json['Poster'],
    season: json['Season'],
    episode: json['Episode'],
    totalSeasons: json['totalSeasons'],
    actors: json['Actors'],
    released: json['Released'],
    episodeDuration: json['Runtime']);
  }

  final String id;
  final String? imdbId;
  final String title;
  final String imageUrl;
  final ValueNotifier<int> season;
  final ValueNotifier<int> episode;
  final String? totalSeasons;
  final String? released;
  final String? episodeDuration;
  final String? actors;

  Map<String, dynamic> toJson() => {
    'imdbID': imdbId,
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

String generateGuid() {
  final random = Random();
  const chars = 'abcdef0123456789';

  String segment(int length) => List.generate(length, (index) => chars[random.nextInt(chars.length)]).join();

  return '${segment(8)}-${segment(4)}-4${segment(3)}-${['8', '9', 'a', 'b'][random.nextInt(4)]}${segment(3)}-${segment(12)}';
}