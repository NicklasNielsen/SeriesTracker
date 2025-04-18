import 'package:flutter/material.dart';
import '../DataModels/series.dart';
import '../Data/data_storage.dart';
import '../Screens/series_details.dart';

class SeriesListItem extends StatelessWidget {
  const SeriesListItem({required this.series, super.key});
  
  final Series series;

  @override
  Widget build(BuildContext context) => ListTile(
        onLongPress: () {
          DataStorage.update(series, 0, series.episode + 1);
        },
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SeriesDetails(series: series))),
        leading: Image(
          image: NetworkImage(series.imageUrl)),
        title: Text(series.title),
        subtitle: Text('Season: ${series.season.toString()}, Episode: ${series.episode.toString()}'),
        );
}