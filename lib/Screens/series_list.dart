import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:series_tracker/Data/data_retriever.dart';
import 'package:series_tracker/Screens/add_series.dart';
import '../Data/local_storage.dart';
import '../Widgets/series_list_item.dart';

class SeriesList extends StatelessWidget {
  SeriesList({
    DataStorage? storage,
    DataRetriever? dataFetcher,
    super.key,
  }): storage = storage ?? LocalStorage(),
      _fetcher = dataFetcher ?? OmdbApi();

  final DataStorage storage;
  final DataRetriever _fetcher;

  @override
  Widget build(BuildContext context) => SafeArea(
    child: ValueListenableBuilder(
      valueListenable: storage.series,
      builder: (context, series, child) => ListView.builder(
        itemCount: series.length + 1,
        itemBuilder: (context, index) {
          if (index == series.length) {
            return Padding(
              padding: EdgeInsets.all(8),
              child: GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddSeries(storage: storage, dataRetriever: _fetcher))),
                child: Stack(
                  children: [
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Icon(Icons.add, size: 30, color: Colors.grey),
                      ),
                    ),
                    Positioned.fill(
                      child: CustomPaint(painter: DashPainter()),
                    ),
                  ],
                ),
              ),
            );
          }
          return Dismissible(
            key: Key(series[index].id),
            onDismissed: (direction) async => await storage.remove(series[index]),
            child: SeriesListItem(series: series[index], update: storage.update),
          );
        },
      ),
    ),
  );
}

class DashPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    Path path = Path()
      ..addRRect(RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height), Radius.circular(16)));

    Path dashedPath = Path();
    double totalLength = path.computeMetrics().map((m) => m.length).reduce((a, b) => a + b);
    int dashCount = (totalLength / (8 + 4)).round();

    double dashWidth = totalLength / (dashCount * 2);
    double dashSpace = dashWidth;
    double distance = 0;

    for (PathMetric metric in path.computeMetrics()) {
      while (distance < metric.length) {
        dashedPath.addPath(metric.extractPath(distance, distance + dashWidth), Offset.zero);
        distance += dashWidth + dashSpace;
      }
    }

    canvas.drawPath(dashedPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}