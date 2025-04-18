import 'package:flutter/material.dart';
import 'package:series_tracker/Screens/add_series.dart';
import 'package:series_tracker/Screens/series_list.dart';

class SeriesTracker extends StatefulWidget {
  const SeriesTracker({super.key, required this.title});

  final String title;

  @override
  SeriesTrackerState createState() => SeriesTrackerState();
}

class SeriesTrackerState extends State<SeriesTracker> {
  late int _selectedIndex;
  late List<Widget> _widgets;

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
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: "Add",
          ),
          //Sort??
        ],
      ),
    );
  }
}