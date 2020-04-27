import 'package:flutter/material.dart';
import '../DataModels/series.dart';
import '../Data/dataStorage.dart';

class SeriesDetails extends StatelessWidget {
  final Series series;
  final double height = 150;
  
  SeriesDetails({this.series});

  @override
  Widget build(BuildContext context) {
    ThemeData localtheme = Theme.of(context);

    return SimpleDialog(
      contentPadding: EdgeInsets.zero,
      children: <Widget>[
        Image.network(
          series.imageUrl,
          fit: BoxFit.fill,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(series.title, style: localtheme.textTheme.display1,),
              getSubtitle(series),
              SizedBox(height: 16.0,),
              Text('Episode duration: ${series.episodeDuration}'),
              Text('Total seasons: ${series.totalSeasons}'),
              Text('Released: ${series.released}'),
              Text('Actors: ${series.actors}'),
            ],
          ),
        )
      ],
    );
  }
}


getSubtitle(Series series) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Text('Season: '),
      Flexible(
        child: TextField(
          onChanged: (seasonIn) { 
            DataStorage.update(series, int.parse(seasonIn), 0);
          },
          keyboardType: TextInputType.numberWithOptions(decimal: false, signed: false),
          decoration: InputDecoration(
            hintText: '${series.season}',
            border: InputBorder.none,
          ),
        ),
      ),
      const SizedBox(width: 30.0,),
      Text('Episode: '),
      Flexible(
        child: TextField(
          onChanged: (episodeIn) { 
            DataStorage.update(series, 0, int.parse(episodeIn));
          },
          keyboardType: TextInputType.numberWithOptions(decimal: false, signed: false),
          decoration: InputDecoration(
            hintText: '${series.episode}',
            border: InputBorder.none,
          ),
        ),
      )
    ],
  );
}