import 'package:flutter/material.dart';
import './seriesTracker.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Series Tracker',
      theme: ThemeData.dark(),
      home: SeriesTracker(title: "Series Tracker",),
      debugShowCheckedModeBanner: false,
    );
  }
}
