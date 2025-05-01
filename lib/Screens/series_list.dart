import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:series_tracker/Data/data_retriever.dart';
import 'package:series_tracker/DataModels/series.dart';
import '../Data/local_storage.dart';
import '../Widgets/series_list_item.dart';

class SeriesList extends StatelessWidget {
  SeriesList({
    DataStorage? storage,
    DataRetriever? dataFetcher,
    super.key,
  }): _storage = storage ?? LocalStorage(),
      _fetcher = dataFetcher ?? OmdbApi(),
      _hasFocus = ValueNotifier(null);

  final ValueNotifier<FocusNode?> _hasFocus;
  final DataStorage _storage;
  final DataRetriever _fetcher;

  Widget addField() {
    return ValueListenableBuilder(valueListenable: _hasFocus, builder: (context, focus, _) => focus != null ? TypeAheadField<Series>(
      focusNode: focus,
      autoFlipDirection: true,
      itemBuilder: (context, suggestion) => ListTile(
        leading: Image(image: NetworkImage(suggestion.imageUrl),),
        title: Text(suggestion.title),
      ),
      hideOnEmpty: true,
      onSelected: (input) async {
        final series = await _fetcher.getSeriesInformation(id: input.imdbId, title: input.title);
        _storage.add(item: series);
        _hasFocus.value = null;
      },
      suggestionsCallback: (pattern) {
        if (pattern.length < 3) {
          return [];
        }
        return _fetcher.searchSeries(partName: pattern.trim());
      },
      builder: (context, controller, focusNode) {
        focusNode.addListener(() {if (focusNode.hasFocus == false) _hasFocus.value = null;});
        return TextField(
          controller: controller,
          focusNode: focusNode,
          autofocus: true,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Enter series name',
          ),
        );
      },
    ): const Icon(Icons.add, size: 30, color: Colors.grey));
  }

  @override
  Widget build(BuildContext context) => SafeArea(
    child: ValueListenableBuilder(
      valueListenable: _storage.series,
      builder: (context, series, child) => ListView.builder(
        itemCount: series.length + 1,
        itemBuilder: (context, index) {
          if (index == series.length) {
            return GestureDetector(
              behavior: HitTestBehavior.deferToChild,
              onTap: () => _hasFocus.value = FocusNode(),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Stack(
                  children: [
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: addField(),
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
            onDismissed: (direction) async => await _storage.remove(series[index]),
            child: SeriesListItem(series: series[index], update: _storage.update),
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