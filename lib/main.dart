import 'package:flutter/material.dart';
import 'series_tracker.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
