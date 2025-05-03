import 'package:flutter/material.dart';
import '../DataModels/series.dart';
import '../Screens/series_details.dart';

class SeriesListItem extends StatelessWidget {
  const SeriesListItem({
    required this.series,
    required this.update,
    super.key,
  });
  
  final Series series;
  final void Function(Series, {int? season, int? episode}) update;

  @override
  Widget build(BuildContext context) => ListTile(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SeriesDetails(series: series, update: update))),
        onLongPress: () => update(series, episode: series.episode.value + 1),
        leading: Image(
          image: NetworkImage(series.imageUrl),
        ),
        title: Text(series.title),
        subtitle: ValueListenableBuilder(
          valueListenable: series.season,
          builder: (context, season, _) => ValueListenableBuilder(
              valueListenable: series.episode,
              builder: (context, episode, _) => Text('Season: $season, Episode: $episode'),
            ),
          ),
        );
}