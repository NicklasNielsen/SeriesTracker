import 'package:flutter/material.dart' as m;
import 'package:flutter/widgets.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:series_tracker/Data/data_retriever.dart';
import 'package:series_tracker/DataModels/series.dart';
import 'package:series_tracker/Widgets/focus_button.dart';
import '../Data/local_storage.dart';
import '../Widgets/series_list_item.dart';

class SeriesList extends StatelessWidget {
  SeriesList({
    DataStorage? storage,
    DataRetriever? dataFetcher,
    super.key,
  }): _storage = storage ?? LocalStorage(),
      _fetcher = dataFetcher ?? OmdbApi();

  final DataStorage _storage;
  final DataRetriever _fetcher;

  @override
  Widget build(BuildContext context) => SafeArea(
    child: ValueListenableBuilder(
      valueListenable: _storage.series,
      builder: (context, series, child) => ListView.builder(
        itemCount: series.length + 1,
        itemBuilder: (context, index) {
          if (index == series.length) {
            return FocusButton(
              unFocus: const Padding(
                padding: EdgeInsets.all(8),
                child: Center(
                  child: Icon(
                    m.Icons.add,
                    size: 32,
                    color: m.Colors.grey,
                  ),
                ),
              ),
              inFocus: (focus, unfocus) => TypeAheadField<Series>(
                focusNode: focus,
                autoFlipDirection: true,
                hideOnEmpty: true,
                itemBuilder: (context, suggestion) => m.ListTile(
                  leading: Image(image: NetworkImage(suggestion.imageUrl)),
                  title: Text(suggestion.title),
                ),
                onSelected: (input) async {
                  final series = await _fetcher.getSeriesInformation(id: input.imdbId, title: input.title);
                  _storage.add(item: series);
                  unfocus();
                },
                suggestionsCallback: (pattern) {
                  if (pattern.length < 3) {
                    return [];
                  }
                  return _fetcher.searchSeries(partName: pattern.trim());
                },
                builder: (context, controller, focusNode) {
                  listener() {if (focusNode.hasFocus == false) {
                      unfocus();
                    }}
                  focusNode.addListener(() {
                    listener();
                    focusNode.removeListener(listener);
                  });
                  return Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: m.TextField(
                      controller: controller,
                      focusNode: focusNode,
                      autofocus: true,
                      decoration: const m.InputDecoration(
                        border: m.InputBorder.none,
                        hintText: 'Enter series name',
                      ),
                    ),
                  );
                },
              ),
            );
          }
          return Dismissible(
            key: Key(series[index].id),
            onDismissed: (direction) async => await _storage.remove(series[index]),
            child: SeriesListItem(
              series: series[index],
              update: _storage.update,
            ),
          );
        },
      ),
    ),
  );
}