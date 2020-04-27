import 'package:flutter/material.dart';
import '../DataModels/series.dart';
import '../Data/dataStorage.dart';
import '../Widgets/seriesListItem.dart';

class SeriesList extends StatefulWidget {
  @override
  SeriesListState createState() => SeriesListState();
}

class SeriesListState extends State<SeriesList> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: SafeArea(
            child: FutureBuilder<List<Series>>(
                future: DataStorage.getSeries(sortFunc: (Series a, Series b) => a.title.compareTo(b.title),),
                builder: (context, seriesData) {
                  if (seriesData.connectionState == ConnectionState.done) {
                    return ListView.builder(
                        itemCount: DataStorage.series.length,
                        itemBuilder: (context, i) => Dismissible(
                            key: Key(DataStorage.series[i].toString()),
                            onDismissed: (direction) {
                              setState(() {
                                DataStorage.remove(DataStorage.series[i]);
                              });
                            },
                            child: SeriesListItem(series: DataStorage.series[i])
                        )
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }
            )
        )
    );
  }
}
