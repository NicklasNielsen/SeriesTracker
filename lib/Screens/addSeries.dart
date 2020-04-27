import 'package:flutter/material.dart';
import '../Widgets/add_button.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../Data/dataStorage.dart';
import '../Data/dataRetriever.dart';

class AddSeries extends StatefulWidget {
  AddSeries({@required this.viewCb});

  final Function viewCb;

  @override
  AddSeriesState createState() => AddSeriesState();
}

class AddSeriesState extends State<AddSeries> {
  String title = "";
  int season = 1;
  int episode = 1;
  final TextEditingController _typeAheadController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Add Series"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TypeAheadField(
              textFieldConfiguration: TextFieldConfiguration(
                controller: this._typeAheadController,
                autofocus: true,
                onChanged: (input) {  this.title = input; },
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
              ),
              suggestionsCallback: (pattern) async {
                return await DataRetriever.searchSeries(pattern);
              },
              itemBuilder: (context, suggestion) {
                return ListTile(
                  title: Text(suggestion['Title']),
                );
              },
              onSuggestionSelected: (suggestion) {
                this._typeAheadController.text = suggestion["Title"];
                this.title = suggestion["Title"];
              },
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
              Flexible(
                child: TextField(
                  onChanged: (seasonIn) { this.season = int.parse(seasonIn); },
                  keyboardType: TextInputType.numberWithOptions(decimal: false, signed: false),
                  decoration: InputDecoration(
                    labelText: 'Season',
                  ),
                ),
              ),
              const SizedBox(width: 30.0,),
              Flexible(
                child: TextField(
                  onChanged: (episodeIn) { this.episode = int.parse(episodeIn); },
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
        text: "Save",
        onPressed: () async {
            var series = await DataRetriever.getSeriesInformation(title);
            series.season = this.season;
            series.episode = this.episode;
            DataStorage.add(series);
            widget.viewCb(0);
        }
      ),
    );
  }
}