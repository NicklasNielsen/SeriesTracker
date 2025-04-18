import 'package:flutter/material.dart';
import 'package:series_tracker/DataModels/series.dart';
import '../Widgets/add_button.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../Data/data_storage.dart';
import '../Data/data_retriever.dart';

class AddSeries extends StatefulWidget {
  const AddSeries({required this.viewCb, super.key});

  final Function viewCb;

  @override
  AddSeriesState createState() => AddSeriesState();
}

class AddSeriesState extends State<AddSeries> {
  String title = '';
  int season = 1;
  int episode = 1;
  final TextEditingController _typeAheadController = TextEditingController();  
  final SuggestionsController<Series> _suggestionsController = SuggestionsController<Series>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Series'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TypeAheadField<Series>(
              controller: _typeAheadController,
              onSelected: (input) {
                _typeAheadController.text = input.title;
                title = input.title;
              },
              suggestionsCallback: (pattern) async {
                if (pattern.length < 3) {
                  return [];
                }
                return await DataRetriever.searchSeries(pattern.trim());
              },
              itemBuilder: (context, suggestion) {
                return ListTile(
                  title: Text(suggestion.title),
                );
              },
              suggestionsController: _suggestionsController,
              builder: (context, controller, focusNode) => TextField(
                controller: controller,
                focusNode: focusNode,
                autofocus: true,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
              Flexible(
                child: TextField(
                  onChanged: (seasonIn) { season = int.parse(seasonIn); },
                  keyboardType: TextInputType.numberWithOptions(decimal: false, signed: false),
                  decoration: InputDecoration(
                    labelText: 'Season',
                  ),
                ),
              ),
              const SizedBox(width: 30.0,),
              Flexible(
                child: TextField(
                  onChanged: (episodeIn) { episode = int.parse(episodeIn); },
                  keyboardType: TextInputType.numberWithOptions(decimal: false, signed: false),
                  decoration: InputDecoration(
                    labelText: 'Episode',
                  ),
                ),
              )
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: AddButton(
        text: 'Save',
        onPressed: () async {
            var series = await DataRetriever.getSeriesInformation(title);
            series.season.value = season;
            series.episode.value = episode;
            DataStorage.add(series);
            widget.viewCb(0);
        }
      ),
    );
  }
}