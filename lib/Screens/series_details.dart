import 'package:flutter/material.dart';
import '../DataModels/series.dart';

class SeriesDetails extends StatelessWidget {
  const SeriesDetails({
    required this.series,
    required this.update,
    super.key,
  });

  final Series series;
  final void Function(Series, {int? season, int? episode}) update;

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
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(series.title, style: localtheme.textTheme.displayMedium,),
              getSubtitle(series, update),
              SizedBox(height: 16,),
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


getSubtitle(Series series, void Function(Series, {int? season, int? episode}) update) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Text('Season: '),
      Flexible(
        child: ValueListenableBuilder(valueListenable: series.season, builder: (context, season, child) => TextField(
            onChanged: (seasonIn) => update(series, season: int.parse(seasonIn)),
            keyboardType: TextInputType.numberWithOptions(decimal: false, signed: false),
            decoration: InputDecoration(
              hintText: '${series.season.value}',
              border: InputBorder.none,
            ),
          ),
        ),
      ),
      const SizedBox(width: 30.0,),
      Text('Episode: '),
      Flexible(
        child: ValueListenableBuilder(valueListenable: series.episode, builder: (context, episode, child) => TextField(
            onChanged: (episodeIn) => update(series, episode: int.parse(episodeIn)),
            keyboardType: TextInputType.numberWithOptions(decimal: false, signed: false),
            decoration: InputDecoration(
              hintText: '${series.episode.value}',
              border: InputBorder.none,
            ),
          ),
        ),
      )
    ],
  );
}