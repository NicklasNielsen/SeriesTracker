import 'package:flutter/material.dart';
import '../DataModels/series.dart';
import '../Data/dataStorage.dart';
import '../Screens/seriesDetails.dart';

class SeriesListItem extends StatefulWidget {
  final Series series;

  SeriesListItem({@required this.series});
  
  @override
  SeriesListItemState createState() => SeriesListItemState(series: series);
}

class SeriesListItemState extends State<SeriesListItem> {
  final Series series;

  SeriesListItemState({@required this.series});

  @override
  Widget build(BuildContext context){
    return Container(
      child: ListTile(
        onLongPress: () {
          DataStorage.update(series, 0, series.episode + 1);
          setState(() {});
        },
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SeriesDetails(series: series))),
        leading: Image(
          image: NetworkImage(series.imageUrl == null ? "" : series.imageUrl)),
        title: Text(series.title),
        subtitle: Text("Season: ${series.season.toString()}, Episode: ${series.episode.toString()}"),
        ),
      );
  }
}