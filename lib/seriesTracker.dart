import 'package:flutter/material.dart';
import 'package:series_tracker/Screens/addSeries.dart';
import 'package:series_tracker/Screens/seriesList.dart';

class SeriesTracker extends StatefulWidget {
  SeriesTracker({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SeriesTrackerState createState() => _SeriesTrackerState();
}

class _SeriesTrackerState extends State<SeriesTracker> {
  var _selectedIndex;
  var _widgets;

  @override
  void initState() {
    _selectedIndex = 0;
    _widgets = [
      SeriesList(),
      AddSeries(viewCb: _onScreenSelectionClick,)
    ];
    super.initState();
  }

  void _onScreenSelectionClick(int index) {
    setState(() {
      _selectedIndex = index > 1 ? 0 : index;
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _widgets[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onScreenSelectionClick,
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            title: Text("Add"),
          ),
          //Sort??
        ],
      ),
    );
  }
}