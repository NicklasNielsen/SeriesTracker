import 'package:flutter/material.dart';
import '../DataModels/series.dart';
import '../Data/data_storage.dart';
import '../Widgets/series_list_item.dart';

class SeriesList extends StatelessWidget {
  const SeriesList({super.key});

  @override
  Widget build(BuildContext context) => SafeArea(
      child: FutureBuilder<List<Series>>(
          future: DataStorage.getSeries(sortFunc: (Series a, Series b) => a.title.compareTo(b.title),),
          builder: (context, seriesData) {
            if (seriesData.connectionState == ConnectionState.done) {
              return ListView.builder(
                  itemCount: DataStorage.series.length,
                  itemBuilder: (context, i) => Dismissible(
                      key: Key(DataStorage.series[i].toString()),
                      onDismissed: (direction) {
                          DataStorage.remove(DataStorage.series[i]);
                      },
                      child: SeriesListItem(series: DataStorage.series[i])
                  )
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }
      )
  );
}
