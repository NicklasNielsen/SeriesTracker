import 'package:flutter/material.dart';
import 'package:series_tracker/DataModels/series.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../Data/local_storage.dart';
import '../Data/data_retriever.dart';

class AddSeries extends StatelessWidget {
  AddSeries({
    required DataStorage storage,
    required DataRetriever dataRetriever,
    SuggestionsController<Series>? suggestionsController,
    super.key
  }): _series = ValueNotifier(null),
      _dataRetriever = dataRetriever,
      _storage = storage;

  final ValueNotifier<Series?> _series;
  final DataRetriever _dataRetriever;
  final DataStorage _storage;
  
  @override
  Widget build(BuildContext context) => Material(
    child: Padding(
      padding: MediaQuery.of(context).padding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TypeAheadField<Series>(
            itemBuilder: (context, suggestion) => Padding(
              padding: EdgeInsets.all(8),
              child: ListTile(
                leading: Image(image: NetworkImage(suggestion.imageUrl),),
                title: Text(suggestion.title),
              ),
            ),
            onSelected: (input) async {
              final navigator = Navigator.of(context);
              final series = await _dataRetriever.getSeriesInformation(id: input.imdbId, title: input.title);
              _storage.add(item: series);
              if (navigator.canPop()) {
                navigator.pop();
              }
            },
            suggestionsCallback: (pattern) {
              if (pattern.length < 3) {
                return [];
              }
              return _dataRetriever.searchSeries(partName: pattern.trim());
            },
            builder: (context, controller, focusNode) => Row(
              children: [
                Padding(padding: MediaQuery.of(context).padding,
                  child: ValueListenableBuilder(
                    valueListenable: _series, 
                    builder: (context, series, _) => series != null ? Image(
                      image: NetworkImage(series.imageUrl),
                    ) : SizedBox.shrink(),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: TextField(
                      controller: _series.value?.title != null ? (controller..text = _series.value!.title) : controller,
                      focusNode: focusNode,
                      autofocus: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}