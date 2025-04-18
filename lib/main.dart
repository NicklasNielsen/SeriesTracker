import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'series_tracker.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final String title = 'Series Tracker';


  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS || Platform.isMacOS) {
      return CupertinoApp(
        title: title,
        home: SeriesTracker(title: title),
        theme: CupertinoThemeData(brightness: Brightness.dark),
        debugShowCheckedModeBanner: false,
      );
    }

    return MaterialApp(
      title: title,
      theme: ThemeData.dark(),
      home: SeriesTracker(title: title),
      debugShowCheckedModeBanner: false,
    );
  }
}